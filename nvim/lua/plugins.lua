local nvim_version = vim.version()
if nvim_version.major < 0 or (nvim_version.major == 0 and nvim_version.minor < 8) then
    -- vim.notify('nvim version must be greater than 0.8.0!')
    return
end

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

local mason_plugins = {
	"williamboman/mason.nvim",
}

local mason_lspconfig_plugins = {
	"williamboman/mason-lspconfig.nvim",
}

local lspconfig_plugins = {
	"neovim/nvim-lspconfig",
}

local mason_null_ls_plugins = {
	"jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
    },
    config = function()
        require("config.mason-null-ls")
    end,
}

local lspkind_plugins = {
	"onsails/lspkind.nvim",
    event = { "VimEnter" },
}

local cmp_plugins = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"lspkind.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
	},
    config = function()
        require("config.nvim-cmp")
    end,
}

local monokai_pro_plugins = {
	"tanvirtin/monokai.nvim",
}

local noice_plugins = {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}

local fugitive_plugins = {
	"tpope/vim-fugitive",
}

local gitsigns_plugins = {
	"lewis6991/gitsigns.nvim",
    config = function()
        require("config.gitsigns")
    end,
}

local autopairs_plugins = {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
    config = function()
        require("config.nvim-autopairs")
    end,
}

local nvim_treesitter_plugins = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
        require("config.nvim-treesitter")
    end,
}

local rainbow_delimiters_plugins = {
	"HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
}

local indent_blankline_plugins = {
	"lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    version = "3.8.6",
    config = function()
        require("config.indent-blankline")
    end,
}

local lualine_plugins = {
	"nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("config.lualine")
    end,
}

local markdown_plugins = {
	"preservim/vim-markdown",
	ft = { "markdown" },
}

local leap_plugins = {
	"ggandor/leap.nvim",
	config = function()
		require("leap").create_default_mappings()
	end,
}

local surround_plugins = {
	"kylechui/nvim-surround",
	version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- To solve the conflicts with leap.nvim
            -- See: https://github.com/ggandor/leap.nvim/discussions/59
            keymaps = {
                insert = "<C-g>z",
                insert_line = "gC-ggZ",
                normal = "gz",
                normal_cur = "gZ",
                normal_line = "gzgz",
                normal_cur_line = "gZgZ",
                visual = "gz",
                visual_line = "gZ",
                delete = "gzd",
                change = "gzc",
            },
        })
    end,
}

local telescope_plugins = {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("config.telescope")
    end,
}

local faster_plugins = {
	"pteroctopus/faster.nvim",
}

require("lazy").setup({
    mason_plugins,
    mason_lspconfig_plugins,
    lspconfig_plugins,
    mason_null_ls_plugins,
    lspkind_plugins,
    cmp_plugins,
	monokai_pro_plugins,
	noice_plugins,
	fugitive_plugins,
	gitsigns_plugins,
	autopairs_plugins,
	nvim_treesitter_plugins,
    rainbow_delimiters_plugins,
	indent_blankline_plugins,
	lualine_plugins,
	markdown_plugins,
	leap_plugins,
	surround_plugins,
	telescope_plugins,
	faster_plugins,
})