import sv_yosys

def test_version():
    version = getattr(sv_yosys, "__version__", None)
    assert version is not None
    assert isinstance(version, str)
