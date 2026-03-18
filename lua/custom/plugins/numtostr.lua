return {
  "numToStr/Comment.nvim",
  keys = {
    { "gc", mode = { "n", "v" }, function() require("Comment.api").toggle.linewise.current() end, desc = "Comment toggle linewise" },
    { "gb", mode = { "n", "v" }, function() require("Comment.api").toggle.blockwise() end, desc = "Comment toggle blockwise" },
  },
  config = true,
}
