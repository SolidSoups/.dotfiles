local M = {}

-- Custom indent function that handles GLSL in template strings
function M.get_indent()
  local line = vim.fn.line('.')
  local col = vim.fn.col('.')

  -- Try to get treesitter node at cursor
  local ok, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
  if not ok then
    return -1 -- Fallback to default
  end

  local node = ts_utils.get_node_at_cursor()
  if not node then
    return -1
  end

  -- Check if we're inside a template string with GLSL
  local parent = node
  while parent do
    if parent:type() == 'template_string' then
      -- We're in a template string, check if it contains GLSL
      local has_glsl = false
      for child in parent:iter_children() do
        if child:lang() == 'glsl' then
          has_glsl = true
          break
        end
      end

      if has_glsl then
        -- Use cindent for GLSL-like indentation
        return vim.fn.cindent(line)
      end
    end
    parent = parent:parent()
  end

  -- Try yati first, fall back to cindent
  local yati_ok, yati = pcall(require, 'yati')
  if yati_ok then
    local indent = yati.get_indent()
    if indent and indent >= 0 then
      return indent
    end
  end

  return -1 -- Use default
end

return M
