{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs { }
}:

let
  verilog_tools = pkgs.callPackage ./derivation.nix { };
in
with pkgs; stdenv.mkDerivation {
  name = "verilog_tools";

  nativeBuildInputs = [
    black
    isort
    mypy
    ruff
  ];
}
