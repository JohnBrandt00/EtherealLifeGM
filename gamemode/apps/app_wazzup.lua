if CLIENT then
	local APP = Ethereal.PeelPad.CreateApp("wazzup")

	APP.Name = "Wazzup"
	APP.Description = "Wazzup"
	APP.Icon = Material("materials/ethereal/appicons/wazzup.png","noclamp smooth")
	Ethereal.PeelPad.Global["Station"] = nil
	
	function APP:Created()
			function self.PANEL:Paint(w, h)
				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawRect(0, 0, w, h)

				local Pos = LocalPlayer():GetPos()
				draw.SimpleText("X: "..Pos.x.." Y: "..Pos.y.." Z: "..Pos.z, "Trebuchet24", 100, 100, Color(255, 255, 255, 255))
			end
		end
	
	function APP:Open()
	if(Ethereal.PeelPad.Global["Station"]) then Ethereal.PeelPad.Global["Station"]:Stop() end
	sound.PlayURL ( "http://17023.live.streamtheworld.com/WNEWFM_SC", "", function( station ) 
		if ( IsValid( station ) ) then
		Ethereal.PeelPad.Global["Station"] = station
		--Ethereal.PeelPad.Global["Station"]:SetPos( LocalPlayer():GetPos() ) 

		Ethereal.PeelPad.Global["Station"]:Play()

		Ethereal.PeelPad.Global["Station"]:SetVolume( 0.6 )

		else 
		LocalPlayer():ChatPrint( "Invalid URL!" )

		end
		end )
		
		self.PANEL:Show()
		self.PANEL:SetZPos(1)
		self.IsOpen = true
		
	end
	
	function APP:GlobalThink()
	if(IsValid(Ethereal.PeelPad.Global["Station"])) then 
		--Ethereal.PeelPad.Global["Station"]:SetPos(LocalPlayer():GetPos())
	end
	end
	hook.Add("Think",APP.Name.."think",function() APP:GlobalThink() end)
	
	
end
