if CLIENT then 
	local function DrawRoundedBox( _r, _x, _y, _w, _h )
		_r = _r > 8 and 16 or 8
		local _u = ( _x + _r * 1 ) - _x
		local _v = ( _y + _r * 1 ) - _y
		local points = 64
		local slices = ( 2 * math.pi ) / points
		local poly = {  }
		X, Y = _w-_r, _h-_r
		for i = 0, points-1 do
			local angle = ( slices * i ) % points
			local x = X + _r * math.cos( angle )
			local y = Y + _r * math.sin( angle )
			if i == points/4-1 then
				X, Y = _x+_r, _h-_r
				table.insert( poly, { x = X, y = Y, u = _u, v = _v } )
			elseif i == points/2-1 then
				X, Y = _x, _r
				table.insert( poly, { x = X, y = Y, u = _u, v = _v } )
				X = _x+_r
			elseif i == 3*points/4-1 then
				X, Y = _w-_r, 0
				table.insert( poly, { x = X, y = Y, u = _u, v = _v } )
				Y = _r
			end
			table.insert( poly, { x = x, y = y, u = _u, v = _v } )
		end
		return poly
	end
	local poly = DrawRoundedBox( 8, 0, 0, 64, 64 )
	local _material = Material( "effects/flashlight001" ); 
	local PANEL = {}
	function PANEL:Init()
		self.Avatar = vgui.Create("AvatarImage", self)
		self.Avatar:SetPaintedManually(true)
	end
	function PANEL:PerformLayout()
		self.Avatar:SetSize(self:GetWide(), self:GetTall())
	end
	function PANEL:Paint(w, h)
		render.ClearStencil()
		render.SetStencilEnable(true)
		render.SetStencilWriteMask( 1 )
		render.SetStencilTestMask( 1 )
		render.SetStencilFailOperation( STENCILOPERATION_REPLACE )
		render.SetStencilPassOperation( STENCILOPERATION_ZERO )
		render.SetStencilZFailOperation( STENCILOPERATION_ZERO )
		render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_NEVER )
		render.SetStencilReferenceValue( 1 )
		draw.NoTexture( );
		surface.SetMaterial( _material );
		surface.SetDrawColor( color_black )
		surface.DrawPoly( poly )
		render.SetStencilFailOperation( STENCILOPERATION_ZERO )
		render.SetStencilPassOperation( STENCILOPERATION_REPLACE )
		render.SetStencilZFailOperation( STENCILOPERATION_ZERO )
		render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
		render.SetStencilReferenceValue( 1 )
		self.Avatar:SetPaintedManually(false)
		self.Avatar:PaintManual()
		self.Avatar:SetPaintedManually(true)
		render.SetStencilEnable(false)
		render.ClearStencil()
	end

	vgui.Register("AvatarMask", PANEL)

	local Gradient = Material("VGUI/gradient_down")
	local BankIcon = Material("materials/ethereal/appassets/banklogo.png","noclamp smooth")

	local APP = Ethereal.PeelPad.CreateApp("bank")

	APP.Name = "Bank"
	APP.Description = "Bank"
	APP.Icon = Material("materials/ethereal/appicons/bank.png","noclamp smooth")

	surface.CreateFont("Header",{
		font = "Borda 4",
		size = 30,
		weight = 700,
		antialias = true,
	})
	surface.CreateFont("AccLabel",{
		font = "Borda 4",
		size = 26,
		weight = 700,
		antialias = true,
	}) 
	surface.CreateFont("LogFont",{
		font = "Borda 4",
		size = 18,
		weight = 700,  
		antialias = true,
	})

	function APP:Created()
		self.PANEL.Frame = vgui.Create("DPanel",self.PANEL)
		self.PANEL.Frame:SetPos( 0,0 )
		self.PANEL.Frame:SetSize(self.PANEL:GetSize())
		function self.PANEL.Frame:Paint( w, h )
			draw.RoundedBox( 8, 0, 0, w, h, Color( 215, 215, 215 ) )
			surface.SetMaterial(Gradient)
			surface.SetDrawColor(93, 107, 118, 255)
			surface.DrawTexturedRect(0, 0, w, h)
			draw.RoundedBoxEx( 8, 40, 0, self:GetWide()-80, self:GetTall()-40, Color( 255, 255, 255 ),false,false,true,true )
			draw.RoundedBoxEx(8,0,0,w,80,Color(255,255,255),true,true,false,false)
			draw.RoundedBox( 0, 0, 80, w, 2, Color( 25, 25, 25 ) )
			surface.SetMaterial(BankIcon)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(7, 27, 48, 48)
			draw.RoundedBox( 0, 40, 220, w-80, 4, Color( 211, 211, 211 ) )

			-- Label for Balance
			draw.SimpleText("Balance: $"..GetPlayerValue("Bank",0),"AccLabel",909,445,Color(93, 107, 118, 255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
		end
		-- Bank Header
		self.PANEL.Header = vgui.Create("DLabel",self.PANEL)
		self.PANEL.Header:SetPos(64,36)
		self.PANEL.Header:SetTextColor(Color(48,71,87))
		self.PANEL.Header:SetAutoStretchVertical(true)
		self.PANEL.Header:SetSize(self.PANEL:GetWide(),self.PANEL.Header:GetTall())
		self.PANEL.Header:SetFont("Header")
		self.PANEL.Header:SetText("Greedbank Federal Credit Union - Welcome, "..GetPlayerValue("FirstName",LocalPlayer():Nick()).." "..GetPlayerValue("LastName",""))

		-- User Avatar
		self.PANEL.Avatar = vgui.Create( "AvatarMask", self.PANEL )
		self.PANEL.Avatar:SetPos( 54, 97 )
		self.PANEL.Avatar:SetSize( 64,64 )
		self.PANEL.Avatar.Avatar:SetPlayer( LocalPlayer(),64 )

		-- Transfer button
		self.PANEL.TransferBtn = vgui.Create("DButton",self.PANEL)
		self.PANEL.TransferBtn:SetPos(139,82)
		self.PANEL.TransferBtn:SetText(utf8.char(0xf0ec).." Transfer")
		self.PANEL.TransferBtn:SetFont("FA18")
		self.PANEL.TransferBtn:SetTextColor(Color(239,239,239,255))
		self.PANEL.TransferBtn:SetSize(1,35)
		self.PANEL.TransferBtn:SizeToContentsX(20)
		function self.PANEL.TransferBtn:Paint(w,h)
			if (self:IsHovered()) then
				draw.RoundedBoxEx(8,0,0,w,h,Color(113, 127, 138),false,false,true,true)
			else
				draw.RoundedBoxEx(8,0,0,w,h,Color(93, 107, 118),false,false,true,true)
			end
		end

		-- Pending Transactions button
		self.PANEL.PendingBtn = vgui.Create("DButton",self.PANEL)
		self.PANEL.PendingBtn:SetPos(250,82)
		self.PANEL.PendingBtn:SetText(utf8.char(0xf017).." Pending Transactions")
		self.PANEL.PendingBtn:SetFont("FA18")
		self.PANEL.PendingBtn:SetTextColor(Color(239,239,239,255))
		self.PANEL.PendingBtn:SetSize(1,35)
		self.PANEL.PendingBtn:SizeToContentsX(20)
		function self.PANEL.PendingBtn:DoClick()
			AddELNotice( "Some test shit 1231414", NOTIFY_MONEY, 5 )
		end
		function self.PANEL.PendingBtn:Paint(w,h)
			if (self:IsHovered()) then
				draw.RoundedBoxEx(8,0,0,w,h,Color(113, 127, 138),false,false,true,true)
			else
				draw.RoundedBoxEx(8,0,0,w,h,Color(93, 107, 118),false,false,true,true)
			end
		end

		-- Label for Checking account
		self.PANEL.CheckingLabel = vgui.Create("DLabel",self.PANEL)
		self.PANEL.CheckingLabel:SetPos(55,190)
		self.PANEL.CheckingLabel:SetTextColor(Color(48,71,87))
		self.PANEL.CheckingLabel:SetAutoStretchVertical(true)
		self.PANEL.CheckingLabel:SetSize(self.PANEL:GetWide(),self.PANEL.CheckingLabel:GetTall())
		self.PANEL.CheckingLabel:SetFont("AccLabel")
		self.PANEL.CheckingLabel:SetText("Greedbank Checking Account - "..LocalPlayer():SteamID64())

		-- Recent transactions
		self.PANEL.BankLog = vgui.Create( "DListView", self.PANEL)
		self.PANEL.BankLog:SetMultiSelect( false )
		self.PANEL.BankLog:AddColumn( "Time" ):SetFixedWidth( 160 )
		self.PANEL.BankLog:AddColumn( "Transaction Name" ):SetFixedWidth( 531 )
		self.PANEL.BankLog:AddColumn( "Amount" ):SetFixedWidth( 160 )
		self.PANEL.BankLog:SetPos(55,230)
		self.PANEL.BankLog:SetSize(851,200)
		self.PANEL.BankLog:SetHeaderHeight( 26 )
		self.PANEL.BankLog:SetDataHeight( 30 )
		self.PANEL.BankLog:SetPaintBackground(false)
		function self.PANEL.BankLog:Paint(w,h)
			draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255 ) )
		end
		-- TESTING VARIABLES
		local Timestamp = os.time()
		local TimeString = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp )
		self.PANEL.BankLog:AddLine( TimeString, "WireTransfer (SetuSertao)", "$49" )
		self.PANEL.BankLog:AddLine( TimeString, "Apples", "($3)" )
		self.PANEL.BankLog:AddLine( TimeString, "Oranges", "($19)" )

		self.PANEL.BankLog.oldLayout = self.PANEL.BankLog.PerformLayout

		function self.PANEL.BankLog:PerformLayout(w,h)
			for _,line in pairs(self:GetLines()) do 
				function line:Paint(w,h) 
					if ( self:IsHovered() ) then
						draw.NoTexture()
						surface.SetDrawColor(Color(158,191,217))
						surface.DrawRect(0,0,line:GetWide(),line:GetTall()) 
					elseif ( self:GetAltLine() ) then
						draw.NoTexture()
						surface.SetDrawColor(Color(215,215,215))
						surface.DrawRect(0,0,line:GetWide(),line:GetTall()) 
					else
						draw.NoTexture()
						surface.SetDrawColor(Color(239,239,239))
						surface.DrawRect(0,0,line:GetWide(),line:GetTall()) 
					end
				end
				for _,column in pairs( line["Columns"] ) do
					column:SetFont( "LogFont" )
					column:SetTextColor( Color(48,71,87) )
				end
			end

			for _,v in pairs( self.Columns ) do
				function v.Header:Paint( w, h )
					if ( self:IsHovered() ) then
						draw.NoTexture()
						surface.SetDrawColor(Color(158,191,217))
						surface.DrawRect(0,0,v.Header:GetWide(),v.Header:GetTall()) 
					else
						draw.NoTexture()
						surface.SetDrawColor(Color(255,255,255))
						surface.DrawRect(0,0,w,h) 
					end
				end
				v.Header:SetFont( "LogFont" )
				v.Header:SetTextColor( Color(48,71,87) )
			end

			function self.pnlCanvas:Paint(w,h)
				draw.NoTexture()
				surface.SetDrawColor(Color(255,255,255))
				surface.DrawRect(0,0,w,h) 
			end
			self.oldLayout(self,w,h)
		end

	end

end

if SERVER then



end