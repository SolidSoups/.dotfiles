vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the window position (centered)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Create the floating window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- Use minimal style to avoid borders, etc.
    border = "double",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function(cmd)
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end

    -- Enter terminal mode and then insert mode
    vim.api.nvim_set_current_win(state.floating.win)

    -- If a command is provided, send it to the terminal
    if cmd then
      vim.api.nvim_chan_send(vim.b[state.floating.buf].terminal_job_id, cmd .. "\n")
    end

    -- Start insert mode
    vim.cmd("startinsert")
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal, { desc = "Toggle Terminal" })
vim.keymap.set("n", "<leader><leader>c", function ()
  toggle_terminal("love .")
  toggle_terminal()
  vim.cmd("stopinsert")
end, { desc = "Build löve in cwd"})
vim.keymap.set("n", "<leader><leader>l", function()
  toggle_terminal("love .")
end, { desc = "Build löve in cwd with terminal open" })

require("which-key").add({
  { "<leader>t", group = "Toggle terminal" }
})
