return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      -- your dashboard configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      -- {
      sections = {
        {
          section = "terminal",
          cmd = "/usr/local/bin/pokemon-colorscripts -n snorlax --no-title; sleep .1",
          height = 20,
          indent = 3,
        },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
