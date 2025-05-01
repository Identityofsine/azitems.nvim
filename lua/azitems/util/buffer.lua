function WipeBufferByName(name)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(buf) == name then
      -- Only delete if the buffer is valid and loaded
      if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
        -- Check if it's visible in any window
        local is_visible = false
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_buf(win) == buf then
            is_visible = true
            break
          end
        end
        if not is_visible then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end
  end
end
