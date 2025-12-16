vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.incsearch = true

-- proxmox
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.copyindent = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cinoptions = "(0,u0,U0"

vim.cmd([[set noswapfile]])
vim.cmd([[set mouse=]])
vim.cmd([[set clipboard+=unnamedplus]])

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
map('n', '<leader>r', ':update<CR> :source<CR>')
map('n', '<leader>v', ':e $MYVIMRC<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>m', ':make<CR>')
--map('n', '<leader>x', ':Sex<CR>')
map('n', '<leader>x', ':Vex<CR>')
map('n', '<leader>s', '<Cmd>e #<CR>')
map('n', '<leader>S', '<Cmd>bot sf #<CR>')
map('n', '<leader>e', ':Ex<CR>')
map('n', '<leader>de', '<CMD>lua vim.diagnostic.open_float()<CR>')
map("n", "]g", vim.diagnostic.goto_next)
map("n", "[g", vim.diagnostic.goto_prev)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
map('n', '<leader>q', ':quit<CR>')
map({ 'n', 'v' }, '<leader>n', ':norm ')

vim.pack.add({ "https://github.com/aktersnurra/no-clown-fiesta.nvim" })
require "no-clown-fiesta".setup({ transparent = false })
vim.cmd("colorscheme no-clown-fiesta-dark")
map('n', '<leader>csd', ':colorscheme no-clown-fiesta-dark<CR>')
map('n', '<leader>csm', ':colorscheme no-clown-fiesta-dim<CR>')
map('n', '<leader>csl', ':colorscheme no-clown-fiesta-light<CR>')
vim.cmd(":hi statusline guibg=NONE")

vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.lsp.enable(
	{
		"lua_ls",
		"rust_analyzer",
		"pyright",
		"clangd",
		"biome"
	}
)
vim.lsp.config(
    'rust-analyzer',
    {
      settings = {
	['rust-analyzer'] = {
	  check = {
	    command = "clippy", -- use Clippy for on-save checking
	  },
	  cargo = {
	    allFeatures = true,
	  },
	  diagnostics = {
	    enable = true,
	  },
	  inlayHints = {
	    enable = true,
	    lifetimeElisionHints = {
	      enable = true,
	      useParameterNames = true,
	    },
	    parameterHints = {
	      enable = true,
	    },
	    typeHints = {
	      enable = true,
	    },
	  },
	},
      },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
map('n', '<leader>lf', vim.lsp.buf.format)
map('i', '<c-e>', function() vim.lsp.completion.get() end)

vim.pack.add({ "https://github.com/nvim-mini/mini.pick" })
require "mini.pick".setup()
local pick = require("mini.pick")
local function live_grep()
    pick.start({
	source = {
	    name = "Ripgrep",

	    items = function(query)
		if query == "" then 
		    return {}
		end
		return vim.fin.systemlist({
		    "rg",
		    "--vimgrep",
		    "--smart-case",
		    "--hidden",
		    "--glob",
		    "!.git/*",
		    query,
		})
	    end,

	    choose = function(item)
		local file, lnum, col = item:match("([^:]+):(%d+):(%d+)")
		vim.cmd(("edit +%s %s"):format(lnum, file))
	    end,

	    preview = function(item)
		local file, lnum = item:match("([^:]+):(%d+)")
		return pick.gen_preview.file(file, tonumber(lnum))
	    end,
	},
    })
end
map("n", "<leader>rg", live_grep)
map('n', '<leader>f', ':Pick files<CR>')
map('n', '<leader><leader>', ':Pick buffers<CR>')
map('n', '<leader>h', ':Pick help<CR>')

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
require "nvim-treesitter.configs".setup({
	ensure_installed = { "lua", "rust", "python", "c", "haskell", "perl" },
	highlight = { enable = true }
})

vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require "mason".setup()

vim.pack.add({ "https://github.com/nvim-mini/mini.pairs" })
require "mini.pairs".setup()

vim.pack.add({ "https://github.com/APZelos/blamer.nvim" })
map('n', '<leader>gb', ':BlamerToggle<CR>')

vim.pack.add({ "https://github.com/hrsh7th/nvim-cmp" })
vim.pack.add({ "https://github.com/hrsh7th/cmp-nvim-lsp" })
vim.pack.add({ "https://github.com/hrsh7th/cmp-buffer" })
vim.pack.add({ "https://github.com/hrsh7th/cmp-path" })
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      -- optional: if you enable luasnip later
      -- require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter to confirm
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  }),
})
--local capabilities = require("cmp_nvim_lsp").default_capabilities()
--vim.lsp.enable({
--  "lua_ls",
--  "rust_analyzer",
--  "pyright",
--  "clangd",
--}, { capabilities = capabilities })

