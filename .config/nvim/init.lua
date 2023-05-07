local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup {
    "folke/which-key.nvim",
    { "folke/neoconf.nvim",       cmd = "Neoconf" },
    "folke/neodev.nvim",
    { "ellisonleao/gruvbox.nvim", priority = 1000 },

    "ethanholz/nvim-lastplace",

    "nvim-treesitter/nvim-treesitter", -- for syntax highlighting, folding etc.
    "neovim/nvim-lspconfig",           -- utility wrapper for the built-in neovim lsp client
    -- easily manage LSP servers
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate"
    },
    "williamboman/mason-lspconfig.nvim",
    "nvim-lualine/lualine.nvim",
    "nvim-tree/nvim-web-devicons",
}

require("lualine").setup {
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
    tabline = {
        lualine_a = {
            {
                "buffers",
                show_modified_status = false,
                mode = 4,
                symbols = {
                    modified = "",
                    alternate_file = "",
                    directory = "",
                },
            }
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
            {
                "tabs",
                mode = 2,
            }
        },
    },
    options = { theme = "gruvbox" }
}

require("mason").setup {}
require("mason-lspconfig").setup {
    automatic_installation = true,
}

require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,    -- invert background for search, diffs, statuslines and errors
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "comment", -- allows TODO: FIXME: NOTE: and others: https://github.com/stsewd/tree-sitter-comment
        "cpp",
        "go",
        "rust",
        "python",
        "lua",
    }
}

local lspconfig = require("lspconfig")
local lspconfig_util = require("lspconfig/util")

lspconfig.rust_analyzer.setup {
}

lspconfig.clangd.setup {
}

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

lspconfig.gopls.setup {
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod" },
    root_dir = lspconfig_util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

vim.api.nvim_set_option("clipboard", "unnamed")                                   -- yank to system clipboard by default

vim.keymap.set("n", "<esc><esc>", "<esc>:nohlsearch<cr><esc>", { silent = true }) -- double Esc gets rid of search highlighting

-- resize splits
vim.keymap.set("n", "<s-up>", ":resize -2<cr>", { silent = true })
vim.keymap.set("n", "<s-down>", ":resize +2<cr>", { silent = true })
vim.keymap.set("n", "<s-left>", ":vertical resize -2<cr>", { silent = true })
vim.keymap.set("n", "<s-right>", ":vertical resize +2<cr>", { silent = true })

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.updatetime = 300
vim.opt.autoread = true -- reload file changes from disk
vim.opt.mouse = "a"     -- enable mouse in all modes
vim.opt.encoding = "utf-8"
vim.opt.undofile = true
vim.opt.number = true
vim.opt.scrolloff = 4
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wrapscan = false -- do not wrap when searching
vim.opt.history = 50
vim.opt.autowrite = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.timeout = true
vim.opt.timeoutlen = 3000
vim.opt.ttimeoutlen = 100
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80
vim.opt.display:append { "uhex" } -- display ASCII chars numerically
vim.opt.inccommand = "nosplit"    -- give a live preview when substituting
vim.opt.termguicolors = true

require("nvim-lastplace").setup {
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
    lastplace_open_folds = true
}

vim.keymap.set("n", "gb", ":ls<cr>:b<space>")
