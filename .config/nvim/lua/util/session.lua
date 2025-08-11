local M = {}

local function get_sessions()
  return vim.fn.glob(vim.fn.expand("~") .. "/.vimsessions/*.vim", true, true)
end

function M.save()
  local filename = vim.fn.input("Save session as: ", vim.fn.expand("~") .. "/.vimsessions/", "file")
  if filename ~= "" then
    vim.cmd("mksession! " .. vim.fn.fnameescape(filename))
  end
end

function M.delete_session(session_path)
  vim.fn.delete(session_path)
end

function M.picker()
  require("snacks").picker.pick({
    source = "sessions",
    finder = function()
      local sessions = get_sessions()
      if vim.tbl_isempty(sessions) then
        vim.notify("No sessions found.", vim.log.levels.WARN)
        return {}
      end

      local items = {}
      for _, session_path in ipairs(sessions) do
        table.insert(items, {
          text = vim.fn.fnamemodify(session_path, ":t"),
          path = session_path,
        })
      end
      return items
    end,
    confirm = function(picker, item)
      picker:close()
      if item then
        vim.cmd("source " .. vim.fn.fnameescape(item.path))
      end
    end,
    format = function(item, _)
      return { { item.text } }
    end,
    layout = {
      preview = false,
      layout = {
        backdrop = {
          blend = 40,
        },
        width = 0.3,
        min_width = 80,
        height = 0.3,
        min_height = 10,
        box = "vertical",
        border = "rounded",
        title = " Sessions (s/<C-s>: save, dd/<C-d>: delete) ",
        title_pos = "center",
        { win = "list", border = "none" },
        { win = "input", height = 1, border = "top" },
      },
    },
    actions = {
      save_new = function(picker, _)
        picker:close()
        M.save()
        vim.defer_fn(function()
          M.picker()
        end, 100)
      end,
      delete_session = function(picker, item)
        if item then
          M.delete_session(item.path)
          picker:find()
        end
      end,
    },
    win = {
      input = {
        keys = {
          ["<C-s>"] = { "save_new", mode = { "i" } },
          ["s"] = { "save_new", mode = { "n" } },
          ["dd"] = { "delete_session", mode = { "n" } },
          ["<C-d>"] = { "delete_session", mode = { "i" } },
        },
      },
    },
  })
end

function M.setup()
  local wk = require("which-key")
  wk.add({
    {
      "<localleader>q",
      group = "+Session",
    },
    {
      "<localleader>qs",
      function()
        M.save()
      end,
      desc = "Save session",
    },
    {
      "<localleader>ql",
      function()
        M.picker()
      end,
      desc = "Load session",
    },
  })
end

return M
