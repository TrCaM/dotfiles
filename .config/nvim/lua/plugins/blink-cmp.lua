return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        documentation = {
          auto_show = vim.bo.filetype ~= "markdown",
        },
        trigger = {
          -- When true, will show the completion window after typing a character that matches the `keyword.regex`
          show_on_keyword = false,
          -- When true, will show the completion window after typing a trigger character
          show_on_trigger_character = false,
        },
      },
    },
  },
}
