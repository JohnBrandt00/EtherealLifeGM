function Ethereal.PlayerMeta:GetWallet()
	return self:GetPlayerValue("Wallet",nil)
end

function Ethereal.PlayerMeta:GetInBank()
	return self:GetPlayerValue("Bank",nil)
end

if(SERVER) then

function Ethereal.PlayerMeta:UpdateWallet(wallet)
	
	Ethereal:ParseDBData(self,UpdateWalletQuery,
		function(dat)
			Ethereal:DebugPrint(Ethereal.DebugLevels['High'],"Updated User Wallet "..self:Nick())
			Ethereal:ParseDBData(self,GetWalletQuery,function(data) self:SetPlayerValue("Wallet",data["Wallet"],true) end,self:UniqueID() )
			end,-wallet,self:UniqueID())
end


function Ethereal.PlayerMeta:UpdateBank(bank)
	
	Ethereal:ParseDBData(self,UpdateBankQuery,
		function(dat)
			Ethereal:DebugPrint(Ethereal.DebugLevels['High'],"Updated User Bank "..self:Nick())
			Ethereal:ParseDBData(self,GetBankQuery,function(data) self:SetPlayerValue("Bank",data["Bank"],true) end,self:UniqueID() )
			end,-bank,self:UniqueID())
end


function Ethereal.PlayerMeta:Wire(player,amount)
		self:UpdateBank(amount)
		player:UpdateBank(-amount)
		Ethereal:DebugPrint(Ethereal.DebugLevels['High'],"Wire Transfer Begining for "..self:Nick().." amount: "..(-amount).."to "..(amount))
end
end
 

function Ethereal.PlayerMeta:TransferToWallet(amt)
	self:UpdateBank(-amt)
	self:UpdateWallet(amt)
end