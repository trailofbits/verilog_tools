let
  pkgs = import (builtins.fetchTarball {
    name = "nixpkgs-unstable-2022-07-19";
    url = "https://github.com/nixos/nixpkgs/archive/2df37941652c28e0858b9a9520ce5763c43c2ec1.tar.gz";
    sha256 = "sha256:12d5w1bvhjlxrvdhsc44gq1lv5s3z1lv18s39q1702hwmp2bz071";
  }) {};

  verilog_tools = with pkgs.python311.pkgs; buildPythonPackage rec {
    pname = "verilog_tools";
    version = "0.0.1";
    src = ./.;
    doCheck = false;
    propagatedBuildInputs = [ psutil ];
    format = "setuptools";
  };
  sv-python = pkgs.python311.withPackages (ps: with ps; [verilog_tools]);

in
with pkgs; stdenv.mkDerivation {
  name = "sv-tools";
  src = ./.;

  nativeBuildInputs = [
    sv-python
  ];
}
