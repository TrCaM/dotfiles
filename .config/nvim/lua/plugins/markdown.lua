return {
  -- Make sure to set this up properly if you have lazy=true
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    file_types = { "markdown", "Avante" },
    preset = "obsidian",
    heading = {
      sign = false,
      -- position = "left",
      icons = {
        "=== 󰼏   ",
        "=== 󰎨   ",
        "=== 󰼑   ",
        "=== 󰎲   ",
      },
      -- Turn on / off atx heading rendering.
      atx = true,
      -- Turn on / off setext heading rendering.
      setext = true,
      width = "block",
      min_width = 0,
      -- right_pad = 4,
      -- backgrounds = {},
    },
    checkbox = {
      unchecked = { icon = "◯ " },
      checked = { icon = "✔ " },
      custom = {
        [">"] = {
          raw = "[>]",
          rendered = " ",
          highlight = "RenderMarkdownWarn",
        },
        ["~"] = {
          raw = "[~]",
          rendered = "󰥔 ",
          highlight = "RenderMarkdownTodo",
        },
        ["!"] = {
          raw = "[!]",
          rendered = " ",
          highlight = "RenderMarkdownError",
        },
      },
    },
  },
  ft = { "markdown", "Avante" },
}
