if CLIENT then
	local APP = Ethereal.PeelPad.CreateApp("phone")

	APP.Name = "Phone"
	APP.Description = "Phone"
	APP.Icon = Material("materials/ethereal/appicons/phone.png","noclamp smooth")

	local PANEL = {}
	function PANEL:Init()
	end

	function APP:Created()
		self.PANEL.Frame = vgui.Create("DPanel",self.PANEL)
		self.PANEL.Frame:SetPos( 0,0 )
		self.PANEL.Frame:SetSize(self.PANEL:GetSize())
		function self.PANEL.Frame:Paint( w, h )
			draw.RoundedBox( 8, 0, 0, w, h, Color( 215, 215, 215 ) )
			surface.SetDrawColor(93, 107, 118, 255)
			surface.DrawRect(0, 0, w, h)
			draw.RoundedBoxEx( 8, 40, 0, self:GetWide()-80, self:GetTall()-40, Color( 255, 255, 255 ),false,false,true,true )
			surface.SetDrawColor(255, 255, 255, 255)

			draw.SimpleText(utf8.char(0xf098)..GetPlayerValue("PhoneNumber",0),"FA24",909,445,Color(93, 107, 118, 255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
		end

		self.PANEL.Dialpad = vgui.Create("DPanel",self.PANEL.Frame)
		self.PANEL.Dialpad:SetSize(208,274)
		self.PANEL.Dialpad:SetPos(80,120)
		self.PANEL.Dialpad:SetBackgroundColor(0,0,0,0)
		function self.PANEL.Dialpad:Paint(w,h)
			draw.RoundedBox(8,0,0,w,h,Color(187,211,218,255))
			draw.RoundedBox(7,2,2,w-4,h-4,Color(255,255,255,255))
		end

		self.PANEL.Dialnums = vgui.Create( "DIconLayout", self.PANEL.Dialpad )
		self.PANEL.Dialnums:SetSize( self.PANEL.Dialpad:GetSize() )
		self.PANEL.Dialnums:SetPos( 6, 6 )
		self.PANEL.Dialnums:SetSpaceY( 2 )
		self.PANEL.Dialnums:SetSpaceX( 2 )

		for i = 1, 9 do
			self.PANEL.Dialnum = self.PANEL.Dialnums:Add( "DButton" )
			self.PANEL.Dialnum:SetSize( 64, 64 )
			self.PANEL.Dialnum:SetText(i)
			function self.PANEL.Dialnum:Paint(w,h)
				if self:IsHovered() then
					draw.RoundedBox(6,0,0,w,h,Color(136,154,166,255))
				elseif self:IsDown() then
					draw.RoundedBox(6,0,0,w,h,Color(82,109,125,255))
				else
					draw.RoundedBox(6,0,0,w,h,Color(189,214,230,255))
				end
			end
			function self.PANEL.Dialnum:DoClick()
				LocalPlayer():PrintMessage( HUD_PRINTTALK, self:GetText() )
			end
		end
		for i = 10, 12 do
			self.PANEL.Dialnum = self.PANEL.Dialnums:Add( "DButton" )
			self.PANEL.Dialnum:SetSize( 64, 64 )
			function self.PANEL.Dialnum:Paint(w,h)
				if self:IsHovered() then
					draw.RoundedBox(6,0,0,w,h,Color(136,154,166,255))
				elseif self:IsDown() then
					draw.RoundedBox(6,0,0,w,h,Color(82,109,125,255))
				else
					draw.RoundedBox(6,0,0,w,h,Color(189,214,230,255))
				end
			end
			function self.PANEL.Dialnum:DoClick()
				LocalPlayer():PrintMessage( HUD_PRINTTALK, self:GetText() )
			end
		end
	end
end
