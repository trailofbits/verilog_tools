let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };

  verilog_tools = pkgs.callPackage ./derivation.nix { };
in with pkgs; mkShell { buildInputs = [ black isort mypy ruff verilog_tools ]; }
