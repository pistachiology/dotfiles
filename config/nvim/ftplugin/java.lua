local jdtls = require("jdtls")

local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
local home = os.getenv("HOME")
local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local ws_folders_jdtls = {}
if root_dir then
    local file = io.open(root_dir .. "/.custom-root/ws_root_folders")
    if file then
        for line in file:lines() do
            table.insert(ws_folders_jdtls, "file://" .. line)
        end
        file:close()
    end
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    on_init = function(client, bufnr)
        require('jdtls.setup').add_commands()
    end,

    on_attach = function(client, bufnr)
        lsp_setup(bufnr)
    end,
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        -- See https://github.com/NixOS/nixpkgs/pull/180010/files#diff-d71d2cdf5ad6ef8d2c6fde2f903a0351cf72767372be53cfa9deef937235682fR79
        NIX_GLOBAL.jdtls.jdt_bin_path, '-data', eclipse_workspace
    },
    root_dir = root_dir,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        flags = {
            allow_incremental_sync = true,
            server_side_fuzzy_completion = true,
        },

        java = {
            format = {
                settings = {
                    url = NIX_GLOBAL.jdtls.styleguide_path
                }
            },
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
        },

    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        workspaceFolders = ws_folders_jdtls,
    },
}
require('jdtls').start_or_attach(config)
