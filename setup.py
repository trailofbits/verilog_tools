import os

from setuptools import find_packages, setup

this_directory = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(this_directory, "README.md"), encoding="utf-8") as f:
    long_description = f.read()


setup(
    name="verilog_tools",
    description="Zero-Knowledge Proof of Vulnerability Tools",
    long_description_content_type="text/markdown",
    long_description=long_description,
    url="https://github.com/trailofbits/verilog_tools",
    author="Trail of Bits",
    version="0.0.1",
    include_package_data=True,
    packages=find_packages(exclude=["tests", "tests.*"]),
    python_requires=">=3.8",
    entry_points={
        "console_scripts": [
            "sv-netlist = verilog_tools.yosys.netlistify:main",
            "sv-stat = verilog_tools.yosys.yosys_stat:main",
        ]
    },
)
