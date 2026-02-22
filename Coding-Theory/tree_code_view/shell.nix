{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.python315
    pkgs.graphviz
  ];
  shellHook = ''
    if [ ! -d .venv ]; then
      python -m venv .venv
      source .venv/bin/activate
      pip install -r requirements.txt
    else
      source .venv/bin/activate
    fi
  '';
}
