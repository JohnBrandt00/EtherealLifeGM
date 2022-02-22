if CLIENT then
	local APP = Ethereal.PeelPad.CreateApp("camera")

	APP.Name = "Camera"
	APP.Description = "Peelpad's Camera"
	APP.Icon = Material("materials/ethereal/appicons/camera.png","noclamp smooth")


	function APP:Created()
		--self.PANEL.Frame = vgui.Create("DPanel",self.PANEL)
		--self.PANEL.Frame:SetPos( 0,0 )
		--self.PANEL.Frame:SetSize(self.PANEL:GetSize())
		function self.PANEL:Paint( w, h )
			local x, y = self:GetPos()

			render.RenderView( {
				origin = Vector( 0, 0, 0 ), -- change to your liking
				angles = Angle( 0, 0, 0 ), -- change to your liking
				x = x,
				y = y,
				w = w,
				h = h,
			 } )

		end

	end


end





