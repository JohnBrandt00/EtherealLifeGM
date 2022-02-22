if CLIENT then
	local APP = Ethereal.PeelPad.CreateApp("gps")

	APP.Name = "GPS"
	APP.Description = "Peelpad's GPS"
	APP.Icon = Material("materials/ethereal/appicons/gps.png","noclamp smooth")

	if CLIENT then
		function APP:Created()
			function self.PANEL:Paint(w, h)
				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawRect(0, 0, w, h)

				local Pos = LocalPlayer():GetPos()
				draw.SimpleText("X: "..Pos.x.." Y: "..Pos.y.." Z: "..Pos.z, "Trebuchet24", 100, 100, Color(255, 255, 255, 255))
			end
		end
	end
end
