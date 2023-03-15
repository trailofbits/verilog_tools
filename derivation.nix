{ sources ? import ../nix/sources.nix
, pkgs ? import sources.nixpkgs { }
}:

with pkgs; python3Packages.buildPythonPackage rec {
  pname = "sv-yosys-${version}";
  version = "0.1.0";

  format = "pyproject";
  src = ./.;

  propagatedBuildInputs = with python3Packages; [
    psutil
    pwntools
    yosys
  ];
}
