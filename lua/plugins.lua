-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- add your plugins here
        {
            "rebelot/kanagawa.nvim", 
            config = function()
                vim.cmd.colorscheme("kanagawa-wave")
            end,

        },
        {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "javascript", "tsx", "html"},
                    auto_install = true,
                    indent = {
                        enable = true,
                    },
                    highlight = {
                        enable = true,
                    },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = "<Leader>ss",
                            node_incremental = "<Leader>si",
                            scope_incremental = "<Leader>sc",
                            node_decremental = "<Leader>sd",
                        },
                    },
                    textobjects = {
                        select = {
                            enable = true,

                            -- Automatically jump forward to textobj, similar to targets.vim
                            lookahead = true,

                            keymaps = {
                                -- You can use the capture groups defined in textobjects.scm
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["ac"] = "@class.outer",
                                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                                -- nvim_buf_set_keymap) which plugins like which-key display
                                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                                -- You can also use captures from other query groups like `locals.scm`
                                ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                            },
                            -- You can choose the select mode (default is charwise 'v')
                            --
                            -- Can also be a function which gets passed a table with the keys
                            -- * query_string: eg '@function.inner'
                            -- * method: eg 'v' or 'o'
                            -- and should return the mode ('v', 'V', or '<c-v>') or a table
                            -- mapping query_strings to modes.
                            selection_modes = {
                                ['@parameter.outer'] = 'v', -- charwise
                                ['@function.outer'] = 'V', -- linewise
                                ['@class.outer'] = '<c-v>', -- blockwise
                            },
                            -- If you set this to `true` (default is `false`) then any textobject is
                            -- extended to include preceding or succeeding whitespace. Succeeding
                            -- whitespace has priority in order to act similarly to eg the built-in
                            -- `ap`.
                            --
                            -- Can also be a function which gets passed a table with the keys
                            -- * query_string: eg '@function.inner'
                            -- * selection_mode: eg 'v'
                            -- and should return true or false
                            include_surrounding_whitespace = true,
                        },
                    },
                })
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter-textobjects"
        },
        {
            "neovim/nvim-lspconfig",
        },
        {
            "williamboman/mason.nvim",
            config = function() 
                require("mason").setup()
            end,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            dependencies = {"mason.nvim"}, 
            config = function() 
                require("mason-lspconfig").setup()
                require("mason-lspconfig").setup_handlers({
                    -- The first entry (without a key) will be the default handler
                    -- and will be called for each installed server that doesn't have
                    -- a dedicated handler.
                    function (server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup({})
                    end,
                    -- Next, you can provide a dedicated handler for specific servers.
                    -- For example, a handler override for the `rust_analyzer`:
                })
            end,
        },
        {
            "vhyrro/luarocks.nvim",
            priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
            config = true,
            config = function()
                require("luarocks-nvim").setup()
            end,
        },
        {
            'nvim-telescope/telescope.nvim', tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function()
                vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").find_files)
                vim.keymap.set("n", "<Leader>en", function()
                    require("telescope.builtin").find_files {
                        cwd = vim.fn.stdpath("config")
                    }
                end)
            end
        }
    },
    -- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
}) 

