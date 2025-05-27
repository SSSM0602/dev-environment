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




-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- add your plugins here
        {
            "rebelot/kanagawa.nvim", 
            config = function()
                vim.cmd.colorscheme("kanagawa-dragon")
            end
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
            dependencies = {"neovim/nvim-lspconfig", "saghen/blink.cmp"}, 
            config = function() 
                -- Get capabilities from blink.cmp
                local capabilities = require('blink.cmp').get_lsp_capabilities()

                -- Mason v2 setup with automatic installation
                require("mason-lspconfig").setup({
                    automatic_installation = true,
                    -- Setup handlers for each language server
                    handlers = {
                        -- Default handler applies capabilities to all servers
                        function(server_name)
                            require("lspconfig")[server_name].setup({
                                capabilities = capabilities,
                            })
                        end,
                    },
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
                require('telescope').setup({
                    defaults = {
                        file_ignore_patterns = {
                            'node_modules',
                            '.git',
                            'dist',
                        },
                    },
                })
                vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").find_files)
                vim.keymap.set("n", "<Leader>en", function()
                    require("telescope.builtin").find_files {
                        cwd = vim.fn.stdpath("config")
                    }
                end)
            end
        },
        {
            'saghen/blink.cmp',
            -- optional: provides snippets for the snippet source
            dependencies = { 'rafamadriz/friendly-snippets' },

            -- use a release tag to download pre-built binaries
            version = '1.*',
            -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
            -- build = 'cargo build --release',
            -- If you use nix, you can build from source using latest nightly rust with:
            -- build = 'nix run .#build-plugin',

            ---@module 'blink.cmp'
            ---@type blink.cmp.Config
            opts = {
                keymap = { preset = 'default' },

                appearance = {
                    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    nerd_font_variant = 'mono',
                    use_nvim_cmp_as_default = true
                },

                -- (Default) Only show the documentation popup when manually triggered
                completion = { documentation = { auto_show = false } },

                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },

                -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
                -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
                -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
                --
                -- See the fuzzy documentation for more information
                fuzzy = { implementation = "prefer_rust_with_warning" }
            },
            opts_extend = { "sources.default" }
        },
    },
    -- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
}) 

