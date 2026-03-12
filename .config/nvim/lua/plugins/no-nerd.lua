return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        disable_devicons = true,
        prompt_prefix = ":: ",
        selection_caret = "> ",
        results_title = false,
        entry_prefix = "  ",
        path_display = { "truncate" },
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        delete = { text = "▎" },
        topdelete = { text = "▎" },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        format = {
          cmdline = { icon = ":" },
          search_down = { icon = "/" },
          search_up = { icon = "/⌃" },
          filter = { icon = "$" },
          lua = { icon = "☾" },
          help = { icon = "?" },
          explorer = { icon = "::" },
        },
      },
      format = {
        level = {
          icons = {
            error = "❌",
            warn = "⚠️",
            info = "ℹ️",
          },
        },
      },
      popupmenu = {
        kind_icons = false,
      },
      inc_rename = {
        cmdline = {
          format = {
            IncRename = { icon = "⟳" },
          },
        },
      },
    },
  },
}
