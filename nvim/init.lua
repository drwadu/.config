vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.tabstop        = 2
vim.opt.shiftwidth     = 2
vim.opt.signcolumn     = "yes"
vim.opt.winborder      = "rounded"
vim.opt.wrap           = false
vim.opt.termguicolors  = true
vim.opt.undofile       = true
vim.opt.incsearch      = true

vim.cmd([[set mouse=]])
vim.cmd([[set noswapfile]])
vim.cmd([[set clipboard+=unnamedplus]])

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map('n', '<leader>r', ':update<CR>:source<CR>')
map('n', '<leader>v', ':e $MYVIMRC<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map('n', '<leader>m', ':make<CR>')

map('n', '<leader>x', ':Vex<CR>')
map('n', '<leader>e', ':Ex<CR>')
map('n', '<leader>s', '<Cmd>e #<CR>')
map('n', '<leader>S', '<Cmd>bot sf #<CR>')

map('n', '<leader>de', vim.diagnostic.open_float)
map('n', ']g', vim.diagnostic.goto_next)
map('n', '[g', vim.diagnostic.goto_prev)
map('n', 'gd', vim.lsp.buf.definition, { silent = true })

map({ 'n', 'v' }, '<leader>n', ':norm ')

--vim.pack.add({ "https://github.com/aktersnurra/no-clown-fiesta.nvim" })
--require("no-clown-fiesta").setup({ transparent = false })
--vim.cmd("colorscheme no-clown-fiesta")
vim.cmd("hi statusline guibg=NONE")

vim.pack.add({ "https://github.com/hrsh7th/nvim-cmp" })
vim.pack.add({ "https://github.com/hrsh7th/cmp-nvim-lsp" })
vim.pack.add({ "https://github.com/hrsh7th/cmp-buffer" })
vim.pack.add({ "https://github.com/hrsh7th/cmp-path" })

local cmp = require("cmp")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.lsp.config("rust_analyzer", {
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			check = { command = "clippy" },
			cargo = { allFeatures = true },
			diagnostics = { enable = true },
			inlayHints = {
				enable = true,
				lifetimeElisionHints = {
					enable = true,
					useParameterNames = true,
				},
				parameterHints = { enable = true },
				typeHints = { enable = true },
			},
		},
	},
})

vim.lsp.config("lua_ls", { capabilities = capabilities })
vim.lsp.config("pyright", { capabilities = capabilities })
vim.lsp.config("clangd", { capabilities = capabilities })

vim.lsp.enable({
	"lua_ls",
	"rust_analyzer",
	"pyright",
	"clangd",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		vim.lsp.buf.format({ bufnr = args.buf })
	end,
})

map('n', '<leader>lf', function()
	vim.lsp.buf.format({ async = true })
end)

vim.pack.add({ "https://github.com/nvim-mini/mini.pick" })
require("mini.pick").setup()
local pick = require('mini.pick')
pick.registry.grep_live_specific = function()
	--local cache_rg_config = vim.uv.os_getenv('RIPGREP_CONFIG_PATH')
	--vim.uv.os_setenv('RIPGREP_CONFIG_PATH', '/path/to/specific/configuration')
	pick.builtin.grep_live({ tool = 'rg' })
	--vim.uv.os_setenv('RIPGREP_CONFIG_PATH', cache_rg_config)
end
map('n', '<leader><leader>', ':Pick buffers<CR>')
map('n', '<leader>ff', ':Pick files<CR>')
map('n', '<leader>fg', ':Pick grep live<CR><CR>')
--map('n', '<leader>fw', ":Pick grep live pattern=" ... "vim.fn.expand('<cword>')<CR>")
map('n', '<leader>fh', ':Pick help<CR>')

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if ok and ts_configs and ts_configs.setup then
	ts_configs.setup({
		highlight = { enable = true },
	})
end

-- optional: install parsers manually (safe for old Treesitter)
--pcall(vim.cmd, "TSInstall lua rust python c haskell")

vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require("mason").setup()

vim.pack.add({ "https://github.com/nvim-mini/mini.pairs" })
require("mini.pairs").setup()
