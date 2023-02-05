{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs { }
}:
let
  pythonVersion = "python311";

  verilogTools = with pkgs.${pythonVersion}.pkgs; buildPythonPackage rec {
    pname = "verilog_tools";
    version = "0.0.1";
    src = ./.;
    # FIXME(jl): upstream hack to enable testing:
    # https://nixos.wiki/wiki/Packaging/Python#Testing_via_this_command_is_deprecated
    doCheck = true;
    propagatedBuildInputs = [
      psutil
      pwntools
    ];
    format = "setuptools";
  };

  svPython = pkgs.${pythonVersion}.withPackages (ps: with ps; [
    pytest
    verilogTools
  ]);
in
with pkgs; pkgs.mkShell {
  name = "sv-tools";
  src = ./.;

  propagatedBuildInputs = [
    black
    isort
    mypy
    ruff
    svPython
    yosys
  ];
}
