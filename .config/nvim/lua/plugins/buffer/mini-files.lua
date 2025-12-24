return {
	"echasnovski/mini.files",
	lazy = false,
  enabled = true,
	keys = {
		{
			"<leader><leader>",
			function()
				if not require("mini.files").close() then
					require("mini.files").open()
				end
			end,
			 desc = "mini.file" ,
		},
    {
      '-',
      function()
        if not require('mini.files').close() then
          require('mini.files').open(vim.api.nvim_buf_get_name(0))
          require('mini.files').reveal_cwd()
        end
      end,
    },
  },
  opts = function()
    local MiniFiles = require('mini.files')
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesWindowUpdate",
      callback = function(args)
        local buf_id = args.data.buf_id
        vim.api.nvim_buf_set_keymap(buf_id, "n", "<A-j>", "j", {})
        vim.api.nvim_buf_set_keymap(buf_id, "n", "<A-k>", "k", {})
        vim.wo[args.data.win_id].relativenumber = true
        vim.wo[args.data.win_id].number = true
      end,
    })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesWindowOpen',
      callback = function(args)
        local win_id = args.data.win_id
        local config = vim.api.nvim_win_get_config(win_id)
        config.border, config.title_pos = 'single', 'center'
        vim.api.nvim_win_set_config(win_id, config)
      end,
    })
    -- got from this reddit post
    -- https://www.reddit.com/r/neovim/comments/1pm2m6i/cool_minifiles_sidescrolling_layout/
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesWindowUpdate",
      callback = function(ev)
        local state = MiniFiles.get_explorer_state() or {}

        local win_ids = vim.tbl_map(function(t)
          return t.win_id
        end, state.windows or {})

        local function idx(win_id)
          for i, id in ipairs(win_ids) do
            if id == win_id then return i end
          end
        end

        local this_win_idx = idx(ev.data.win_id)
        local focused_win_idx = idx(vim.api.nvim_get_current_win())

        -- this_win_idx can be nil sometimes when opening fresh minifiles
        if this_win_idx and focused_win_idx then
          -- idx_offset is 0 for the currently focused window
          local idx_offset = this_win_idx - focused_win_idx

          -- the width of windows based on their distance from the center
          -- i.e. center window is 60, then next over is 20, then the rest are 10.
          -- Can use more resolution if you want like { 60, 30, 20, 15, 10, 5 }
          local widths = { 60, 20, 10 }

          local i = math.abs(idx_offset) + 1 -- because lua is 1-based lol
          local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
          win_config.width = i <= #widths and widths[i] or widths[#widths]

          local offset = 0
          for j = 1, math.abs(idx_offset) do
            local w = widths[j] or widths[#widths]
            -- and an extra +2 each step to account for the border width
            local _offset = 0.5*(w + win_config.width) + 2
            if idx_offset > 0 then
              offset = offset + _offset
            elseif idx_offset < 0 then
              offset = offset - _offset
            end
          end

          win_config.height = idx_offset == 0 and 25 or 20
          win_config.row = math.floor(0.5*(vim.o.lines - win_config.height))
          win_config.col = math.floor(0.5*(vim.o.columns - win_config.width) + offset)
          vim.api.nvim_win_set_config(ev.data.win_id, win_config)
        end
      end
    })
    local show_dotfiles = true
    local filter_show = function(fs_entry) return true end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end
    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh({ content = { filter = new_filter } })
    end

    local set_cwd = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify('Cursor is not on valid entry') end
      vim.fn.chdir(vim.fs.dirname(path))
    end

    -- Yank in register full path of entry under cursor
    local yank_path = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify('Cursor is not on valid entry') end
      vim.fn.setreg(vim.v.register, path)
    end

    -- local open_in_neo_tree = function()
      --   local path = (MiniFiles.get_fs_entry() or {}).path
      --   if path == nil then return vim.notify('Cursor is not on valid entry') end
      --   require("nvim-tree.api").tree.find_file({buf = path, update_root = true, open = true, focus = true})
      -- end
      --
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set('n', 'g~', set_cwd,   { buffer = buf_id, desc = 'Set cwd' })
          vim.keymap.set('n', 'gy', yank_path, { buffer = buf_id, desc = 'Yank path' })
          vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
          -- vim.keymap.set('n', 'gn', open_in_nvim_tree, { buffer = buf_id })
        end,
      })
      return {
        content = { prefix = function() end },
        mappings = {
          close = "<ESC>",
          -- go_in       = '<A-l>',
          go_in = "<A-l>",
          go_in_plus = "<CR>",
          -- go_out      = '<A-h>',
          go_out = "-",
          go_out_plus = "<A-h>",
          mark_goto = "'",
          mark_set = "m",
          reset = "<BS>",
          reveal_cwd = "@",
          show_help = "g?",
          synchronize = "=",
          trim_left = "<",
          trim_right = ">",
        },

        -- General options
        options = {
          permanent_delete = false,
          use_as_default_explorer = true,
        },

        -- Customization of explorer windows
        windows = {
          max_number = math.huge,
          preview = true,
          width_focus = 50,
          width_nofocus = 15,
          width_preview = 70,
        },
      }
    end,
  }
