package co.edu.unal.paralela;

import java.util.concurrent.Phaser;

/**
 * Clase que envuelve para implementar promedio iterativo usando
 * phasers de java.
 */
public final class OneDimAveragingPhaser {
    /**
     * Constructor por defecto.
     */
    private OneDimAveragingPhaser() {
    }

    /**
     * Implementación secuencial de un promedio iteractivo unidimensional.
     *
     * @param iterations El número de iteraciones que deben ser ejecutadas
     * @param myNew Un arreglo 'double' que inicia como el arreglo de salida
     * @param myVal Un arreglo 'double' que contiene la entrada inicial
     *        del problema del promedio iterativo 
     * @param n El tamaño de este problema
     */
    public static void runSequential(final int iterations, final double[] myNew,
            final double[] myVal, final int n) {
        double[] next = myNew;
        double[] curr = myVal;

        for (int iter = 0; iter < iterations; iter++) {
            for (int j = 1; j <= n; j++) {
                next[j] = (curr[j - 1] + curr[j + 1]) / 2.0;
            }
            double[] tmp = curr;
            curr = next;
            next = tmp;
        }
    }

    /**
     * Un ejemplo de implmentación paralela de promedio iterativo unidimiensional
     * que utiliza phasers como una barrera simple (arriveAndAwaitAdvance).
     *
     * @param iterations El número de iteraciones que deben ser ejecutadas
     * @param myNew Un arreglo 'double' que inicia como el arreglo de salida
     * @param myVal Un arreglo 'double' que contiene la entrada inicial
     *        del problema del promedio iterativo 
     * @param tasks El número de hilos/tareas para procesar 
     */
    public static void runParallelBarrier(final int iterations,
            final double[] myNew, final double[] myVal, final int n,
            final int tasks) {
        Phaser ph = new Phaser(0);
        ph.bulkRegister(tasks);

        Thread[] threads = new Thread[tasks];

        for (int ii = 0; ii < tasks; ii++) {
            final int i = ii;

            threads[ii] = new Thread(() -> {
                double[] threadPrivateMyVal = myVal;
                double[] threadPrivateMyNew = myNew;

                for (int iter = 0; iter < iterations; iter++) {
                    final int left = i * (n / tasks) + 1;
                    final int right = (i + 1) * (n / tasks);

                    for (int j = left; j <= right; j++) {
                        threadPrivateMyNew[j] = (threadPrivateMyVal[j - 1]
                            + threadPrivateMyVal[j + 1]) / 2.0;
                    }
                    ph.arriveAndAwaitAdvance();

                    double[] temp = threadPrivateMyNew;
                    threadPrivateMyNew = threadPrivateMyVal;
                    threadPrivateMyVal = temp;
                }
            });
            threads[ii].start();
        }

        for (int ii = 0; ii < tasks; ii++) {
            try {
                threads[ii].join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Un ejemplo de implmentación paralela de promedio iterativo unidimiensional
     * que utiliza los APIs phasers.arrive y Phaser.awaitAdvance para traslapar 
     * la computación con "barrier completion".
     *
     * PARA HACER: Completar este método basado en los métodos runSequential y
     * runParallelBarrier.
     *
     * @param iterations El número de iteraciones que deben ser ejecutadas
     * @param myNew Un arreglo 'double' que inicia como el arreglo de salida
     * @param myVal Un arreglo 'double' que contiene la entrada inicial
     *        del problema del promedio iterativo 
     * @param tasks El número de hilos/tareas para procesar 
     */
    public static void runParallelFuzzyBarrier(final int iterations,
        final double[] myNew, final double[] myVal, final int n,
        final int tasks) {

    // Un Phaser por tarea, con 1 “party” registrada (el propio hilo)
    Phaser[] phs = new Phaser[tasks];
    for (int i = 0; i < tasks; i++) {
        phs[i] = new Phaser(1);
    }

    Thread[] threads = new Thread[tasks];

    for (int ii = 0; ii < tasks; ii++) {
        final int i = ii;

        threads[ii] = new Thread(() -> {
            double[] threadPrivateMyVal = myVal;
            double[] threadPrivateMyNew = myNew;

            for (int iter = 0; iter < iterations; iter++) {
                // Fase actual de ESTE hilo (antes de llegar)
                int phase = phs[i].getPhase();

                final int left  = i * (n / tasks) + 1;
                final int right = (i + 1) * (n / tasks);

                // Cálculo del promedio iterativo en mi bloque
                for (int j = left; j <= right; j++) {
                    threadPrivateMyNew[j] = (threadPrivateMyVal[j - 1]
                                           + threadPrivateMyVal[j + 1]) / 2.0;
                }

                // Anuncio que terminé esta iteración
                phs[i].arrive();

                // Espero a que mis vecinos también hayan terminado esta iteración
                if (i > 0) {
                    phs[i - 1].awaitAdvance(phase);
                }
                if (i < tasks - 1) {
                    phs[i + 1].awaitAdvance(phase);
                }

                // Intercambio de roles entre arrays
                double[] temp = threadPrivateMyNew;
                threadPrivateMyNew = threadPrivateMyVal;
                threadPrivateMyVal = temp;
            }
        });
        threads[ii].start();
    }

    // Esperar a que terminen todos los hilos
    for (int ii = 0; ii < tasks; ii++) {
        try {
            threads[ii].join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
}
