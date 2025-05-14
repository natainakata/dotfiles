return {
  check = {
    command = "clippy",
    extra_args = {
      "--",
      "-A",
      "unused",
      "-A",
      "unused_variables",
    },
  },
}
