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
  {
    "Prometheus1400/markdown-latex-render.nvim",
    dependencies = { "3rd/image.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "philosofonusus/ecolog.nvim",
    keys = {
      { "<leader>ge", "<cmd>EcologGoto<cr>", desc = "Go to env file" },
      { "<leader>ep", "<cmd>EcologPeek<cr>", desc = "Ecolog peek variable" },
      { "<leader>es", "<cmd>EcologSelect<cr>", desc = "Switch env file" },
    },
    -- Lazy loading is done internally
    lazy = false,
    opts = {
      integrations = {
        blink_cmp = true,
      },
      -- Enables shelter mode for sensitive values
      shelter = {
        configuration = {
          partial_mode = false, -- false by default, disables partial mode, for more control check out shelter partial mode
          mask_char = "*", -- Character used for masking
        },
        modules = {
          cmp = true, -- Mask values in completion
          peek = false, -- Mask values in peek view
          files = false, -- Mask values in files
          telescope = false, -- Mask values in telescope
          fzf = false, -- Mask values in fzf picker
        },
      },
      -- true by default, enables built-in types (database_url, url, etc.)
      types = true,
      path = vim.fn.getcwd(), -- Path to search for .env files
      preferred_environment = "development", -- Optional: prioritize specific env files
    },
  },
  { "Olical/conjure", ft = { "scheme", "racket", "clojure", "fennel" } },
  {
    "Saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          draw = {
            components = {
              label = {
                width = { fill = true, max = 60 },
                text = function(ctx)
                  local highlights_info = require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                  if highlights_info ~= nil then
                    return highlights_info.text
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
                  local highlights_info = require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
                  local highlights = {}
                  if highlights_info ~= nil then
                    for _, info in ipairs(highlights_info.highlights) do
                      table.insert(highlights, {
                        info.range[1],
                        info.range[2],
                        group = ctx.deprecated and "BlinkCmpLabelDeprecated" or info[1],
                      })
                    end
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  return highlights
                end,
              },
            },
          },
        },
      },
    },
  },
  { "xzbdmw/colorful-menu.nvim", opts = {} },
}
