local ScrW,ScrH = ScrW(),ScrH()

-- get icons from content
local Health_Icon = Material("ethereal/Health.png","noclamp smooth")
local Hunger_Icon = Material("ethereal/hunger.png","noclamp smooth")
local Thirst_Icon = Material("ethereal/thirst.png","noclamp smooth")
local Fatigue_Icon = Material("ethereal/stamina.png","noclamp smooth")


local health = 100

local armor = 0

local hunger = 100

local thirst = 100

local fatigue = 100

function GM:HUDPaint()

	-- Health bullshit
	draw.NoTexture()
	surface.SetDrawColor(Color(255, 94, 94))
	draw.Circle( 42+48/2, ScrH-150+175/2, 43, 360 )
	draw.SimpleText(utf8.char(0xf21e),"FA48",42,ScrH-83,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

	draw.NoTexture()
	surface.SetDrawColor(color_white)
	draw.Arc(42+48/2,ScrH-150+175/2,44,4,360,360-(health*3.61),3,color_white )
	health = Lerp( 10*FrameTime(), health, LocalPlayer():Health() )

	surface.SetDrawColor(Color(0,138,255))
	draw.Arc(42+48/2,ScrH-150+175/2,40,4,360,360-(armor*3.61),3,Color(0,138,255) )
	armor = Lerp( 10*FrameTime(), armor, LocalPlayer():Armor() )

	-- Hunger Bullshit
	draw.NoTexture()
	surface.SetDrawColor(Color(255, 125, 0))
	draw.Circle( 132+48/2, ScrH-150+175/2, 43, 360 )
	draw.SimpleText(utf8.char(0xf0f5),"FA48",135,ScrH-83,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

	draw.NoTexture()
	surface.SetDrawColor(color_white)
	draw.Arc(132+48/2,ScrH-150+175/2,44,4,360,360-(hunger*3.61),3,color_white )
	hunger = Lerp( 10*FrameTime(), hunger, 100 )

	-- Thirst Bullshit
	draw.NoTexture()
	surface.SetDrawColor(Color(0, 90, 155))
	draw.Circle( 222+48/2, ScrH-150+175/2, 43, 360 )
	draw.SimpleText(utf8.char(0xf043),"FA48",232,ScrH-83,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

	draw.NoTexture()
	surface.SetDrawColor(color_white)
	draw.Arc(222+48/2,ScrH-150+175/2,44,4,360,360-(thirst*3.61),3,color_white )
	thirst = Lerp( 10*FrameTime(), thirst, 100 )

	-- Stamina Bullshit
	draw.NoTexture()
	surface.SetDrawColor(Color(0, 150, 155))
	draw.Circle( 312+48/2, ScrH-150+175/2, 43, 360 )
	draw.SimpleText(utf8.char(0xf0e7),"FA48",322,ScrH-83,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

	draw.NoTexture()
	surface.SetDrawColor(color_white)
	fatigue = Lerp( 10*FrameTime(), fatigue, LocalPlayer():GetNWInt( "Stamina" ))
	draw.Arc(312+48/2,ScrH-150+175/2,44,4,360,360-(fatigue*3.61),3,color_white )
	end
--draw.Arc(cx,cy,radius,thickness,startang,endang,roughness,color)

local hide = {
	CHudHealth = true,
	CHudBattery = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then
		return false
	end
	return true
end )
