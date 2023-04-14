{ pkgs }:

with pkgs;
python3Packages.buildPythonPackage rec {
  pname = "verilog_tools-${version}";
  version = "0.0.1";

  format = "setuptools";
  src = ./.;

  propagatedBuildInputs = with python3Packages; [ psutil pwntools yosys ];
}
