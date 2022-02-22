include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:DrawMask( size )
--[[
	local pos = self:GetPos();
	local up = self:GetUp();
	local right = self:GetRight();

	local segments = 12;

	render.SetColorMaterial();

	mesh.Begin( MATERIAL_POLYGON, segments );

	for i = 0, segments - 1 do

		local rot = math.pi * 2 * ( i / segments );
		local sin = math.sin( rot ) * size;
		local cos = math.cos( rot ) * size;

		mesh.Position( pos + ( up * sin ) + ( right * cos ) );
		mesh.AdvanceVertex();

	end

	mesh.End();
	--]]

local angles = self:GetAngles()
angles:RotateAroundAxis(self:GetAngles():Up(),-180)
cam.Start3D2D(self:GetPos()+self:GetAngles():Right()*119+self:GetAngles():Forward()*70+self:GetAngles():Up()*19,angles,1)
	surface.SetDrawColor(color_black)
	local dis = (self:OBBMaxs() - self:OBBMins())
	surface.DrawRect(0,0,dis.x,dis.y)
cam.End3D2D()
--self:DrawModel()
end


function ENT:DrawInterior()
	--self:DrawModel()

	if not self.WallLeft then self.WallLeft = ClientsideModel("models/hunter/plates/plate3x5.mdl",RENDERGROUP_BOTH) self.WallLeft:SetNoDraw(true) end
	self.WallLeft:SetPos(self:GetPos()+self:GetAngles():Up()*-70+self:GetAngles():Forward()*-70)
	if not self.WallRight then self.WallRight = ClientsideModel("models/hunter/plates/plate3x5.mdl",RENDERGROUP_BOTH) self.WallRight:SetNoDraw(true) end
	self.WallRight:SetPos(self:GetPos()+self:GetAngles():Up()*-70+self:GetAngles():Forward()*70)
	if not self.WallFloor then self.WallFloor = ClientsideModel("models/hunter/plates/plate3x5.mdl",RENDERGROUP_BOTH) self.WallFloor:SetNoDraw(true) self.WallFloor:SetPos(self:GetPos()+self:GetAngles():Up()*-140) end
																																																							
	if not self.WallFront then self.WallFront = ClientsideModel("models/hunter/plates/plate3x3.mdl",RENDERGROUP_BOTH) self.WallFront:SetNoDraw(true) end
	self.WallFront:SetPos(self:GetPos()+self:GetAngles():Up()*-70+self:GetAngles():Right()*-120)
if not self.WallBack then self.WallBack = ClientsideModel("models/hunter/plates/plate3x3.mdl",RENDERGROUP_BOTH) self.WallBack:SetNoDraw(true) end
	self.WallBack:SetPos(self:GetPos()+self:GetAngles():Up()*-70+self:GetAngles():Right()*120)
	if not self.CarModel then self.CarModel = ClientsideModel("models/tdmcars/mclaren_mp412cgt3.mdl",RENDERGROUP_BOTH) self.CarModel:SetNoDraw(true) self.CarModel:SetPos(self:GetPos()+self:GetAngles():Up()*-140) self.CarModel.OriginPos = self.CarModel:GetPos() end
	



	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(),-90)
	
	self.WallLeft:SetAngles(ang)
	self.WallRight:SetAngles(ang)
	ang:RotateAroundAxis(self:GetAngles():Right(),90)
	self.WallFloor:SetAngles(ang)
	ang:RotateAroundAxis(self:GetAngles():Right(),-90)
	ang:RotateAroundAxis(self:GetAngles():Up(),90)
	self.WallFront:SetAngles(ang)
	self.WallBack:SetAngles(ang)

	ang:RotateAroundAxis(self:GetAngles():Right(),90)
	ang:RotateAroundAxis(self:GetAngles():Up(),0)
	ang:RotateAroundAxis(self:GetAngles():Forward(),90)

	self.CarModel:SetAngles(ang)
self.CarModel:DrawModel()
		render.OverrideDepthEnable( true, false )
	--render.SetLightingMode( 1 )
	--render.SetAmbientLight( 255,0,0 )

	
	self.WallLeft:DrawModel()
	self.WallRight:DrawModel()
	self.WallFront:DrawModel()
	self.WallBack:DrawModel()
	self.WallFloor:DrawModel()
	

	render.OverrideDepthEnable( false, true )
	--render.SetLightingMode( 0 )


end
	

function ENT:DrawOverlay()
	
end

function ENT:AnimateUp()

self.CarModel:SetPos(LerpVector(FrameTime()*0.8, self.CarModel:GetPos(),self:GetPos()+self:GetAngles():Up()*0 ))
self.WallFloor:SetPos(LerpVector(FrameTime()*0.8, self.WallFloor:GetPos(),self:GetPos()+self:GetAngles():Up()*0 ))	
if(self.CarModel:GetPos():Distance(self:GetPos()+self:GetAngles():Up()*0) < 50  ) then
	self.CarModel:SetNoDraw(false)
else
	self.CarModel:SetNoDraw(true)
end
end 


function ENT:AnimateDown()

self.CarModel:SetPos(LerpVector(FrameTime()*0.8, self.CarModel:GetPos(),self:GetPos()+self:GetAngles():Up()*-140 ))	
self.WallFloor:SetPos(LerpVector(FrameTime()*0.8, self.WallFloor:GetPos(),self:GetPos()+self:GetAngles():Up()*-140 ))
if(self.CarModel:GetPos():Distance(self:GetPos()+self:GetAngles():Up()*0) > 50  ) then
	self.CarModel:SetNoDraw(true)
end
end


function ENT:Draw()
self:DrawModel()
	render.ClearStencil();
	render.SetStencilEnable( true );
				render.SetStencilWriteMask( 1 )
				render.SetStencilTestMask( 1 )
				

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
	self:AnimateDown()

	cam.IgnoreZ(false)
	
		render.SetStencilWriteMask( 0 )
				render.SetStencilTestMask( 0 )
	render.SetStencilEnable( false );

	self:DrawOverlay();

end