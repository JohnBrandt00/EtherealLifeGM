surface.CreateFont( "ELNotifyFont", {
	font	= "Century Gothic",
	size	= 20,
	weight	= 1000
} )

NOTIFY_GENERIC	= 0
NOTIFY_MONEY	= 1
NOTIFY_ERROR	= 2
NOTIFY_HINT		= 3
NOTIFY_WARN		= 4

local NoticeMaterial = {}

NoticeMaterial[ NOTIFY_GENERIC ]	= Material( "notify_icons/notice_generic.png","noclamp smooth" )
NoticeMaterial[ NOTIFY_MONEY ]		= Material( "notify_icons/notice_pay.png","noclamp smooth" )
NoticeMaterial[ NOTIFY_ERROR ]		= Material( "notify_icons/notice_error.png","noclamp smooth" )
NoticeMaterial[ NOTIFY_HINT ]		= Material( "notify_icons/notice_hint.png","noclamp smooth" )
NoticeMaterial[ NOTIFY_WARN ]		= Material( "notify_icons/notice_warn.png","noclamp smooth" )

local ELNotices = {}

function AddELProgress( uid, text )

	if ( IsValid( ELNotices[ uid ] ) ) then

		ELNotices[ uid ].StartTime = SysTime()
		ELNotices[ uid ].Length = 1000000
		ELNotices[ uid ]:SetText( text )
		ELNotices[ uid ]:SetProgress()
		return

	end

	local parent = nil
	if ( GetOverlayPanel ) then parent = GetOverlayPanel() end

	local Panel = vgui.Create( "ELNotify", parent )
	Panel.StartTime = SysTime()
	Panel.Length = 1000000
	Panel.VelX = 0
	Panel.VelY = 0
	Panel.fx = ScrW()
	Panel.fy = ScrH()
	Panel:SetAlpha( 255 )
	Panel:SetText( text )
	Panel:SetPos( Panel.fx, Panel.fy )
	Panel:SetELProgress()

	ELNotices[ uid ] = Panel

end

function Kill( uid )

	if ( !IsValid( ELNotices[ uid ] ) ) then return end

	ELNotices[ uid ].StartTime = SysTime()
	ELNotices[ uid ].Length = 0.8

end

function AddELNotice( text, type, length )

	local parent = nil
	if ( GetOverlayPanel ) then parent = GetOverlayPanel() end

	local Panel = vgui.Create( "ELNotify", parent )
	Panel.StartTime = SysTime()
	Panel.Length = length
	Panel.VelX = 0
	Panel.VelY = 0
	Panel.fx = ScrW()/2 - Panel:GetWide()
	Panel.fy = 0
	Panel:SetAlpha( 255 )
	Panel:SetText( text )
	Panel:SetELNoticeType( type )
	Panel:SetPos( Panel.fx, Panel.fy )

	table.insert( ELNotices, Panel )

end

local function UpdateNotice( pnl, total_h )

	local x = pnl.fx
	local y = pnl.fy

	local w = ScrW()/2 + pnl:GetWide()/2
	local h = pnl:GetTall() - pnl:GetTall()*2 - 2

	local ideal_y = 0  - total_h
	local ideal_x = w - pnl:GetWide()

	local timeleft = pnl.StartTime - ( SysTime() - pnl.Length )

	-- Cartoon style about to go thing
	if ( timeleft < 0.7 ) then
		ideal_y = ideal_y - pnl:GetTall()*2
	end

	-- Gone!
	if ( timeleft < 0.2 ) then
		ideal_y = ideal_y + h * 2
	end

	local spd = RealFrameTime() * 15

	y = y + pnl.VelY * spd
	x = x + pnl.VelX * spd

	local dist = ideal_y - y
	pnl.VelY = pnl.VelY + dist * spd * 1
	if ( math.abs( dist ) < 2 && math.abs( pnl.VelY ) < 0.1 ) then pnl.VelY = 0 end
	dist = ideal_x - x
	pnl.VelX = pnl.VelX + dist * spd * 1
	if ( math.abs( dist ) < 2 && math.abs( pnl.VelX ) < 0.1 ) then pnl.VelX = 0 end

	-- Friction.. kind of FPS independant.
	pnl.VelX = pnl.VelX * ( 0.95 - RealFrameTime() * 8 )
	pnl.VelY = pnl.VelY * ( 0.95 - RealFrameTime() * 8 )

	pnl.fx = x
	pnl.fy = y
	pnl:SetPos( pnl.fx, pnl.fy )

	return total_h + h

end

local function Update()

	if ( !ELNotices ) then return end

	local h = 0
	for key, pnl in pairs( ELNotices ) do

		h = UpdateNotice( pnl, h )

	end

	for k, Panel in pairs( ELNotices ) do

		if ( !IsValid( Panel ) || Panel:KillSelf() ) then ELNotices[ k ] = nil end

	end

end

hook.Add( "Think", "ELNotificationThink", Update )

local PANEL = {}

function PANEL:Init()

	self:DockPadding( 3, 3, 3, 3 )

	self.Label = vgui.Create( "DLabel", self )
	self.Label:Dock( FILL )
	self.Label:SetFont( "ELNotifyFont" )
	self.Label:SetTextColor( Color( 120, 125, 128, 255 ) )
	self.Label:SetExpensiveShadow( 1, Color( 0, 0, 0, 200 ) )
	self.Label:SetContentAlignment( 5 )

	self:SetBackgroundColor( Color( 0, 0, 0, 0 ) )

end

function PANEL:SetText( txt )

	self.Label:SetText( txt )
	self:SizeToContents()

end

function PANEL:SizeToContents()

	self.Label:SizeToContents()

	local width, tall = self.Label:GetSize()

	tall = math.max( tall, 68 )
	width = width + 20

	if ( IsValid( self.Image ) ) then
		width = width + 48 + 8

		local x = ( tall - 54 ) / 2
		self.Image:DockMargin( 0, x, 0, x )
	end

	if ( self.Progress ) then
		tall = tall + 10
		self.Label:DockMargin( 10, 10, 10, 10 )
	end

	self:SetSize( width, tall )

	self:InvalidateLayout()

end

function PANEL:SetELNoticeType( t )

	self.Image = vgui.Create( "DImageButton", self )
	self.Image:SetMaterial( NoticeMaterial[ t ] )
	self.Image:SetSize( 48, 48 )
	self.Image:Dock( LEFT )
	self.Image:DockMargin( 10, 10, 10, 10 )
	self.Image.DoClick = function()
		self.StartTime = 0
	end

	self:SizeToContents()

end

function PANEL:Paint( w, h )

	self.BaseClass.Paint( self, w, h )

	surface.SetDrawColor( 41,44,46,255 )
	surface.DrawRect( 0, 0, w, h )

	if ( !self.Progress ) then return end

	local w = self:GetWide()
	local x = math.fmod( SysTime() * 200, self:GetWide() + w ) - w

	if ( x + w > self:GetWide() - 11 ) then w = ( self:GetWide() - 11 ) - x end
	if ( x < 0 ) then w = w + x; x = 0 end

end

-- local PANEL = {}
-- function PANEL:Init()
-- 	self.NotifyPanel = vgui.Create( "DNotify" )
-- 	self.NotifyPanel:SetPos( (ScrW()/2)-150, 0 )
-- 	self.NotifyPanel:SetSize( 300, 68 )

-- 	self.bg = vgui.Create( "DPanel", self.NotifyPanel )
-- 	self.bg:Dock( FILL )
-- 	function self.bg:Paint(w,h)
-- 		draw.RoundedBox(0,68,0,w-68,h,Color(41,44,46))
-- 		draw.RoundedBox(0,0,0,68,68,Color(41,44,46))

-- 		surface.SetDrawColor(58,60,61,255)
-- 		surface.DrawOutlinedRect(0,0,68,h)
-- 		surface.DrawOutlinedRect(67,0,w-67,h)
-- 	end

-- 	self.Label = vgui.Create( "DLabel", self.bg )
-- 	self.Label:SetPos( 78, 0 )
-- 	self.Label:SetSize( 300-68,68 )
-- 	self.Label:SetTextColor( Color( 120, 125, 128 ) )
-- 	self.Label:SetFont( "GModNotify" )
-- 	self.Label:SetWrap( true )

-- 	self.NotifyPanel:AddItem( self.bg )
-- end

function PANEL:SetELProgress()

	self.Progress = true

	self:SizeToContents()

end

function PANEL:KillSelf()

	if ( self.StartTime + self.Length < SysTime() ) then

		self:Remove()
		return true

	end

	return false

end

vgui.Register( "ELNotify", PANEL, "DPanel" )
