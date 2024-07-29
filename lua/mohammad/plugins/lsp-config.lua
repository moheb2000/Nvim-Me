return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local nvim_lsp = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")

		local lsp_keymaps = function(bufnr)
			local opts = { noremap = true, silent = true }
			local keymap = vim.api.nvim_buf_set_keymap
			keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
			keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
			keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
			keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
			keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
			keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
			keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
			keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
			keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
			keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
			keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
			keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
			keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
			keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
		end

		local on_attach = function(_, bufnr)
			lsp_keymaps(bufnr)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local signs = {
			{ name = "DiagnosticSignError", text = "" },
			{ name = "DiagnosticSignWarn", text = "" },
			{ name = "DiagnosticSignHint", text = "" },
			{ name = "DiagnosticSignInfo", text = "" },
		}

		for _, sign in ipairs(signs) do
			vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
		end

		local config = {
			virtual_text = false, -- disable virtual text
			signs = {
				active = signs, -- show signs
			},
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		}

		vim.diagnostic.config(config)

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})

		mason_lspconfig.setup_handlers({
			function(server)
				nvim_lsp[server].setup({
					capabilities = capabilities,
				})
			end,
			["tsserver"] = function()
				nvim_lsp["tsserver"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["cssls"] = function()
				nvim_lsp["cssls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["html"] = function()
				nvim_lsp["html"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["jsonls"] = function()
				nvim_lsp["jsonls"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["eslint"] = function()
				nvim_lsp["eslint"].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
		})
	end,
}
