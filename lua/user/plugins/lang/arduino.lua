return {
  recommended =
  {
    ft = { "arduino", "ino" },

    root = {
    }
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        arduino_language_server = {
        },
      },
    },
  }

}
