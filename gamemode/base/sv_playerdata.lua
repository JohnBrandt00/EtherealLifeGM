-- cleanup the util
util.AddNetworkString("Ethereal_SendVars")
util.AddNetworkString("Ethereal_PlayerInfo")

function GM:SavePlayer(ply)
Ethereal:DebugPrint(Ethereal.DebugLevels["Developer"],"Saving Player Info "..ply:Nick())
 Ethereal:ParseDBData(ply,UpdateQuery,function(d) 
 	Ethereal:DebugPrint(Ethereal.DebugLevels["Developer"],"SAVED")
 	end,ply:GetPlayerValue("FirstName"),ply:GetPlayerValue("LastName"),ply:GetPlayerValue("Wallet"),ply:GetPlayerValue("Bank"),ply:GetPlayerValue("Inventory"),ply:GetPlayerValue("PhoneNumber","555"),ply:UniqueID())
end
	
function Ethereal.PlayerMeta:GetPlayerValue(id,default)
	if(Ethereal.PlayerInfo [self:UniqueID()] ~= nil and Ethereal.PlayerInfo [self:UniqueID()][id] ~= nil) then
		return Ethereal.PlayerInfo [self:UniqueID()][id]
		
	else
		return default
	end
end

	function Ethereal.PlayerMeta:SetPlayerValue(id, value,broadcast)
		if not Ethereal.PlayerInfo [self:UniqueID()] then Ethereal.PlayerInfo [self:UniqueID()]={} end
		Ethereal.PlayerInfo [self:UniqueID()][id] = value
		
		if ( IsValid(player.GetByUniqueID(self:UniqueID()) ) && broadcast ) then
			Ethereal:DebugPrint(Ethereal.DebugLevels["Developer"],"Broadcast")
			self:SendPlayerInfo()
			
		end


	end

	function Ethereal.PlayerMeta:SendPlayerInfo()
		if not Ethereal.PlayerInfo [self:UniqueID()] then return end
		net.Start("Ethereal_PlayerInfo")
			net.WriteString( util.TableToJSON( Ethereal.PlayerInfo [self:UniqueID()] ) )
		net.Send(self)
		hook.Call("SavePlayer",GAMEMODE,self)
	end


GetQuery 				= [[SELECT * FROM `player_data` WHERE Ident = '%s']]
CreateQuery 			= [[INSERT INTO `player_data` (Ident,PhoneNumber) VALUES ('%s','%s')]]
UpdateQuery				= [[UPDATE `player_data` SET FirstName='%s', LastName='%s', Wallet='%s', Bank = '%s', Inventory='%s',PhoneNumber='%s' WHERE Ident = '%s']]
UpdateWalletQuery		= [[UPDATE `player_data` SET Wallet=Wallet+'%s' WHERE Ident = '%s' ]]
UpdateBankQuery			= [[UPDATE `player_data` SET Bank=Bank+'%s' WHERE Ident = '%s' ]]
GetBankQuery 			= [[SELECT Bank FROM `player_data` WHERE Ident = '%s']]
GetWalletQuery 			= [[SELECT Wallet FROM `player_data` WHERE Ident = '%s']]

function Ethereal.PlayerMeta:GetPlayerOrCreate()
	 Ethereal:ParseDBData(self,GetQuery, 
		function(dat) 
			if (dat==nil) then	
				Ethereal:ParseDBData(self,CreateQuery,function(dater) 
						Ethereal:ParseDBData(self,GetQuery,function(data)
								if(data !=nil) then 
									for k,v in pairs(data) do
										self:SetPlayerValue(k, v,false)
										Ethereal:DebugPrint(Ethereal.DebugLevels['Developer'],k.." : "..self:GetPlayerValue(k))
									end
								end 
							end,self:UniqueID())
				 end,self:UniqueID(),string.format("(697) %d%d%d-%d%d%d%d",unpack(table.Reverse(string.ToTable(self:SteamID64())))))
				 Ethereal:DebugPrint(Ethereal.DebugLevels['Developer'],"Created User In Database "..self:Nick())

			end

			if(dat !=nil) then 
			for k,v in pairs(dat) do
				self:SetPlayerValue(k, v,false)
				Ethereal:DebugPrint(Ethereal.DebugLevels['Developer'],k.." : "..self:GetPlayerValue(k))
			end
		end

			self:SendPlayerInfo()

		end,self:UniqueID())

end
