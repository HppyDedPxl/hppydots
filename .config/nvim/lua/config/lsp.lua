---@param mason_name string 
---@param config_name string
---@param binary_name string
---@param params table
local function LSPDefinition(mason_name,config_name,binary_name,params)
	return {
		Name = mason_name,
		Config = config_name,
		Binary = binary_name,
		Params = params or {}
	}
end

local config = {
	servers = { 
		LSPDefinition("roslyn_ls","roslyn_ls","roslyn-language-server", {'--stdio'}), 
		LSPDefinition("emmylua_ls","emmylua_ls","emmylua_ls"),
		LSPDefinition("jsonls","jsonls","vscode-json-language-server", {'--stdio'}),
		LSPDefinition("zuban", "zuban","zuban", {'server'}),
		LSPDefinition("html", "html", "vscode-html-language-server", {'--stdio'}),

	}
}

config.GetMasonNames = function (self)
	local names = {}
	for _, def in pairs(self.servers) do
		table.insert(names,def.Name)
	end
	return names
end

return config
