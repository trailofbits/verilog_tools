# verilog_tools

[![Build Status](https://github.com/trailofbits/verilog_tools/yml/badge.svg)](https://github.com/trailofbits/sholva/actions?query=workflow%3ACI)

Zero-Knowledge Proof of Vulnerability Tools.

## Tools

Wrappers around [https://github.com/YosysHQ/yosys](yosys) providing circuit compilation utilities:

- `sv-netlist` -- Synthesize a Netlist (in BLIF or JSON) from Verilog file(s).
- `sv-stat` -- Synthesis gate statistics from Verilog file(s).

## Usage

Interactively in `nix-shell`,

```sh
 $ nix-shell
```

[Tools](#tools) are available in `PATH`, e.g. `sv-stat`:

```sh
[nix-shell]$ sv-stat test/imul.v

=== circuit ===

   Number of wires:               1303
   Number of wire bits:          24504
   Number of public wires:          74
   Number of public wire bits:    3357
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:              11954
     $_AND_                       4635
     $_MUX_                        640
     $_NOT_                        146
     $_OR_                        2502
     $_XOR_                       4031
```

or `sv-netlist`, printing timestamped synthesis logs:

```
[nix-shell]$ LOGLEVEL=info sv-netlist --top circuit test/imul.v -o test/imul.blif
2023-02-05 16:55:33,828 yosys read_verilog  -DNO_DISASM=1 test/imul.v
2023-02-05 16:55:33,838 yosys hierarchy -check -top circuit
2023-02-05 16:55:33,839 yosys proc
# ...
```

Non-interactively, passing the interactive invocations through `nix-shell --run`:

```sh
$ nix-shell --run "sv-stat test/imul.v"
# ...
$ nix-shell --run "LOGLEVEL=info sv-netlist --top circuit test/imul.v -o test/imul.bli'
# ...
```

## Distribution and Licensing

This research was developed with funding from the Defense Advanced Research Projects Agency (DARPA) under Agreement No. HR001120C0084.

The views, opinions, and/or findings expressed are those of the author(s) and
should not be interpreted as representing the official views or policies of the
Department of Defense or the U.S. Government.

DISTRIBUTION STATEMENT A: Approved for public release, distribution unlimited.

_verilog_tools_ is licensed under the GNU AGPLv3 License. A copy of the terms can
be found in the [LICENSE](./LICENSE) file.
