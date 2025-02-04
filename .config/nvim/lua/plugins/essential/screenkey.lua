return {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*", -- or branch = "dev", to use the latest commit
    cmd = "Screenkey toggle",
    keys = {
      {"<leader>,sk", "<cmd>Screenkey toggle<CR>", {desc = "toggle screenkey"}}
    }
}
