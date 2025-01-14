local dap_config = {
  configurations = {
    {
      type = "python",
      request = "launch",
      name = "Debug Test Method",
      module = "pytest",
      args = function()
        local path = vim.fn.expand("%:p")
        local funcname = vim.fn.input("Test Method > ", "")
        return { path, "-k", funcname }
      end,
      pythonPath = "/Users/gustavoandreronconi/miniconda3/envs/price-harversting-service/bin/python",
    },
  },
}

return dap_config
