Ethereal.ChatBox = {}

surface.CreateFont("ChatBoxInput",{
		font = "Borda 4",
		size = 26,
		weight = 700,
		antialias = true,
	}) 

surface.CreateFont("ChatBoxSay",{
		font = "Borda 4",
		size =18,
		weight = 700,
		antialias = true,
	}) 


function Ethereal.CreateChatBox()
	Ethereal.ChatBox.Frame = vgui.Create("DFrame")
	Ethereal.ChatBox.Frame:SetSize( 725, 270 )
	Ethereal.ChatBox.Frame:SetTitle("")
	Ethereal.ChatBox.Frame:MakePopup(true)
	Ethereal.ChatBox.Frame:ShowCloseButton( true )
	Ethereal.ChatBox.Frame:SetDraggable( false )
	Ethereal.ChatBox.Frame:SetPos( 22, (ScrH() - Ethereal.ChatBox.Frame:GetTall()) - 170)
	Ethereal.ChatBox.Frame.Paint = function( self, w, h )
		surface.SetDrawColor(Color(55,63,65,230))
		surface.DrawRect(0,0,w,h)

	end
	Ethereal.ChatBox.oldPaint = Ethereal.ChatBox.Frame.Paint

	Ethereal.ChatBox.Frame.TopBar = vgui.Create("DPanel",Ethereal.ChatBox.Frame)
	Ethereal.ChatBox.Frame.TopBar:SetSize(Ethereal.ChatBox.Frame:GetWide(),20)
	Ethereal.ChatBox.Frame.TopBar.Paint = function( self, w, h)
		surface.SetDrawColor(Color(25,43,55,230))
		surface.DrawRect(0,0,w,h)
	end


	Ethereal.ChatBox.Frame.btnClose:SetZPos(100)

	Ethereal.ChatBox.Frame.Entry = vgui.Create("DTextEntry", Ethereal.ChatBox.Frame) 
	Ethereal.ChatBox.Frame.Entry:SetSize( Ethereal.ChatBox.Frame:GetWide() - 60, 20 )
	Ethereal.ChatBox.Frame.Entry:SetTextColor( color_white )
	Ethereal.ChatBox.Frame.Entry:SetFont("ChatBoxInput")
	Ethereal.ChatBox.Frame.Entry:SetDrawBorder( false )
	Ethereal.ChatBox.Frame.Entry:SetDrawBackground( false )
	Ethereal.ChatBox.Frame.Entry:SetCursorColor( color_white )
	Ethereal.ChatBox.Frame.Entry:SetHighlightColor( Color(30,30,30) )
	Ethereal.ChatBox.Frame.Entry:SetPos( 55, Ethereal.ChatBox.Frame:GetTall() - Ethereal.ChatBox.Frame.Entry:GetTall() - 5 )
	Ethereal.ChatBox.Frame.Entry.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 29, 185, 84, 100 ) )
		derma.SkinHook( "Paint", "TextEntry", self, w, h )
	end

		Ethereal.ChatBox.Frame.Entry.OnTextChanged = function( self )
		if self and self.GetText then 
			--surface.PlaySound(Cheer.config.clicksound)
			gamemode.Call( "ChatTextChanged", self:GetText() or "" )
		end
	end

	Ethereal.ChatBox.Frame.Entry.OnKeyCodeTyped = function( self, code )
		local types = {"", "teamchat", "console"}

		if code == KEY_ESCAPE then

			--Cheer.HideChatBox()
			gui.HideGameUI()

		elseif code == KEY_TAB then
			
			--Cheer.TypeSelector = 1
			--Cheer.ChatType = types[Cheer.TypeSelector]

			timer.Simple(0.001, function() Cheer.Entry:RequestFocus() end)

		elseif code == KEY_ENTER then
		
			if string.Trim( self:GetText() ) != "" then
		
					LocalPlayer():ConCommand("say \"" .. self:GetText() .. "\"")
			end

			--Cheer.TypeSelector = 1
			--Cheer.HideChatBox()
		end
	end

	Ethereal.ChatBox.Frame.say = vgui.Create("DLabel", Ethereal.ChatBox.Frame)
	Ethereal.ChatBox.Frame.say:SetText("")
	surface.SetFont( "ChatBoxInput")
	local w, h = surface.GetTextSize( "Say: " )
	Ethereal.ChatBox.Frame.say:SetSize( w + 5, 20 )
	Ethereal.ChatBox.Frame.say:SetPos( 5, Ethereal.ChatBox.Frame:GetTall() - 25 )
	
	Ethereal.ChatBox.Frame.say.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w-5, h, Color( 29, 185, 84, 100 ) )
		draw.DrawText( "Say: ", "ChatBoxSay", 1, 0, color_white )
	end

	 	Ethereal.ChatBox.Frame.Scroll = vgui.Create( "DScrollPanel", Ethereal.ChatBox.Frame ) 
		Ethereal.ChatBox.Frame.Scroll:SetSize( Ethereal.ChatBox.Frame:GetWide()-2, Ethereal.ChatBox.Frame:GetTall()-50 )
		Ethereal.ChatBox.Frame.Scroll:SetPos( 1, 21 )

		Ethereal.ChatBox.Frame.History	= vgui.Create( "DIconLayout", Ethereal.ChatBox.Frame.Scroll )
		Ethereal.ChatBox.Frame.History:SetSize( Ethereal.ChatBox.Frame:GetWide()-20, Ethereal.ChatBox.Frame:GetTall()-70 )
		Ethereal.ChatBox.Frame.History:SetPos( 1, 0 )
		Ethereal.ChatBox.Frame.History:SetSpaceY( 1 )
		Ethereal.ChatBox.Frame.History:SetSpaceX( 1 ) 
		Ethereal.ChatBox.Frame.History:Layout()
		Ethereal.ChatBox.Frame.History.Paint = function(s,w,h)
	
		end


		for i = 1, 35 do 
			local ListItem = Ethereal.ChatBox.Frame.History:Add( "DPanel" ) 
		ListItem:SetSize( Ethereal.ChatBox.Frame.History:GetWide(), 50 ) 
	
		end



end


--[[


function Cheer.BuildChatBox()
	Cheer.Frame = vgui.Create("DFrame")
	Cheer.Frame:SetSize( 725, 270 )
	Cheer.Frame:SetTitle("")
	Cheer.Frame:ShowCloseButton( false )
	Cheer.Frame:SetDraggable( false )
	Cheer.Frame:SetPos( 22, (ScrH() - Cheer.Frame:GetTall()) - 170)
	Cheer.Frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 40, 40, 255 ) )

	end
	Cheer.oldPaint = Cheer.Frame.Paint
	
	local serverName = vgui.Create("DLabel", Cheer.Frame)
	serverName:SetText(  "Apex JB"  )
	serverName:SetFont( "Cheer18")
	serverName:SizeToContents()
	serverName:SetPos( 2, 4 )
	

	
	Cheer.Entry = vgui.Create("DTextEntry", Cheer.Frame) 
	Cheer.Entry:SetSize( Cheer.Frame:GetWide() - 50, 20 )
	Cheer.Entry:SetTextColor( color_white )
	Cheer.Entry:SetFont("Cheer18")
	Cheer.Entry:SetDrawBorder( false )
	Cheer.Entry:SetDrawBackground( false )
	Cheer.Entry:SetCursorColor( color_white )
	Cheer.Entry:SetHighlightColor( Color(30,30,30) )
	Cheer.Entry:SetPos( 45, Cheer.Frame:GetTall() - Cheer.Entry:GetTall() - 5 )
	Cheer.Entry.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 29, 185, 84, 100 ) )
		derma.SkinHook( "Paint", "TextEntry", self, w, h )
	end

	Cheer.Entry.OnTextChanged = function( self )
		if self and self.GetText then 
			surface.PlaySound(Cheer.config.clicksound)
			gamemode.Call( "ChatTextChanged", self:GetText() or "" )
		end
	end

	Cheer.Entry.OnKeyCodeTyped = function( self, code )
		local types = {"", "teamchat", "console"}

		if code == KEY_ESCAPE then

			Cheer.HideChatBox()
			gui.HideGameUI()

		elseif code == KEY_TAB then
			
			Cheer.TypeSelector = 1
			Cheer.ChatType = types[Cheer.TypeSelector]

			timer.Simple(0.001, function() Cheer.Entry:RequestFocus() end)

		elseif code == KEY_ENTER then
		
			if string.Trim( self:GetText() ) != "" then
		
					LocalPlayer():ConCommand("say \"" .. self:GetText() .. "\"")
			end

			Cheer.TypeSelector = 1
			Cheer.HideChatBox()
		end
	end
	

	Cheer.ChatLog = vgui.Create("RichText", Cheer.Frame) 
	Cheer.ChatLog:SetSize( Cheer.Frame:GetWide() - 10, Cheer.Frame:GetTall() - 60 )
	Cheer.ChatLog:SetPos( 5, 30 )
	Cheer.ChatLog.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 70, 70, 70, 100 ) )
	end
	Cheer.ChatLog.Think = function( self )
		if Cheer.lastMessage then
			if CurTime() - Cheer.lastMessage > Cheer.config.fadeTime then
				self:SetVisible( false )
			else
				self:SetVisible( true )
			end
		end
	end
	Cheer.ChatLog.PerformLayout = function( self )
		self:SetFontInternal("Cheer18")
		self:SetFGColor( color_white )
	end
	Cheer.oldPaint2 = Cheer.ChatLog.Paint
	
	local text = "Say: "

	local say = vgui.Create("DLabel", Cheer.Frame)
	say:SetText("")
	surface.SetFont( "Cheer18")
	local w, h = surface.GetTextSize( text )
	say:SetSize( w + 5, 20 )
	say:SetPos( 5, Cheer.Frame:GetTall() - Cheer.Frame:GetTall() - 5 )
	
	say.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w-5, h, Color( 29, 185, 84, 100 ) )
		draw.DrawText( text, "Cheer18", 1, 0, color_white )
	end

	say.Think = function( self )
	
			local types = {"", "teamchat", "console"}
		local s = {}

		if Cheer.ChatType == types[2] then 
			text = "Say (TEAM) :"	
		elseif Cheer.ChatType == types[3] then
			text = "Console :"
		else
			text = "Say :"
			s.pw = 45
			s.sw = Cheer.Frame:GetWide() - 50
		end

		if s then
			if not s.pw then s.pw = self:GetWide() + 10 end
			if not s.sw then s.sw = Cheer.Frame:GetWide() - self:GetWide() - 15 end
		end

		local w, h = surface.GetTextSize( text )
		self:SetSize( w + 5, 20 )
		self:SetPos( 5, Cheer.Frame:GetTall() - Cheer.Entry:GetTall() - 5 )

		Cheer.Entry:SetSize( s.sw, 20 )
		Cheer.Entry:SetPos( s.pw, Cheer.Frame:GetTall() - Cheer.Entry:GetTall() - 5 )
	end	
	
	Cheer.HideChatBox()
end

function Cheer.HideChatBox()
	Cheer.Frame.Paint = function() end
	Cheer.ChatLog.Paint = function() end
	
	Cheer.ChatLog:SetVerticalScrollbarEnabled( false )
	Cheer.ChatLog:GotoTextEnd()
	
	Cheer.lastMessage = Cheer.lastMessage or CurTime() - Cheer.config.fadeTime
	
	local children = Cheer.Frame:GetChildren()
	for _, pnl in pairs( children ) do
		if pnl == Cheer.Frame.btnMaxim or pnl == Cheer.Frame.btnClose or pnl == Cheer.Frame.btnMinim then continue end
		
		if pnl != Cheer.ChatLog then
			pnl:SetVisible( false )
		end
	end
	
	Cheer.Frame:SetMouseInputEnabled( false )
	Cheer.Frame:SetKeyboardInputEnabled( false )
	gui.EnableScreenClicker( false )
	
	gamemode.Call("FinishChat")
	
	Cheer.Entry:SetText( "" )
	gamemode.Call( "ChatTextChanged", "" )
end

function Cheer.ShowChatBox()
	Cheer.Frame.Paint = Cheer.oldPaint
	Cheer.ChatLog.Paint = Cheer.oldPaint2
	
	Cheer.ChatLog:SetVerticalScrollbarEnabled( true )
	Cheer.lastMessage = nil
	
	local children = Cheer.Frame:GetChildren()
	for _, pnl in pairs( children ) do
		if pnl == Cheer.Frame.btnMaxim or pnl == Cheer.Frame.btnClose or pnl == Cheer.Frame.btnMinim then continue end
		
		pnl:SetVisible( true )
	end
	
	 Cheer.Frame:MakePopup()
	 Cheer.Entry:RequestFocus()
	
	gamemode.Call("StartChat")
end




local oldAddText = chat.AddText

function chat.AddText(...)
	if not Cheer.ChatLog then
		Cheer.BuildChatBox()
	end
	
	local msg = {}
	

	for _, obj in pairs( {...} ) do
		if type(obj) == "table" then
			Cheer.ChatLog:InsertColorChange( obj.r, obj.g, obj.b, obj.a )
			table.insert( msg, Color(obj.r, obj.g, obj.b, obj.a) )
		elseif type(obj) == "string"  then
			Cheer.ChatLog:AppendText( obj )
			table.insert( msg, obj )
		elseif obj:IsPlayer() then
			local ply = obj
			
			if Cheer.config.timeStamps then
				Cheer.ChatLog:InsertColorChange( 130, 130, 130, 255 )
				Cheer.ChatLog:AppendText( "["..os.date("%X").."] ")
			end
			
			if Cheer.config.seeChatTags and ply:GetNWBool("eChat_tagEnabled", false) then
				local col = ply:GetNWString("eChat_tagCol", "255 255 255")
				local tbl = string.Explode(" ", col )
				Cheer.ChatLog:InsertColorChange( tbl[1], tbl[2], tbl[3], 255 )
				Cheer.ChatLog:AppendText( "["..ply:GetNWString("eChat_tag", "N/A").."] ")
			end
			
			local col = GAMEMODE:GetTeamColor( obj )
			Cheer.ChatLog:InsertColorChange( col.r, col.g, col.b, 255 )
			Cheer.ChatLog:AppendText( obj:Nick() )
			table.insert( msg, obj:Nick() )
		end
	end
	Cheer.ChatLog:AppendText("\n")
	
	Cheer.ChatLog:SetVisible( true )
	Cheer.lastMessage = CurTime()
	oldAddText(unpack(msg))
end

hook.Add( "ChatText", "CheerJL", function( index, name, text, type )
	if not Cheer.ChatLog then
		Cheer.BuildChatBox()
	end
	
	if type == "joinleave" or type == "none" then
		Cheer.ChatLog:InsertColorChange(  29, 185, 84,255 )
		Cheer.ChatLog:AppendText( text.."\n" )
	end
end)

hook.Add("PlayerBindPress", "cheer_binds", function(ply, bind, pressed)
	if string.sub( bind, 1, 11 ) == "messagemode" then
		if bind == "messagemode2" then 
			Cheer.ChatType = "teamchat"
		else
			Cheer.ChatType = ""
		end
		
		if IsValid( Cheer.Frame ) then
			Cheer.ShowChatBox()
		else
			Cheer.BuildChatBox()
			Cheer.ShowChatBox()
		end
		return true
	end
end)

hook.Add("HUDShouldDraw", "cheer_hidefeault", function( name )
	if name == "CHudChat" then
		return false
	end
end)

 
local oldGetChatBoxPos = chat.GetChatBoxPos
local oldChatPlaySound = chat.PlaySound
function chat.GetChatBoxPos()
	return Cheer.Frame:GetPos()
end
function chat.PlaySound()
	surface.PlaySound(Cheer.config.chatsound)
end

function chat.GetChatBoxSize()
	return Cheer.Frame:GetSize()
end

chat.Open = Cheer.ShowChatBox
function chat.Close(...) 
	if IsValid( Cheer.Frame ) then 
		Cheer.HideChatBox(...)
	else
		Cheer.BuildChatBox()
		Cheer.ShowChatBox()
	end
end
--]]