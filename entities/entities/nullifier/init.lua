AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )
include("shared.lua") 

function ENT:Initialize()

	self:SetModel( "models/props/ethereal_garage.mdl" ) 
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	--self:SetCollisionGroup(COLLISION_GROUP_WORLD)
    local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
			phys:SetMass(10)
		end
end
          

function ENT:Think()

end

function ENT:OnTakeDamage()

end

function ENT:AcceptInput( Name, Activator, Caller )
	if Name == "Use" and Caller:IsPlayer() then

	end
end








