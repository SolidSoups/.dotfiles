-- ###############
-- ## FUNCTIONS ##
-- ###############


local function is_always_hidden(name, bufnr)
    local hidden_files = {
        ".git",
        "*.sln",
        "*.vcxproj",
        "*.vcxproj.filters",
        "*.log",
        "__pycache__",
        ".idea",
        ".vscode",
        "lazy-lock.json",
    }

    -- Check exact matches
    for _, hidden in ipairs(hidden_files) do
        if name == hidden then
            return true
        end
    end

    -- Check pattern matches (for files with wildcards)
    for _, pattern in ipairs(hidden_files) do
        if pattern:find("*") then
            -- Convert shell-style wildcards to Lua patterns
            local lua_pattern = pattern:gsub("%*", ".*")
            lua_pattern = "^" .. lua_pattern .. "$"
            if name:match(lua_pattern) then
                return true
            end
        end
    end

    return false
end



-- ###########
-- ## SETUP ##
-- ###########

require("oil").setup({
    view_options = {
        show_hidden = true,
        is_always_hidden = is_always_hidden,
    },

    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = true,
    },

    columns = {
        "icon",
    },

    float = {
        max_width = 0.7,
        max_height = 0.6,
        border = "rounded",
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<space>-", "<CMD>lua require('oil').toggle_float('.')<CR>",
    { noremap = true, silent = true, desc = "Open parent directory" })
