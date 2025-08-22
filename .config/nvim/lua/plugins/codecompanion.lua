-- CodeCompanion.nvim plugin configuration
return {
  {
    "olimorris/codecompanion.nvim", -- The KING of AI programming
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    dependencies = {
      "j-hui/fidget.nvim", -- Display status
      {
        "Davidyz/VectorCode", -- Index and search code in your repositories
        version = "*",
        build = "pipx upgrade vectorcode",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
      -- { "echasnovski/mini.pick", config = true },
      -- { "ibhagwan/fzf-lua", config = true },
    },
    opts = {
      -- adapters = {
      --   anthropic = function()
      --     return require("codecompanion.adapters").extend("anthropic", {
      --       env = {
      --         api_key = "cmd:op read op://personal/Anthropic_API/credential --no-newline",
      --       },
      --       schema = {
      --         extended_thinking = {
      --           default = true,
      --         },
      --       },
      --     })
      --   end,
      --   gemini = function()
      --     return require("codecompanion.adapters").extend("gemini", {
      --       env = {
      --         api_key = "cmd:op read op://personal/Gemini_API/credential --no-newline",
      --       },
      --     })
      --   end,
      -- },
      ---@module "vectorcode"
      extensions = {
        vectorcode = {
          ---@type VectorCode.CodeCompanion.ExtensionOpts
          opts = {
            tool_group = {
              -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
              enabled = true,
              -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
              -- if you use @vectorcode_vectorise, it'll be very handy to include
              -- `file_search` here.
              extras = {},
              collapse = false, -- whether the individual tools should be shown in the chat
            },
            tool_opts = {
              ---@type VectorCode.CodeCompanion.ToolOpts
              ["*"] = {},
              ---@type VectorCode.CodeCompanion.LsToolOpts
              ls = {},
              ---@type VectorCode.CodeCompanion.VectoriseToolOpts
              vectorise = {},
              ---@type VectorCode.CodeCompanion.QueryToolOpts
              query = {
                max_num = { chunk = -1, document = -1 },
                default_num = { chunk = 50, document = 10 },
                include_stderr = false,
                use_lsp = true,
                no_duplicate = true,
                chunk_mode = false,
                ---@type VectorCode.CodeCompanion.SummariseOpts
                summarise = {
                  ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
                  enabled = false,
                  adapter = nil,
                  query_augmented = true,
                },
              },
              files_ls = {},
              files_rm = {},
            },
          },
        },
      },
      prompt_library = {
        ["Maths tutor"] = {
          strategy = "chat",
          description = "Chat with your personal maths tutor",
          opts = {
            index = 4,
            ignore_system_prompt = true,
            intro_message = "Welcome to your lesson! How may I help you today? ",
          },
          prompts = {
            {
              role = "system",
              content = [[You are a helpful maths tutor.
You can explain concepts, solve problems, and provide step-by-step solutions for maths.
The user asking the questions has an MPhys in Physics, is knowledgeable in maths, but is out of practice.
The user is an experienced programmer, so you can relate maths concepts to programming ones.
If the user asks you about a topic respond with:
1. A brief explanation of the topic
2. A definition
3. A simple example and a more complex example
4. A programming analogy or example
5. A summary of the topic
6. A question to the user to check their understanding

You must:
- Not use H1 or H2 headings. Only H3 headings and above
- Always show your work and explain each step clearly
- Relate Math concepts to programming terms where applicable
- Use KaTeX for any mathematical notation (as the user works with the Notion app and Anki for flashcards)
- Ensure that any inline KaTeX is within $$ delimiters (e.g. $x^2 + y^2 = z^2$) so it can be pasted into Notion or Anki
- For any math blocks, do NOT use $$ delimiters, just use the math block syntax (e.g. \[ x^2 + y^2 = z^2 \])
- Use Python for coding examples]],
            },
          },
        },
        ["Test workflow"] = {
          strategy = "workflow",
          description = "Use a workflow to test the plugin",
          opts = {
            index = 4,
          },
          prompts = {
            {
              {
                role = "user",
                content = "Generate a Python class for managing a book library with methods for adding, removing, and searching books",
                opts = {
                  auto_submit = false,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write unit tests for the library class you just created",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Create a TypeScript interface for a complex e-commerce shopping cart system",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write a recursive algorithm to balance a binary search tree in Java",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Generate a comprehensive regex pattern to validate email addresses with explanations",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Create a Rust struct and implementation for a thread-safe message queue",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write a GitHub Actions workflow file for CI/CD with multiple stages",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Create SQL queries for a complex database schema with joins across 4 tables",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write a Lua configuration for Neovim with custom keybindings and plugins",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Generate documentation in JSDoc format for a complex JavaScript API client",
                opts = {
                  auto_submit = true,
                },
              },
            },
          },
        },
      },
      strategies = {
        chat = {
          adapter = {
            name = "gemini",
            model = "gemini-2.5-pro",
          },
          roles = {
            user = "caot",
          },
          keymaps = {
            send = {
              modes = {
                i = { "<C-CR>", "<C-s>" },
              },
            },
            completion = {
              modes = {
                i = "<C-x>",
              },
            },
          },
          slash_commands = {
            ["buffer"] = {
              keymaps = {
                modes = {
                  i = "<C-b>",
                },
              },
            },
            ["fetch"] = {
              keymaps = {
                modes = {
                  i = "<C-f>",
                },
              },
            },
            ["help"] = {
              opts = {
                max_lines = 1000,
              },
            },
            ["image"] = {
              keymaps = {
                modes = {
                  i = "<C-i>",
                },
              },
              opts = {
                dirs = { "~/Documents/Screenshots" },
              },
            },
          },
        },
        inline = {
          adapter = {
            name = "copilot",
            model = "gpt-4.1",
          },
        },
      },
      display = {
        action_palette = {
          provider = "default",
        },
        chat = {
          -- show_references = true,
          -- show_header_separator = false,
          -- show_settings = false,
          icons = {
            tool_success = "󰸞 ",
          },
          fold_context = true,
        },
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "mini_diff", -- default|mini_diff
        },
      },
      opts = {
        log_level = "DEBUG",
      },
    },
    keys = {
      {
        "<localleader>a",
        "<cmd>CodeCompanionActions<CR>",
        desc = "Open the action palette",
        mode = { "n", "v" },
      },
      {
        "<Leader>aa",
        "<cmd>CodeCompanionChat Toggle<CR>",
        desc = "Toggle a chat buffer",
        mode = { "n", "v" },
      },
      {
        "<leader>ac",
        "<cmd>CodeCompanionChat Add<CR>",
        desc = "Add code to a chat buffer",
        mode = { "v" },
      },
    },
    init = function()
      vim.cmd([[cab cc CodeCompanion]])
      require("util.spinner"):init()
    end,
  },
}
