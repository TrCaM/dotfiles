return {
  "stevearc/conform.nvim",
  event = { "LspAttach", "BufReadPost", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      python = { "ruff_format" },
      vue = { "prettier" },
      markdown = { "prettier" },
    },
  },
}
