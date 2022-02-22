function GM:LoadDataProvider()
	if(Ethereal.DataProvider) then return end
	PROVIDER = {}
	PROVIDER.__index = {}
	PROVIDER.ID = "mysql"

	include("EtherealLife/gamemode/providers/mysql.lua")
	Ethereal.DataProvider = PROVIDER
	PROVIDER = nil
end
hook.Add("LoadDataProvider",GAMEMODE,LoadDataProvider)


function Ethereal:ParseDBData(ply,query,callback,...) 
	self.DataProvider:ParseData(ply,query,function(data) callback(data) end,...) 
end 
