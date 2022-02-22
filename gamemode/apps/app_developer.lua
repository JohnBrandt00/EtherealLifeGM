if CLIENT then
	local APP = Ethereal.PeelPad.CreateApp("developer")

	APP.Name = "Developer"
	APP.Description = "Developer's IDE"
	APP.Icon = Material("materials/ethereal/appicons/developer.png","noclamp smooth")
	APP.Visible = false
end
