return {
  "klen/nvim-test",
  config = function()
    require("nvim-test").setup({
      runners = {
        javascriptreact = "nvim-test.runners.jest",
        javascript = "nvim-test.runners.jest",
        typescript = "nvim-test.runners.jest",
        typescriptreact = "nvim-test.runners.jest",
      },
    })
  end,
}
