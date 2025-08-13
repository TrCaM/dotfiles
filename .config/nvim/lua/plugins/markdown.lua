return {
  -- Make sure to set this up properly if you have lazy=true
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    file_types = { "markdown", "Avante" },
    preset = "obsidian",
    heading = {
      sign = false,
      position = "inline",
      icons = {
        "󰼏 ",
        "󰎨 ",
        "󰼑 ",
        "󰎲  ",
      },
      width = "block",
      min_width = 80,
      left_pad = 2,
      -- right_pad = 4,
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
