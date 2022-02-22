if CLIENT then
	local APP = Ethereal.PeelPad.CreateApp("browser")

	APP.Name = "Browser"
	APP.Description = "Peelpad's Browser"
	APP.Icon = Material("materials/ethereal/appicons/internet.png","noclamp smooth")


function APP:Created()
		self.PANEL.Frame = vgui.Create("DHTML",self.PANEL)
		self.PANEL.Frame:SetPos( 0,0 )
		self.PANEL.Frame:SetSize(self.PANEL:GetSize())
		self.PANEL.Frame:OpenURL("www.youtube.com")
		self.PANEL.Frame:SetZPos(10)
		self.PANEL.Frame:RequestFocus()
		self.PANEL.Frame:SetAllowLua( true )

end


end


