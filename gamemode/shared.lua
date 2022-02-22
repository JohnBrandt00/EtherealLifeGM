GM.Name = "Ethereal Life"
GM.Author = "Setu_Sertao, MYND"
GM.Email = "leveluptime@apexgamecommunity.com"
GM.Website = "apex.gs"
GM.TeamBased = true
include("player_class/player_citizen.lua")
AddCSLuaFile("player_class/player_citizen.lua")
DeriveGamemode( "sandbox" )
 
Ethereal = Ethereal or {}
Ethereal.__index = Ethereal
Ethereal.Jobs = {}

Ethereal.PlayerMeta = FindMetaTable( 'Player' )

function GM:CreateTeams()

end



  