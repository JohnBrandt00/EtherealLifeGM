AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )
include("shared.lua") 

function ENT:Initialize()

	self:SetModel( "models/hunter/plates/plate1x1.mdl" ) 
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	--self:SetCollisionGroup(COLLISION_GROUP_WORLD)
    local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
			phys:SetMass(1000)
		end

end
          

function ENT:Think()

end 

function ENT:AnimateUp()



end

function ENT:AnimateDown()

end

function ENT:OnRemove()
	
end


function ENT:OnTakeDamage()

end

function ENT:AcceptInput( Name, Activator, Caller )
	if Name == "Use" and Caller:IsPlayer() then

	end
end








