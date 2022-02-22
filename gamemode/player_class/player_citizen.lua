AddCSLuaFile()
DEFINE_BASECLASS( "player_default" )
local PLAYER = {}

PLAYER.DisplayName			= "Ethereal Citizen Class"
PLAYER.WalkSpeed			= 160		-- How fast to move when not running
PLAYER.RunSpeed				= 250		-- How fast to move when running
PLAYER.CrouchedWalkSpeed	= 0.2		-- Multiply move speed by this when crouching
PLAYER.DuckSpeed			= 0.3		-- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed			= 0.3		-- How fast to go from ducking, to not ducking
PLAYER.JumpPower			=220		-- How powerful our jump should be
PLAYER.CanUseFlashlight		= true	-- Can we use the flashlight
PLAYER.MaxHealth			= 100		-- Max health we can have
PLAYER.StartHealth			= 100		-- How much health we start with
PLAYER.StartArmor			= 0			-- How much armour we start with
PLAYER.DropWeaponOnDie		= false		-- Do we drop our weapon when we die
PLAYER.TeammateNoCollide	= true		-- Do we collide with teammates or run straight through them
PLAYER.AvoidPlayers			= true		-- Automatically swerves around other players
PLAYER.UseVMHands			= true		-- Uses viewmodel hands


--function PLAYER:GetHandsModel()
--	local jobTable = VRPJobs[self.Player:Team()]
--	if not jobTable then return end

--	local model = istable(jobTable.model) and jobTable.model[1] or jobTable.model
--	if not model then return end
	
--	local name = player_manager.TranslateToPlayerModelName(model)

--	return player_manager.TranslatePlayerHands(name)
--end

function PLAYER:Spawn()
	local col = self.Player:GetInfo( "cl_playercolor" )
	self.Player:SetPlayerColor( Vector(1,1,1) )

	local col = self.Player:GetInfo( "cl_weaponcolor" )
	self.Player:SetWeaponColor( Vector( col ) )
end

function PLAYER:Loadout()

	

end

player_manager.RegisterClass("player_citizen", PLAYER, "player_default" )