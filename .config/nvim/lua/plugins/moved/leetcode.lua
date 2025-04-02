return {
    "kawre/leetcode.nvim",
    enabled = false,
    lazy = true,
    build = ":TSUpdate html",
    dependencies = {
        "ibhagwan/fzf-lua",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {lang = "python3"},
}
