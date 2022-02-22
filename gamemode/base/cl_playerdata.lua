net.Receive("Ethereal_PlayerInfo",function()
	Ethereal.PlayerData = util.JSONToTable( net.ReadString() )
end)

function GetPlayerValue(id, default)
		return Ethereal.PlayerData[id] ~= nil and Ethereal.PlayerData[id] or default
end

function Ethereal.PlayerMeta:GetValue(id, default)
		return GetPlayerValue(id, default)
end