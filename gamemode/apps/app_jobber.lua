if CLIENT then
	local APP = Ethereal.PeelPad.CreateApp("jobber")

	APP.Name = "Jobber"
	APP.Description = "Job Market for the poor"
	APP.Icon = Material("materials/ethereal/appicons/jobber.png","noclamp smooth")

	function APP:Created()
		self.PANEL.Frame = vgui.Create("DPanel",self.PANEL)
		self.PANEL.Frame:SetPos( 0,0 )
		self.PANEL.Frame:SetSize(self.PANEL:GetSize())
		function self.PANEL.Frame:Paint( w, h )
			draw.RoundedBox( 8, 0, 0, w, h, Color( 255, 255, 255 ) )
			draw.RoundedBoxEx(8,0,0,w,80,Color(210,228,240),true,true,false,false)
		end

		self.PANEL.Label = vgui.Create("DLabel",self.PANEL)
		self.PANEL.Label:SetPos(10,40)
		self.PANEL.Label:SetAutoStretchVertical(true)
		self.PANEL.Label:SetTextColor(Color(48,71,87))
		self.PANEL.Label:SetSize(self.PANEL:GetWide(),self.PANEL.Label:GetTall())
		self.PANEL.Label:SetFont("DermaLarge")
		self.PANEL.Label:SetText("Get a job you lazy fuck")

		-- player:GetPlayerValue("Wallet",defaultvalue) player:GetPlayerValue("Bank",defaultvalue)

	end
end
