AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
Ethereal.PlayerInfo = {}
DEFINE_BASECLASS( "gamemode_base" )

local GamemodeLoaded = --[[
  _____ _   _                         _           
 | ____| |_| |__   ___ _ __ ___  __ _| |          
 |  _| | __| '_ \ / _ \ '__/ _ \/ _` | |          
 | |___| |_| | | |  __/ | |  __/ (_| | |          
 |_____|\__|_| |_|\___|_|  \___|\__,_|_|          
      | |   (_)/ _| ___                           
      | |   | | |_ / _ \                          
      | |___| |  _|  __/                          
      |_____|_|_|  \___|      ____  _             
           |  _ \ ___ | | ___|  _ \| | __ _ _   _ 
           | |_) / _ \| |/ _ \ |_) | |/ _` | | | |
           |  _ < (_) | |  __/  __/| | (_| | |_| |
           |_| \_\___/|_|\___|_|   |_|\__,_|\__, |
                                            |___/ 
--]] 

 
MsgC(Color(255,0,0), GamemodeLoaded)
--[[
-- Load the base files
 for k, v in SortedPairs(file.Find(GM.FolderName.."/gamemode/base/sv_*","LUA"),true) do
  include(GM.FolderName.."/gamemode/base/"..v)
  MsgC(Color(0,0,255), "Server File: "..v.."\n")
 end

 for k, v in SortedPairs(file.Find(GM.FolderName.."/gamemode/base/cl_*","LUA"),true) do
  AddCSLuaFile(GM.FolderName.."/gamemode/base/"..v)
  MsgC(Color(0,0,255), "Client File: "..v.."\n")
 end

 for k, v in SortedPairs(file.Find(GM.FolderName.."/gamemode/base/sh_*","LUA"),true) do
  AddCSLuaFile(GM.FolderName.."/gamemode/base/"..v)
  include(GM.FolderName.."/gamemode/base/"..v)
  MsgC(Color(0,0,255), "Shared File: "..v.."\n")
 end


 --modules
  for k, v in SortedPairs(file.Find(GM.FolderName.."/gamemode/modules/sv_*","LUA"),true) do
  include(GM.FolderName.."/gamemode/modules/"..v)
  MsgC(Color(0,0,255), "Module Server File: "..v.."\n")
 end

 for k, v in SortedPairs(file.Find(GM.FolderName.."/gamemode/modules/cl_*","LUA"),true) do
  AddCSLuaFile(GM.FolderName.."/gamemode/modules/"..v)
  MsgC(Color(0,0,255), "Module Client File: "..v.."\n")
 end
for _, Filename in SortedPairs(file.Find(GM.FolderName.."/gamemode/apps/*.lua", "LUA"), true) do
		AddCSLuaFile(GM.FolderName.."/gamemode/apps/"..Filename)
    include(GM.FolderName.."/gamemode/apps/"..Filename)
		MsgC(Color(0,0,255), "Module APP Client File: "..Filename.."\n")
	end


 for k, v in SortedPairs(file.Find(GM.FolderName.."/gamemode/modules/sh_*","LUA"),true) do
  AddCSLuaFile(GM.FolderName.."/gamemode/modules/"..v)
  include(GM.FolderName.."/gamemode/modules/"..v)
  MsgC(Color(0,0,255), "Module Shared File: "..v.."\n")
 end
--]]
 
function GM:RecursiveInclude(name)
  local files,directories = file.Find(name.."/*","LUA")
  for k,v in pairs(files) do
    if(string.find(v,"cl_",0,true) ) then
      AddCSLuaFile(name.."/"..v)
      MsgC(Color(255,65,65),"AddCSLuaFile "..name.."/"..v.."\n")
    end
      if(string.find(v,"app_",0,true) ) then
      AddCSLuaFile(name.."/"..v)
      include(name.."/"..v)
      MsgC(Color(255,65,65),"AddCSLuaFile APP "..name.."/"..v.."\n")
    end
    if(string.find(v,"sv_",0,true) ) then
      include(name.."/"..v)
        MsgC(Color(150,0,255),"Include "..name.."/"..v.."\n")
    end
     if(string.find(v,"sh_",0,true) ) then
      AddCSLuaFile(name.."/"..v)
      include(name.."/"..v)
        MsgC(Color(0,255,255),"Shared "..name.."/"..v.."\n")
    end
  end
  
  for k,v in pairs(directories) do
  MsgC(Color(0,255,0),v.."\n")
  self:RecursiveInclude(name.."/"..v)
  end
end

GM:RecursiveInclude(GM.FolderName.."/gamemode") 