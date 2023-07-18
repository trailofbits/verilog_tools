{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-compat, ... }:
    let
      supportedSystems =
        [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
          inherit (pkgs) stdenv lib;

          propagatedBuildInputs = with pkgs;
            with python3Packages; [
              psutil
              pwntools
              yosys
            ];
        in rec {
          default = verilog_tools;
          verilog_tools = pkgs.python3Packages.buildPythonPackage rec {
            pname = "verilog_tools-${version}";
            version = "0.0.1";

            format = "setuptools";
            src = ./.;

            inherit propagatedBuildInputs;
          };
        });

      apps = forAllSystems (system: rec {
        sv-netlist = {
          type = "app";
          program = "${self.packages.${system}.verilog_tools}/bin/sv-netlist";
        };
        sv-stat = {
          type = "app";
          program = "${self.packages.${system}.verilog_tools}/bin/sv-stat";
        };
      });
    };
}
