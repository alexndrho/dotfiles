local M = {}

-- function M.getMaxStringLength(lines)
--   local max_length = 0
--
--   for _, line in ipairs(lines) do
--     local length = #line
--     if length > max_length then max_length = length end
--   end
--
--   return max_length
-- end

function M.wrapText(text, max_length)
  local wrapped_lines = {}

  for line in text:gmatch '[^\n]*' do
    if line ~= '' then
      local current_line = ''

      for word in line:gmatch '%S+' do
        if #current_line + #word + 1 > max_length then
          table.insert(wrapped_lines, current_line)
          current_line = word
        else
          if current_line ~= '' then current_line = current_line .. ' ' end
          current_line = current_line .. word
        end
      end

      if current_line ~= '' then table.insert(wrapped_lines, current_line) end
    end
  end

  return wrapped_lines
end

return M
