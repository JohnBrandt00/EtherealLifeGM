local PANEL = Ethereal.PeelPad.PANEL

if not PANEL then
	PANEL = {}
	Ethereal.PeelPad.PANEL = PANEL
end

PANEL.TabletMat = Material("materials/ethereal/peelpad.png","noclamp smooth")
PANEL.TabletGlassMat = Material("ethereal/glass.png","noclamp smooth")
PANEL.TabletLoadMat = Material("materials/ethereal/load.png","noclamp smooth")
PANEL.TabletBackgroundMat = Material("materials/ethereal/bg.png","noclamp smooth")

function PANEL:Init()
	self:SetSize(1080, 730)
	self:Center()

	self.CloseButton = vgui.Create("DButton", self)
	self.CloseButton:SetSize(55, 55)
	self.CloseButton:SetPos(12, 730/2-27)
	self.CloseButton:SetText('')

	function self.CloseButton:Paint(w,h)
		if self:IsHovered() then
			draw.RoundedBox(10, 0, 0, w, h, Color(255,255,255,20))
		end
	end

	function self.CloseButton.DoClick()
		local IsAppVisible = false
		for ID, Application in pairs(self.App) do
			if Application.PANEL:IsVisible() then
				if Application:ShouldClose() then
					Application:Close()
				end
				IsAppVisible = true
				break
			end
		end
		if not IsAppVisible then
			self:Remove()
		end
	end

	self.ScreenPanel = vgui.Create("DPanel", self)
	self.ScreenPanel:SetSize(966, 700)
	self.ScreenPanel:SetPos(74, 15)

	function self.ScreenPanel.Paint(s, w, h)
		if self.ON then
			surface.SetMaterial(self.TabletBackgroundMat)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(0, 0, w, h)
		else
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawRect(0, 0, w, h)
		end
	end

	function self.ScreenPanel.PaintOver(s, w, h)
		surface.SetMaterial(self.TabletGlassMat)
		surface.SetDrawColor(255, 255, 255, 127)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	self.PowerButton = vgui.Create("DButton", self)
	self.PowerButton:SetSize(30, 8)
	self.PowerButton:SetPos(990, 0)
	self.PowerButton:SetText('')

	function self.PowerButton:Paint(w, h)
		if self:IsHovered() then
			surface.SetDrawColor(Color(255, 255, 255, 20))
			surface.DrawRect(0, 0, w, h)
		end
	end

	function self.PowerButton.DoClick()
		if self.ON then
			self:TurnOff()
		else
			self:TurnOn()
		end
	end

	self:TurnOn()
end

function PANEL:TurnOn()
	if not self.ON then
		self.ON = true

		self.BootPanel = vgui.Create("DPanel", self)
		self.BootPanel:SetSize(966, 700)
		self.BootPanel:SetPos(74, 15)
		self.BootPanel:AlphaTo(0, 2, 1, function () self.BootPanel:Remove() end)
		function self.BootPanel.Paint(s, w, h)
			surface.SetMaterial(self.TabletLoadMat)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(0, 0, w, h)
		end 

		self.App = {}
		for ID, _ in pairs(Ethereal.PeelPad.App) do
		Ethereal:DebugPrint(Ethereal.DebugLevels['Developer'],"Created App ID: "..ID)
			local Application = Ethereal.PeelPad.CreateAppInstance(ID)
			Application.PEELPAD = self
			Application.PANEL = vgui.Create("DPanel", self.ScreenPanel)
			Application.PANEL:SetSize(966, 700)
			Application.PANEL:SetZPos(-1)
			Application.PANEL:Hide()

			self.App[ID] = Application
		end

		for ID, Application in pairs(self.App) do
			Application:Created()
		end
	end
	surface.PlaySound( "pad_start.wav" )
end

function PANEL:TurnOff()
	if self.ON then
		self.ON = false

		self.BootPanel = vgui.Create("DPanel", self)
		self.BootPanel:SetSize(966, 700)
		self.BootPanel:SetPos(74, 15)
		self.BootPanel:AlphaTo(0, 2, 1, function () self.BootPanel:Remove() end)
		function self.BootPanel.Paint(s, w, h)
			surface.SetMaterial(self.TabletLoadMat)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(0, 0, w, h)
		end

		for ID, Application in pairs(self.App) do
			Application:Kill()
		end
		self.App = {}

		for Index, Panel in pairs(self.ScreenPanel:GetChildren()) do
			Panel:Remove()
		end
	end
	surface.PlaySound( "toggle_off.wav" )
end

function PANEL:Paint(w,h)
	surface.SetMaterial(self.TabletMat)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0,0,w,h)
end

function PANEL:Think()
	if self.App then
		for ID, Application in pairs(self.App) do
			if Application.Background or Application.IsOpen then
				Application:Think()
			end
		end
	end
end

vgui.Register("E_PeelPadPro2", PANEL)

concommand.Add("peelpad",
	function ()
		pad = vgui.Create("E_PeelPadPro2")
		pad:MakePopup(true)
	end
)
