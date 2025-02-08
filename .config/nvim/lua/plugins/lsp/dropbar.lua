return {
  'Bekaboo/dropbar.nvim',
  -- events = "UIEnter",
  keys = {
    { '<A-O>', function() require('dropbar.api').pick() end, desc = 'Pick symbols in winbar' },
    { '<A-o>', function() require('dropbar.api').select_next_context() end, desc = 'Select next context' },
    -- { '<A-o>', dropbar_api.goto_context_start, desc = 'Go to start of current context' },
  },
  opts = function()
    local open_item_and_close_menu = function()
      local utils = require('dropbar.utils')
      local menu = utils.menu.get_current()
      if not menu then
        return
      end

      local cursor = vim.api.nvim_win_get_cursor(menu.win)
      local entry = menu.entries[cursor[1]]
      -- stolen from https://github.com/Bekaboo/dropbar.nvim/issues/66
      local component = entry:first_clickable(entry.padding.left + entry.components[1]:bytewidth())
      if component then
        menu:click_on(component, nil, 1, 'l')
      end
    end

    return {
      menu = {
        -- https://github.com/Bekaboo/dropbar.nvim/discussions/172
        keymaps = {
          ['h'] = function()
            local utils = require('dropbar.utils')
            local menu = utils.menu.get_current()
            if not menu then
              return
            end
            if menu.prev_menu then
              menu:close()
            else
              local bar = require('dropbar.utils.bar').get({ win = menu.prev_win })
              local barComponents = bar.components[1]._.bar.components
              for _, component in ipairs(barComponents) do
                if component.menu then
                  local idx = component._.bar_idx
                  menu:close()
                  require('dropbar.api').pick(idx - 1)
                end
              end
            end
          end,
          ['l'] = function()
            local utils = require('dropbar.utils')
            local menu = utils.menu.get_current()
            if not menu then
              return
            end
            local cursor = vim.api.nvim_win_get_cursor(menu.win)
            local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
            if component then
              menu:click_on(component, nil, 1, 'l')
            end
          end,
          ['<CR>'] = open_item_and_close_menu,
          ['o'] = open_item_and_close_menu,
        }
      }
    }
  end,
  init = function()
    vim.api.nvim_set_hl(0, 'DropBarMenuCurrentContext', { link = 'Visual' })
  end,
}
