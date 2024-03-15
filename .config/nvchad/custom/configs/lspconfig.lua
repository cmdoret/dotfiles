local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "clangd",
  "gopls",
  "marksman",
  "pyright",
  "rust_analyzer",
}
-- Copy capabilities list but exclude 'semanticTokensProvider' from it
for k, v in pairs(capabilities) do
  if k ~= "semanticTokensProvider" then
    capabilities[k] = v
  end
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
