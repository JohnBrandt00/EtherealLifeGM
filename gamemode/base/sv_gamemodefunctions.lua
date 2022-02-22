function GM:Initialize()

	--hook.Call("InitializePlayerDatabase")
	hook.Call("LoadDataProvider",self)
	
end

function GM:PlayerInitialSpawn(ply)

	self.BaseClass:PlayerInitialSpawn(ply)
	ply:SetTeam(TEAM_CITIZEN)
	ply:GetPlayerOrCreate()

end

function GM:PlayerSetModel(ply)
	
	ply:SetupHands()
end

function GM:PlayerSpawn(ply)
	
	ply:SetNoCollideWithTeammates(false)
	ply:CrosshairEnable()
	ply:UnSpectate()
	self:PlayerLoadout(ply)
	
	self.BaseClass:PlayerSpawn(ply)

	ply:SetHealth( 100 )
	
	player_manager.SetPlayerClass(ply, "player_citizen")
	player_manager.OnPlayerSpawn( ply )
	player_manager.RunClass( ply, "Spawn" )
	
	--ply:GetPlayerInfo()
	ply:SetupHands()
	
	end


-- Choose the model for hands according to their player model.
function GM:PlayerSetHandsModel(ply, ent)
    local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel())
    local info = player_manager.TranslatePlayerHands(simplemodel)

    if (info) then
        ent:SetModel(info.model)
        ent:SetSkin(info.skin)
        ent:SetBodyGroups(info.body)
    end
end

-- player customization with a peelpad app, so this will become redundant
function GM:PlayerSetModel(ply)
    --local cl_playermodel = ply:GetPlayerValue("Model","models/player/Group01/male_02.mdl")

    local modelname = player_manager.TranslatePlayerModel(cl_playermodel)
	--local modelname = cl_playermodel
    util.PrecacheModel(modelname)
    ply:SetModel(modelname)
end



function GM:PlayerDisconnected( ply )
	 PrintMessage( HUD_PRINTTALK, ply:Name().. " has left the server." )
	 hook.Call("SavePlayer",GAMEMODE,ply)
end 
 
function GM:PlayerLoadout( ply )
ply:Give("hands")
end


function GM:ShowSpare2( ply )
	ply:ConCommand("peelpad")
end

--function GM:PlayerCanHearPlayersVoice(  listener,  talker )

--if listener:GetPos():Distance( talker:GetPos() ) > 200 then return false end

--if(listener:GetPos():Distance(talker:GetPos()) < 200) then return true 
--elseif( talker:IsLineOfSightClear(listener) and talker:GetPos():Distance(listener:GetPos()) < 600)then return true else
--return false
--end
--end



















