include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:Initialize()
self.LightModel = ClientsideModel("models/props_wasteland/light_spotlight02_lamp.mdl",RENDERGROUP_BOTH)
self.LightModel:SetNoDraw(false)
self.LightModel:SetModelScale(2,0)
self.LightModel:SetAngles(self:GetAngles()+Angle(45,0,0))
self.LightModel:SetPos(self:GetPos()+self:GetAngles():Up()*10)
self.LightModel:SetParent(self)

self.Tube = ClientsideModel("models/props_phx/construct/metal_tube.mdl",RENDERGROUP_BOTH) 
self.Tube:SetNoDraw(true)
self.Tube:SetPos(self:GetPos()+self:GetAngles():Up()*1.5)
self.Tube:SetAngles(self:GetAngles())
self.Tube:SetParent(self)
end


function ENT:DrawMask( )

local angles = self:GetAngles()

cam.Start3D2D(self:GetPos()+self:GetAngles():Up()*1+self:GetAngles():Right()*-23.5+self:GetAngles():Forward()*-23.5,angles,1)
	surface.SetDrawColor(color_black)
	local dis = (self:OBBMaxs() - self:OBBMins())
	surface.DrawRect(0,0,dis.x-0.5,dis.y-0.5)
cam.End3D2D()
--self:DrawModel()
end

function ENT:DrawInterior()
--	render.OverrideDepthEnable( true, false )
		self.Tube:DrawModel()
		self.LightModel:DrawModel()
	--render.OverrideDepthEnable( false, true )

end

function ENT:OnRemove()
	self.LightModel:Remove()
	self.Tube:Remove()
end


function ENT:Draw()


--self:DrawModel()

	render.ClearStencil();
	render.SetStencilEnable( true );
				render.SetStencilWriteMask( 2 )
				render.SetStencilTestMask( 2 )
				

				render.SetStencilCompareFunction( STENCIL_ALWAYS )
				render.SetStencilPassOperation( STENCIL_REPLACE )
				render.SetStencilFailOperation( STENCIL_KEEP )
				render.SetStencilZFailOperation( STENCIL_KEEP )
				render.SetStencilReferenceValue( 255 )
			self:DrawMask( );



	render.SetStencilCompareFunction( STENCIL_EQUAL )
	render.SetStencilPassOperation( STENCIL_KEEP )
	-- clear the inside of our mask so we have a nice clean slate to draw in.
	--render.ClearBuffersObeyStencil( 0, 0, 0, 0, true );

	cam.IgnoreZ( true )
	
	self:DrawInterior();


	cam.IgnoreZ(false)
	
		render.SetStencilWriteMask( 0 )
				render.SetStencilTestMask( 0 )


 local fov = LocalPlayer():GetActiveWeapon().ViewModelFOV or (LocalPlayer():GetFOV() - 21.5)
        cam.Start3D( EyePos(), EyeAngles(), fov + 15)
        cam.IgnoreZ( true )
            LocalPlayer():GetViewModel():DrawModel()
        cam.IgnoreZ( false )
        cam.End3D()

	render.SetStencilEnable( false );


end