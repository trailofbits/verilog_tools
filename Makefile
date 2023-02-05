PY_MODULE := verilog_tools

PY_SRC := $(shell find $(PY_MODULE) -name '*.py')

.PHONY: format
format:
		ruff --fix $(PY_SRC) && \
		black $(PY_SRC) && \
		isort $(PY_SRC)

.PHONY: lint
lint:
		black --check $(PY_SRC) && \
		isort --check $(PY_SRC) && \
		ruff $(PY_SRC) && \
		mypy $(PY_MODULE)
