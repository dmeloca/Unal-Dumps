import random

MESSAGE: str = "0101"
NOISE_PROBABILITY: float  = 0.3
TRIES: int = 10
MESSAGE_LENGTH: int = 4
CODE_LENGTH: int = 7

class Coder:
    """
    Class representing a message coder
    """
    def encode(self, message: str) -> str:
        """
        Encode the message using the linear equations method.
        (x_0, x_1, x_2, x_3) -> (x_0, x_1, x_2, x_3, x_1+x_2+x_3, x_0+x_2+x_3, x_0+x_1+x_2)
        
        Arguments:
            self -> Class
            message: str -> Message to encode
        Returns:
            encoded_message: str 
        """
        assert len(message) == MESSAGE_LENGTH, "The message length should be {MESSAGE_LENGTH}"
        return (message +
                str((int(message[1])+int(message[2])+int(message[3]))%2)+
                str((int(message[0])+int(message[2])+int(message[3]))%2)+
                str((int(message[0])+int(message[1])+int(message[2]))%2))

class Channel:
    """
    Class that emulates a channel through which passes a message and its affected by the noise
    """
    def __init__(self, noise_probability: float) -> None:
        """
        Creates the class
        """
        self.noise_probability: float = noise_probability

    def apply_noise(self, message: str) -> str:
        """ 
        This method applies noise to the message using the `noise_probability` value by iterating 
        through the message chars.
        Arguments: 
            message: str -> message to be manipulated.
        Returns:
            noisy_message: str -> message affected by the ambient noise in the channel.
        """
        noisy_message: list[int] = []
        for char in message:
            if random.random() < self.noise_probability:
                noisy_message.append(1 - int(char))
            else:
                noisy_message.append(int(char))
        return ''.join([str(bit) for bit in noisy_message])

class Decoder:
    """
    Class that represents a message decoder.
    """ 
    def decode(self, message: str) -> str:
        """
        Decodes the message by calculating the syndrome to obtain the index of the flipped bit.

        Arguments:
            message: str -> string to be decoded
        Returns:
            message_decoded: str 
        TODO:
            Improve parity check for long term support
        """
        
        assert len(message) == CODE_LENGTH, f"Code messages length should be {CODE_LENGTH}."
        m = list(message)
        syndrome: list = [
            (int(m[4]) + int(m[1]) + int(m[2]) + int(m[3])) % 2,
            (int(m[5]) + int(m[0]) + int(m[2]) + int(m[3])) % 2,
            (int(m[6]) + int(m[0]) + int(m[1]) + int(m[2])) % 2
        ]
    
        if syndrome != [0,0,0]:
            corrupted_index: int = int(''.join(str(bit) for bit in syndrome), 2) - 1
            m[corrupted_index] = str(1 - int(m[corrupted_index]))
        return ''.join(m[:4])

def run_simulation(message: str, noise_probability: float) -> None:
    """
    Helper function to run simulations quickly
    """

    coder: Coder = Coder()
    channel: Channel = Channel(noise_probability)
    decoder: Decoder = Decoder()   
    
    encoded_message: str = coder.encode(message)
    noisy_message: str = channel.apply_noise(encoded_message)
    decoded_message: str = decoder.decode(noisy_message)

    if message != decoded_message:
        raise ValueError("Decoding Failed")
    return


def main() -> None:
    incorrect_recovery: int = 0

    for i in range(TRIES):
        try:
            run_simulation(MESSAGE, NOISE_PROBABILITY)
        except ValueError:
            incorrect_recovery += 1

    recovery_rate = 100 * (1 - incorrect_recovery / TRIES)
    print(f"[*] Making {TRIES} tests \n[*] Recovery rate of: {recovery_rate:.2f}%")
    return
    

if __name__ == "__main__":
    main()
