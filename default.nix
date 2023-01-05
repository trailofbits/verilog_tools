let
  pkgs = import (builtins.fetchTarball {
    name = "nixpkgs-22.11";
    url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/22.11.tar.gz";
    sha256 = "sha256:11w3wn2yjhaa5pv20gbfbirvjq6i3m7pqrq2msf0g7cv44vijwgw";
  }) {};

  verilog_tools = with pkgs.python311.pkgs; buildPythonPackage rec {
    pname = "verilog_tools";
    version = "0.0.1";
    src = ./.;
    # FIXME(jl): upstream hack to enable testing: https://nixos.wiki/wiki/Packaging/Python#Testing_via_this_command_is_deprecated
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
    black
    isort
    ruff
    sv-python
  ];
}
