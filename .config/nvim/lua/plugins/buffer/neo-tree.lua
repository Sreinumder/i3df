return {
  'antosha417/nvim-lsp-file-operations',
  keys = {
    {"<A-z>", "<cmd>Neotree toggle show right<CR>", desc="toggle neotree"},
    {"<A-Z>", "<cmd>Neotree toggle float<CR>", desc="toggle neotree"}
  },
  dependencies = {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "MunifTanjim/nui.nvim"},
    -- cmd = "Neotree",
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        hijack_netrw_behavior = "disabled",
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        -- cwd_target = {
          --   sidebar = "tab",
          -- }
        },
        window = {
          mappings = {
            ["-"] = "navigate_up",
            ["<space>"] = "none",
            ["Y"] = {
              function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                vim.fn.setreg("+", path, "c")
              end,
              desc = "Copy Path to Clipboard",
            },
            ["<leader>-"] = {
              function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                require('mini.files').open(path)
                require('mini.files').reveal_cwd()
              end,
              desc = "open in mini.files",
            },
            ["P"] = { "toggle_preview", config = { use_float = false } },
          },
        },
        default_component_configs = {
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          git_status = {
            symbols = {
              unstaged = "U",
              staged = "S",
              added     = "A",
              deleted   = "D",
              modified  = "M",
              renamed   = "R",
              untracked = "?",
              ignored   = "i",
              conflict  = "C",
            },
          },
        },
      },
    }
  }
