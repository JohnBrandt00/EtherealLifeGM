if CLIENT then
local APP = Ethereal.PeelPad.CreateApp("notifications")

APP.Name = "Notifications"
APP.Description = "Notifications manager"
APP.Icon = Material("materials/ethereal/appicons/notifications.png","noclamp smooth")
APP.Visible = false


	function APP:CreateNotificationsPanel()

	surface.CreateFont( "NumberFont", {font = "Trebuchet24",extended = false,size = 60,weight = 10} )
	surface.CreateFont( "StatusFont", {font = "Trebuchet24",extended = false,size = 20,weight = 5} )
	surface.CreateFont( "InfoFont", {font = "Trebuchet24",extended = false,size = 30,weight = 5} )
	surface.CreateFont( "IconFont", {font = "Trebuchet24",extended = false,size = 25,weight = 5} )

		local statusbar = vgui.Create("DPanel", self.PEELPAD.ScreenPanel)
		statusbar:SetVisible(true)
		statusbar:SetZPos(2)
		statusbar:SetSize(966, 25)
		statusbar:SetPos(0,0)
		function statusbar:Paint(w, h)
			draw.RoundedBox(4, 0, 0, w, 22, Color(25,25,25))
			draw.SimpleText("| "..os.date("%I:%M %p - %a %b %d, %Y" , os.time() ),"StatusFont",95,10,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText("PeelG LTE", "StatusFont", 5,10,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText("Battery "..utf8.char(0xf240), "FA20", w-30,10,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        end

		function draw.Circle(a,b,c,d)local e={}table.insert(e,{x=a,y=b,u=0.5,v=0.5})for f=0,d do local g=math.rad(f/d*-360)table.insert(e,{x=a+math.sin(g)*c,y=b+math.cos(g)*c,u=math.sin(g)/2+0.5,v=math.cos(g)/2+0.5})end;local g=math.rad(0)table.insert(e,{x=a+math.sin(g)*c,y=b+math.cos(g)*c,u=math.sin(g)/2+0.5,v=math.cos(g)/2+0.5})surface.DrawPoly(e)end

		local nfcpanel = vgui.Create("DPanel", self.PEELPAD.ScreenPanel)
		nfcpanel:SetVisible(false)
		nfcpanel:SetZPos(2)
		nfcpanel:SetSize(966, 0)
		nfcpanel:SetPos(0, 0)
		function nfcpanel:Paint(w,h)
			draw.RoundedBox(4, 0, 0, w, 315, Color(230,234,237))
			draw.SimpleText(os.date("%I:%M", os.time() ),"NumberFont",30,10,Color(50,93,131))
			draw.SimpleText(os.date("%p %a, %b %d", os.time() ),"InfoFont",168,35,Color(50,93,131))
			surface.SetDrawColor( 255, 255, 255 )
			draw.NoTexture()
			draw.Circle( 75, 135, 40, 100 ) --wifi circle
			draw.SimpleText("Wi-Fi", "IconFont", 75-21.5, 135+45, Color(48, 92, 131) )
			draw.SimpleText("Apex", "IconFont", 75-21.5, 135+70, Color(106, 137, 164) )
	        draw.Circle( 215-20, 135, 40, 100 )
			draw.SimpleText("Location", "IconFont", 160, 135+45, Color(48, 92, 131) )
 	        draw.Circle( 355-20, 135, 40, 100 )
			draw.SimpleText("Bluetooth", "IconFont", 293.5, 135+45, Color(48, 92, 131) )
	        draw.Circle( 495-20, 135, 40, 100 )
			draw.SimpleText("Power", "IconFont", 445, 135+45, Color(48, 92, 131) )
			draw.SimpleText("saving", "IconFont", 445, 135+65, Color(48, 92, 131) )
	        draw.Circle( 635-20, 135, 40, 100 )
			draw.SimpleText("Airplane", "IconFont", 580, 135+45, Color(48, 92, 131) )
			draw.SimpleText("mode", "IconFont", 590, 135+65, Color(48, 92, 131) )
	        draw.Circle( 775-20, 135, 40, 100 )
			draw.SimpleText("Sync", "IconFont", 733, 135+45, Color(48, 92, 131) )
	        draw.Circle( 915-20, 135, 40, 100 )
			draw.SimpleText("Sound", "IconFont", 866, 135+45, Color(48, 92, 131) )

			if LocalPlayer():Ping() <= 10 then
				surface.SetMaterial(Material("ethereal/wifi-hq4.png","noclamp smooth"))
        	elseif LocalPlayer():Ping() <= 50 then
				surface.SetMaterial(Material("ethereal/wifi-hq3.png","noclamp smooth"))
        	elseif LocalPlayer():Ping() <= 100 then
				surface.SetMaterial(Material("ethereal/wifi-hq2.png","noclamp smooth"))
        	elseif LocalPlayer():Ping() >= 150 then
				surface.SetMaterial(Material("ethereal/wifi-hq1.png","noclamp smooth"))
	        end
	        surface.SetDrawColor(255,255,255)
	        surface.DrawTexturedRect(75-31.3, 105, 64, 64)

	        draw.SimpleText(utf8.char(0xf124),"FA64",165,105,Color(58,144,220),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

	        draw.SimpleText(utf8.char(0xf294),"FA64",315,105,Color(58,144,220),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

	        surface.SetMaterial(Material("ethereal/bsaving.png","noclamp smooth"))
	        surface.SetDrawColor(180,196,209)
	        surface.DrawTexturedRect(443, 105, 64, 64)
	        
	        draw.SimpleText(utf8.char(0xf072),"FA64",588,105,Color(180,196,209),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

	        draw.SimpleText(utf8.char(0xf021),"FA64",728,103,Color(58,144,220),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

	        draw.SimpleText(utf8.char(0xf028),"FA64",864,105,Color(58,144,220),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)



		end


		local cbutton = vgui.Create("DButton", nfcpanel)
		cbutton:SetVisible(false)
		cbutton:SetSize(50, 50)
		cbutton:SetPos(nfcpanel:GetWide() / 2, 292.5)
		cbutton:SetText("")
		function cbutton:Paint()
			draw.RoundedBox(0, 0, 0, 15, 15, Color(0, 0, 0, 0))
			  surface.SetMaterial(Material("ethereal/dropdown up.png","noclamp smooth"))
              surface.SetDrawColor(25,25,25,255)
              surface.DrawTexturedRect(0, 0, 20, 20)
		end
		
		local button = vgui.Create( "DButton", self.PEELPAD.ScreenPanel)
		button:SetSize(50, 50)
		button:SetZPos(3)
		button:SetPos(self.PEELPAD.ScreenPanel:GetWide()/2, 5)
		button:SetText("")
		function button:Paint()
			  surface.SetMaterial(Material("ethereal/dropdown down.png","noclamp smooth"))
              surface.SetDrawColor(255,255,255,255)
              surface.DrawTexturedRect(0, 0, 20, 20)
		end

		cbutton.DoClick = function()
			button:SetVisible(true)
			statusbar:SetVisible(true)
			nfcpanel:SizeTo(966, 0, 1, 0)
		end
		button.DoClick = function()
			statusbar:SetVisible(false)
			button:SetVisible(false)
			nfcpanel:SetVisible(true)
			cbutton:SetVisible(true)
			nfcpanel:SizeTo(966, 315, 1, 0)
		end

		--self.PEELPAD.ScreenPanel is the desktop object, I created the app icons straight there
		--so you could use the same panel object to make the notifications
	end

	function APP:Created()
		self:CreateNotificationsPanel()
	end
end