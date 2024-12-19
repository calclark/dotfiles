vim.loader.enable()

-- Set user options.
-- vim.opt.cmdheight = 0
vim.opt.jumpoptions = "stack"
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.wildmode = "longest:full"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.hlsearch = false
vim.opt.sidescrolloff = 0
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.laststatus = 3
-- vim.opt.number = false
-- vim.opt.relativenumber = false
-- vim.opt.timeout = false
vim.opt.timeoutlen = 0
-- vim.opt.guifont = "Source Code Pro:h16"
-- vim.opt.scrolloff = 999
-- vim.opt.fileencoding = "utf-8"
vim.opt.mouse = ""
-- vim.opt.cursorline = true

vim.g.do_filetype_lua = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

vim.api.nvim_command("syntax manual")

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>n", "<cmd>bnext<cr>")
vim.keymap.set("n", "<leader>p", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<leader>w", "<c-w>")

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("RestoreCursorOnOpen", {}),
	callback = function()
		if vim.fn.line([['"]]) <= vim.fn.line("$") then
			vim.api.nvim_command([[normal! g`"]])
		end
	end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("KeepCursorCentered", {}),
	command = "normal! zz"
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("OpenHelpVertically", {}),
	command = "wincmd L | vertical resize 81 | set syntax=help",
	pattern = "help",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("SetSQLCommentString", {}),
	command = "set commentstring=--%s",
	pattern = "sql",
})

local fmt = string.format
vim.diagnostic.config({
	virtual_text = false,
	underline = false,
	float = {
		format = function(diagnostic)
			return fmt(
				"%s (%s) [%s]",
				diagnostic.message,
				diagnostic.source,
				diagnostic.code or diagnostic.user_data.lsp.code)
		end,
	},
})

vim.fn.sign_define("DiagnosticSignError", { text = "·" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "·" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "·" })
vim.fn.sign_define("DiagnosticSignHint", { text = "·" })

vim.api.nvim_command("highlight Normal guifg=#FFFFFF, guibg=#000000")
vim.api.nvim_command("highlight StatusLine guifg=#FFFFFF, guibg=#000000")

vim.keymap.set("n", "s", "<Plug>(leap)")
-- Disable auto-jump on first match.
require('leap').opts.safe_labels = {}
-- The below settings make Leap's highlighting closer to those in Lightspeed.
vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey

local telescope = require("telescope")
telescope.setup({
	defaults = {
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.95,
			height = 0.95,
		},
		path_display = {"truncate"},
        preview = false,
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
				["<C-u>"] = false,
			},
		},
	},
    pickers = {
        lsp_references = {
            path_display = {"tail"},
            trim_text = true,
        },
    },
})
telescope.load_extension("fzf")
vim.keymap.set("n", "<leader>z", "<cmd>Telescope<cr>")
vim.keymap.set("n", "<leader>f", function() require("telescope.builtin").find_files {no_ignore=true} end)
vim.keymap.set("n", "<leader>r", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>m", "<cmd>Telescope marks<cr>")
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader><space>", "<cmd>Telescope resume<cr>")

-- Manage and display shortcuts.
require("which-key").setup()

-- AST
-- require("nvim-treesitter.install").compilers = {"zig"}
-- require("nvim-treesitter.install").prefer_git = false
-- require("nvim-treesitter.configs").setup({
--     highlight = {
--         enable = true,
--     },
-- })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local options = {
            noremap=true,
            silent=true,
            buffer=ev.buf,
        }
        local telescope = require("telescope.builtin")
        vim.keymap.set("n", "gd", telescope.lsp_definitions, options)
        vim.keymap.set("n", "gr", telescope.lsp_references, options)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, options)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, options)
        vim.keymap.set("n", "<Leader>R", vim.lsp.buf.rename, options)
        -- vim.keymap.set("n", "<Leader>F", function() vim.lsp.buf.format {async = true} end, options)
        vim.keymap.set("n", "<Leader>F", function() vim.cmd('!black % && isort %') end, options)
        vim.keymap.set("n", "<Leader>k", vim.lsp.buf.hover, options)
        vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, options)
        vim.keymap.set("n", "<Leader>s", telescope.lsp_document_symbols, options)
        vim.keymap.set("n", "<Leader>S", telescope.lsp_workspace_symbols, options)
        vim.keymap.set("n", "<Leader>d", telescope.diagnostics, options)
    end,
})

if vim.env.WSL_INTEROP == nil then
	vim.opt.clipboard = "unnamedplus"
else
	vim.cmd[[
		let g:clipboard = {
					\   'name': 'WslClipboard',
					\   'copy': {
					\      '+': 'clip.exe',
					\      '*': 'clip.exe',
					\    },
					\   'paste': {
					\      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
					\      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
					\   },
					\   'cache_enabled': 0,
					\ }
	]]
	local options = {
		noremap=true,
		silent=true,
		-- buffer=ev.buf,
	}
	vim.keymap.set({"n", "v"}, "gp", '"+p', options)
	vim.keymap.set({"n", "v"}, "gP", '"+P', options)
	vim.keymap.set({"n", "v"}, "gy", '"+y', options)
	vim.keymap.set({"n", "v"}, "gY", '"+Y', options)
end

function select_indent(around)
    local start_indent = vim.fn.indent(vim.fn.line('.'))
    local blank_line_pattern = '^%s*$'

    if string.match(vim.fn.getline('.'), blank_line_pattern) then
        return
    end

    if vim.v.count > 0 then
        start_indent = start_indent - vim.o.shiftwidth * (vim.v.count - 1)
        if start_indent < 0 then
            start_indent = 0
        end
    end

    local prev_line = vim.fn.line('.') - 1
    local prev_blank_line = function(line) return string.match(vim.fn.getline(line), blank_line_pattern) end
    while prev_line > 0 and (prev_blank_line(prev_line) or vim.fn.indent(prev_line) >= start_indent) do
        vim.cmd('-')
        prev_line = vim.fn.line('.') - 1
    end
    if around then
        vim.cmd('-')
    end

    vim.cmd('normal! 0V')

    local next_line = vim.fn.line('.') + 1
    local next_blank_line = function(line) return string.match(vim.fn.getline(line), blank_line_pattern) end
    local last_line = vim.fn.line('$')
    while next_line <= last_line and (next_blank_line(next_line) or vim.fn.indent(next_line) >= start_indent) do
        vim.cmd('+')
        next_line = vim.fn.line('.') + 1
    end
    if around then
        vim.cmd('+')
    end
end

for _,mode in ipairs({ 'x', 'o' }) do
	vim.api.nvim_set_keymap(mode, 'ii', ':<c-u>lua select_indent()<cr>', { noremap = true, silent = true })
	vim.api.nvim_set_keymap(mode, 'ai', ':<c-u>lua select_indent(true)<cr>', { noremap = true, silent = true })
end

require "local-overrides"
-- vim: set noexpandtab:
