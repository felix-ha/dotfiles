return {
  {
    "mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          --"autotools-language-server",
          "marksman",
          -- "gopls",
          "dockerls",
          "docker_compose_language_service",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
      dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.marksman.setup({})
      lspconfig.pyright.setup({})
      lspconfig.dockerls.setup({})
      lspconfig.docker_compose_language_service.setup({})

      -- keymaps, see help: :h vim.lsp.buf
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
  -- TODO: setup: for code actions:   "nvim-telescope/telescope-ui-select.nvim"
}
