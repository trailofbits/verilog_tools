{ lib, pkgs }:

with pkgs; python3Packages.buildPythonPackage rec {
  pname = "verilog_tools-${version}";
  version = "0.0.1";

  format = "setuptools";
  src = ./.;

  # FIXME(jl): upstream hack to enable testing:
  # https://nixos.wiki/wiki/Packaging/Python#Testing_via_this_command_is_deprecated
  doCheck = true;

  propagatedBuildInputs = with python3Packages; [
    psutil
    pwntools
    yosys
  ];
}
