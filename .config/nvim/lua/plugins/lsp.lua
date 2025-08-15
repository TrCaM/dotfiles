return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              library = {
                [vim.fn.stdpath("config") .. "/lua/meta"] = true,
              },
            },
          },
        },
      },
    },
  },
}
