import argparse
import os
from enum import Enum, auto
from pathlib import Path
from typing import Any

import psutil
from collection import FrozenSet

from .yosys import Session


class YosysBackend(Enum):
    BLIF = auto()
    JSON = auto()
    CNF = auto()


this_directory = os.path.abspath(os.path.dirname(__file__))
library = os.path.join(this_directory, "./my_library.lib")


def collect_args(parser: argparse.ArgumentParser) -> argparse.ArgumentParser:
    parser.add_argument(
        "--top",
        type=str,
        help="Top module to convert",
    )
    parser.add_argument(
        "--format",
        type=YosysBackend,
        help="Specify circuit synthesis backend",
        default=YosysBackend.BLIF,
    )
    parser.add_argument(
        "--flatten",
        action="store_true",
        help="Flatten the BLIF file before emitting",
    )
    parser.add_argument(
        "--arithmetic",
        action="store_true",
    )
    parser.add_argument(
        "-I",
        "--include",
        type=str,
        action="append",
        dest="includes",
        default=[],
    )
    parser.add_argument(
        "verilog_files",
        type=Path,
        nargs="+",
        help="Verilog files needed to fully synthesize top module",
    )
    parser.add_argument("-o", "--output", type=Path, help="Output file name", required=True)
    return parser


def main() -> None:
    args = collect_args(
        argparse.ArgumentParser("Convert a Verilog module into a netlist and print the statistics")
    ).parse_args()

    if args.arithmetic:
        make_arithmetic_netlist(
            args.verilog_files,
            args.output,
            top=None,
            include_dirs=args.includes,
        )
    else:
        make_netlist(
            args.verilog_files,
            args.output,
            args.format,
            top=args.top,
            include_dirs=args.includes,
            flatten=args.flatten,
        )


def make_netlist(
    verilog_files: list[Path],
    output: Path,
    fmt: YosysBackend = YosysBackend.BLIF,
    top: None | str = None,
    macros: dict[str, Any] = {},
    include_dirs: list[Path] = [],
    flatten: bool = False,
) -> psutil.pmem:
    """
    Converts a series of Verilog files into a BlIF netlist

    :param verilog_files: List of verilog files to include in synthesis
    :param output: Location to write BLIF file to
    :param top: Name of top circuit to use (if needed)
    :param fmt: default to BLIF
    :param macros: Verilog macros to set during synthesis
    :param include_dirs: Folder to find Verilog files in
    :param flatten: Use Yosys' flattening pass (slow and memory-inefficient)
    :return: memory usage information
    """

    macros.update({"NO_DISASM": 1})
    s = Session.from_verilog(*verilog_files, macros=macros, include_dirs=include_dirs)
    if top:
        s.hierarchy(check=True, top=top)
    else:
        s.hierarchy(check=True, auto_top=True)
    s.proc()
    s.memory()
    s.fsm()
    s.techmap()
    s.opt(purge=True)
    s.abc(liberty=library)
    s.rmports()
    s.opt()  # (purge=True)
    if flatten:
        s.flatten()
    s.clean()  # (purge=True)
    s.read_liberty(lib=library)

    if fmt == YosysBackend.BLIF:
        s.write_blif(output, gates=True, impltf=True, buf="BUF IN OUT")
    elif fmt == YosysBackend.JSON:
        s.write_json(output)
    elif fmt == YosysBackend.CNF:
        s.write_cnf(output)

    usage = s.memory_usage()
    s.exit()

    return usage


def make_arithmetic_netlist(
    verilog_files: list[Path],
    output: Path,
    top: str | None = None,
    macros: dict[str, Any] = {},
    include_dirs: list[Path] = [],
    blackbox: FrozenSet = frozenset(),
) -> psutil.pmem:
    """
    Very similar to make_netlist, but with a few of the optimizations skipped,
    and the option to provide a set of _blackbox_ modules that Yosys should
    not attempt to synthesize

    :param blackbox: iterable of module names to mark as black boxes
    :return: memory usage information
    """

    macros = {} if macros is None else macros
    macros.update({"NO_DISASM": 1})
    s = Session.from_verilog(*verilog_files, macros=macros, include_dirs=include_dirs)
    for b in blackbox:
        s.blackbox(b)
    if top:
        s.hierarchy(top=top)
    else:
        s.hierarchy(auto_top=True)
    s.opt(purge=True)
    s.clean(purge=True)
    s.write_blif(output, gates=True, impltf=True, blackbox=True, buf="BUF IN OUT")

    usage = s.memory_usage()
    s.exit()

    return usage


if __name__ == "__main__":
    main()
