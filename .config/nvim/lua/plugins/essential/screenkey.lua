return {
    "NStefan002/screenkey.nvim",
    lazy = true,
    version = "*", -- or branch = "dev", to use the latest commit
    cmd = "Screenkey toggle",
    keys = {
      {",sk", "<cmd>Screenkey toggle<CR>", {desc = "toggle screenkey"}}
    }
}
