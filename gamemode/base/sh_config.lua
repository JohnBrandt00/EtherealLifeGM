GM.Config = {}

GM.Config.basesalary 			= 40
GM.Config.paydaytimer			= 60
GM.Config.startingcash			= 5000
GM.Config.jailtime				= 60
GM.Config.DeathTimer 			= 90
GM.Config.baseloadout 			= {"hands"}
GM.Config.DataProvider 			= "EtherealLife/gamemode/providers/mysql.lua"
GM.Config.CalculateBuyPrice = function(price)

	return price*1.2

end

GM.Config.CalculateTax = function(tax)
	return tax
end