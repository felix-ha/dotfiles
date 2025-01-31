return {
    {
        "dinhhuy258/git.nvim",
        config = function()
            require('git').setup({
                -- Default keymap settings
                keymaps = {
                    -- Open blame window
                    blame = "<Leader>gb",
                    -- Open file/folder in git repository
                    browse = "<Leader>go",
                    -- Opens a new diff that compares against the current index
                    diff = "<Leader>gd",
                    -- Close git diff
                    diff_close = "<Leader>gD",
                    -- Revert to the specific commit
                    revert = "<Leader>gr",
                    -- Opens a new diff that compares against the current HEAD
                    diff_against_head = "<Leader>gh",
                },
                -- Default target branch for git rebase
                target_branch = "main",
                -- Show signs in the sign column
                signs = {
                    -- Show a sign for added lines
                    added = "+",
                    -- Show a sign for removed lines
                    removed = "-",
                    -- Show a sign for modified lines
                    modified = "~",
                },
                -- Default signs color configuration
                sign_colors = {
                    added = "DiffAdd",
                    removed = "DiffDelete",
                    modified = "DiffChange",
                },
                -- Window dimensions for blame window
                blame_window = {
                    height = 10,
                    width = 60,
                },
                -- Enable line number column in the blame window
                line_numbers = true,
                -- Enable line highlighting in blame window
                line_highlighting = true,
                -- Enable status line in blame window
                status_line = true,
                -- Enable syntax highlighting in blame window
                syntax_highlighting = true,
                -- Highlight the current line in blame window
                current_line_blame = true,
                -- Show diff preview in floating window
                diff_preview = {
                    enabled = true,
                    width = 80,
                },
                -- Auto close blame window when cursor moves
                auto_close_blame = true,
            })
        end,
    }
}
