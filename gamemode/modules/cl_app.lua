local APP = {}

Ethereal.PeelPad.App = Ethereal.PeelPad.App or {}
Ethereal.PeelPad.Global = {} 
function Ethereal.PeelPad.CreateApp(ID)
	local App = {}
	App.ID = ID
	App.__index = App

	Ethereal.PeelPad.App[App.ID] = App

	return setmetatable(App, APP)
end

function Ethereal.PeelPad.CreateAppInstance(ID)
	return setmetatable({}, Ethereal.PeelPad.App[ID])
end

APP.__index = APP
APP.Name = "Application"
APP.Description = "A peelpad application"
APP.Icon = Material("materials/ethereal/appicons/app.png")

APP.Visible = true
APP.AdminOnly = false
APP.Background = false
APP.AllowedUserGroups = {}
APP.JobSpecific = {}

for Index, Application in pairs(Ethereal.PeelPad.App) do
	setmetatable(Application, APP)
end
 
if CLIENT then
	function APP:Open()
		self.PANEL:Show()
		self.PANEL:SetZPos(1)
		self.IsOpen = true
		--surface.PlaySound( "pad_start.wav" )
	end

	function APP:Close()
		self.PANEL:Hide()
		self.PANEL:SetZPos(-1)
		self.IsOpen = nil
		--surface.PlaySound( "toggle_off.wav" )
	end

	function APP:ShouldClose()
		return true
	end

	function APP:Think()
	end

	function APP:Paint(w, h)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, w, h)
	end

	function APP:Created()
		-- This is called when a new instance of this app is created
	end

	function APP:Kill()
	end
	

end
