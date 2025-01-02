return {
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
    opts = {
      timeout = 5000,
    },
  },
}
