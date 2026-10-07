local servers = require('config.lsp').servers

for k, v in pairs(servers) do
	local cfg = require('lsp.' .. v.Config)	
	cfg.cmd = { vim.fn.stdpath('cache') .. '/mason/bin/' .. v.Binary }
	for _,param in ipairs(v.Params) do
		table.insert(cfg.cmd,param)
	end
	vim.lsp.config[v.Name] = cfg
	vim.lsp.enable(v.Name)
end

