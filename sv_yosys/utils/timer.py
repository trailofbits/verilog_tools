from __future__ import annotations

import time
from typing import Any


class Timer:
    def __init__(self) -> None:
        self.start: None | float = None
        self.stop: None | float = None

    def __enter__(self) -> Timer:
        self.start = time.time()
        return self

    def __exit__(self, _type: Any, _value: Any, _traceback: Any) -> None:
        self.stop = time.time()

    @property
    def elapsed(self) -> float:
        if self.start is None:
            return 0
        if self.stop is None:
            return time.time() - self.start
        return self.stop - self.start

    def __str__(self) -> str:
        return str(self.elapsed)
