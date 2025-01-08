return {
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "OXY2DEV/markview.nvim" },
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*", -- or branch = "dev", to use the latest commit
  },
  { "LhKipp/nvim-nu", opts = {} },
  { "sigmaSd/deno-nvim", opts = {} },
  { "brenoprata10/nvim-highlight-colors", opts = {} },
  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    opts = {
      watermark = "Hiten Tandon",
      title = "Code By Hiten Tandon",
      has_line_number = true,
      code_font_family = "JetBrains Mono Nerd Font",
      watermark_font_family = "JetBrains Mono Nerd Font",
    },
  },
  { "cdmill/focus.nvim", opts = {} },
  { "meznaric/key-analyzer.nvim", opts = {} },
  { "ShinKage/idris2-nvim", dependencies = { "neovim/nvim-lspconfig", "MunifTanjim/nui.nvim" }, opts = {} },
  {
    "arminveres/md-pdf.nvim",
    branch = "main",
    lazy = true,
    keys = {
      {
        "<leader>m",
        function()
          require("md-pdf").convert_md_to_pdf()
        end,
        desc = "Markdown preview",
      },
    },
    opts = {},
  },
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },
  { "Olical/conjure", ft = { "scheme", "racket", "clojure", "fennel", "lisp" } },
  { "rose-pine/neovim", name = "rose-pine" },
  { "LazyVim/LazyVim", opts = { colorscheme = "rose-pine" } },
  {
    "jackplus-xyz/scroll-it.nvim",
    opts = {},
  },
}
