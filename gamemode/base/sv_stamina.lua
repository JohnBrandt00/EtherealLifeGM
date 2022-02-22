-- Credits go to TheCodingBeast because I can't be arsed to actually code a fuckin stamina system
local DefaultRunSpeed		= 240
local DefaultWalkSpeed		= 160
local DefaultJumpPower		= 200
local DisableLevel			= 10	-- (0 - 100) When should Run & Jump get disabled
local StaminaDrainSpeed 	= 0.1	-- Time in seconds
local StaminaRestoreSpeed 	= 0.075	-- Time in seconds

-- PlayerSpawn
function StaminaStart( ply )
	timer.Destroy( "StaminaTimer" )
	ply:SetRunSpeed( DefaultRunSpeed )
	ply:SetNWInt( "Stamina", 100 )

	StaminaRestore( ply )
end
hook.Add( "PlayerSpawn", "StaminaStart", StaminaStart )

-- KeyPress
function StaminaPress( ply, key )
	if key == IN_SPEED or ply:KeyDown(IN_SPEED) then
		if ply:InVehicle() then return end
		if ply:GetMoveType() == MOVETYPE_NOCLIP then return end
		if ply:GetMoveType() ==  MOVETYPE_LADDER then return end
		if ply:GetNWInt( "Stamina" ) >= DisableLevel then
			ply:SetRunSpeed( DefaultRunSpeed )
			timer.Destroy( "StaminaGain" )
			timer.Create( "StaminaTimer", StaminaDrainSpeed, 0, function( )
				if ply:GetNWInt( "Stamina" ) <= 0 then
					ply:SetRunSpeed( DefaultWalkSpeed )
					timer.Destroy( "StaminaTimer" )
					return false
				end
				local vel = ply:GetVelocity()
				if vel.x >= DefaultWalkSpeed or vel.x <= -DefaultWalkSpeed or vel.y >= DefaultWalkSpeed or vel.y <= -DefaultWalkSpeed then
					ply:SetNWInt( "Stamina", ply:GetNWInt( "Stamina" ) - 1 )
				end
			end)
		else
			ply:SetRunSpeed( DefaultWalkSpeed )
			timer.Destroy( "StaminaTimer" )
		end
	end
	if key == IN_JUMP or ply:KeyDown(IN_JUMP) then
		if ply:GetNWInt( "Stamina" ) >= DisableLevel then
			ply:SetJumpPower( DefaultJumpPower )
			ply:SetNWInt( "Stamina", ply:GetNWInt( "Stamina" ) - 1 )
		else
			ply:SetJumpPower( 0 )
		end
	end
end
hook.Add( "KeyPress", "StaminaPress", StaminaPress ) 

-- KeyRelease
function StaminaRelease( ply, key )
	if key == IN_SPEED and !ply:KeyDown(IN_SPEED) then
		timer.Destroy( "StaminaTimer" )
		StaminaRestore( ply )
	end
end
hook.Add( "KeyRelease", "StaminaRelease", StaminaRelease ) 

-- StaminaRestore
function StaminaRestore( ply )
	timer.Create( "StaminaGain", StaminaRestoreSpeed, 0, function( ) 
		if ply:GetNWInt( "Stamina" ) >= 100 then
			return false
		else
			ply:SetNWInt( "Stamina", ply:GetNWInt( "Stamina" ) + 1 )
		end
	end)
end

