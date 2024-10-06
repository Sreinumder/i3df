  return { -- mason
    "williamboman/mason.nvim",
    cmd = {"mason", "masoninstall", "masoninstallall", "masonuninstall", "masonuninstallall", "masonlog"},
    opts = {
        path = "prepend",
        ui = {
            icons = {
                package_pending = " ",
                package_installed = "󰄳 ",
                package_uninstalled = " 󰚌"
            },

            keymaps = {
                toggle_server_expand = "<cr>",
                install_server = "i",
                update_server = "u",
                check_server_version = "c",
                update_all_servers = "u",
                check_outdated_servers = "c",
                uninstall_server = "x",
                cancel_installation = "<c-c>"
            }
        },

        max_concurrent_installers = 10
    },
    config = function(_, opts)
        require("mason").setup(opts)
    end
  },
