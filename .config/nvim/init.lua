local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Base options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.spell = true
vim.opt.spelllang = "en,es"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Map jk to Esc
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true })
vim.keymap.set('v', 'jk', '<ESC>', { noremap = true })

require("lazy").setup({
  {
      "ellisonleao/gruvbox.nvim", 
      priority = 1000, 
      config = function()
          vim.cmd("colorscheme gruvbox")
      end
  },
  {
    "lervag/vimtex",
    lazy = false, -- vimtex should not be lazy-loaded
    init = function()
      -- Vimtex configuration
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_latexmk = {
        out_dir = 'build',
        options = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
        },
      }

      -- Clean up the build directory on exit
      vim.g.vimtex_quickfix_open_on_warning = 0
    end,
    config = function()
        -- Mapping to compile project
        vim.keymap.set("n", "<leader>ll", "<plug>(vimtex-compile)", { desc = "Compile LaTeX Document" })
        vim.keymap.set("n", "<leader>lv", "<plug>(vimtex-view)", { desc = "View PDF in Zathura" })
        vim.keymap.set("n", "<leader>lc", "<plug>(vimtex-clean)", { desc = "Clean build files" })
        
        -- Auto-save on text change to trigger Vimtex continuous compilation automatically
        vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
            pattern = "*.tex",
            callback = function()
                -- Save only if the buffer is modified to avoid loops
                if vim.bo.modified then
                    vim.cmd("silent! write")
                end
            end,
        })
    end
  },

  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", 
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
        "iurimateus/luasnip-latex-snippets.nvim",
        -- you can also include standard git snippets if you want
    },
    config = function()
      local ls = require("luasnip")
      ls.config.set_config({ -- Setting LuaSnip config
        enable_autosnippets = true, -- REQUIRED for Gilles Castel's fast math snippets
        store_selection_keys = "<Tab>",
      })
      
      -- Load the LaTeX snippets
      require("luasnip-latex-snippets").setup({
          use_treesitter = false, 
          -- If you prefer using treesitter to determine if cursor is in mathmode, 
          -- you must install nvim-treesitter. False relies on vimtex, which is usually faster/safer.
      })

      -- Shortcut to jump forward in snippet placeholders
      vim.keymap.set({"i", "s"}, "<Tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, {silent = true})
      
      -- Shortcut to jump backwards
      vim.keymap.set({"i", "s"}, "<S-Tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, {silent = true})
    end,
  },
})
