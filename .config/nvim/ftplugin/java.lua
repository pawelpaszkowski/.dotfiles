local jdtls = require 'jdtls'

-- Znajdź workspace folder
local workspace_folder = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/site/java/workspace-root/' .. workspace_folder

-- Ścieżka do jdtls (Mason installation)
local jdtls_path = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar',
    '-configuration',
    jdtls_path .. '/config_linux',
    '-data',
    workspace_dir,
  },
  root_dir = jdtls.setup.find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
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
    },
  },
  init_options = {
    bundles = {},
  },
}

-- Uruchom jdtls
jdtls.start_or_attach(config)
