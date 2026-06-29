load("//xla/tests:build_defs.bzl", "xla_test")
load("//xla/tsl:package_groups.bzl", "DEFAULT_LOAD_VISIBILITY")

visibility(DEFAULT_LOAD_VISIBILITY)

def xla_aot_test(name, test_macro = None, env = None, **kwargs):
    """Generates 5 distinct AOT compatibility test variations for an existing test target.

    Args:
      name: The base name of the test target.
      test_macro: The underlying test macro to use (e.g., xla_test). Defaults to xla_test.
      env: Environment variables to pass to the test.
      **kwargs: Additional arguments to pass to the test_macro.
    """
    if env == None:
        env = {}
    if test_macro == None:
        test_macro = xla_test

    modes = [
        "golden",
        "backward_oldest",
        "backward_previous",
        "forward_oldest",
        "forward_previous",
    ]

    for mode in modes:
        mode_env = dict(env)
        mode_env["AOT_TEST_MODE"] = mode

        test_macro(
            name = name + "_" + mode,
            env = mode_env,
            **kwargs
        )
