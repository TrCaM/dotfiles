return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "sainnhe/gruvbox-material" },
  { "catppuccin/nvim" },
  { "rose-pine/neovim" },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = true,
      dimInactive = false,
      colors = {
        theme = { all = { ui = { bg_gutter = "none" } } },
      },
    },
  },
  { "sainnhe/sonokai" },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
