include("shared.lua")
AddCSLuaFile("shared.lua")

Ethereal.PlayerData = {}
Ethereal.PeelPad = {}
Ethereal.Apps = {}
for k,v in SortedPairs(file.Find(GM.FolderName.."/gamemode/base/cl_*","LUA"),true) do
include(GM.FolderName.."/gamemode/base/"..v)
 
end 
for k,v in SortedPairs(file.Find(GM.FolderName.."/gamemode/base/sh_*","LUA"),true) do
include(GM.FolderName.."/gamemode/base/"..v)
end 

for k,v in SortedPairs(file.Find(GM.FolderName.."/gamemode/modules/cl_*","LUA"),true) do
include(GM.FolderName.."/gamemode/modules/"..v)

end 
for k,v in SortedPairs(file.Find(GM.FolderName.."/gamemode/modules/sh_*","LUA"),true) do
include(GM.FolderName.."/gamemode/modules/"..v)
end 


for _, Filename in SortedPairs(file.Find(GM.FolderName.."/gamemode/apps/*.lua", "LUA"), true) do
		include(GM.FolderName.."/gamemode/apps/"..Filename)
	end

 
	 
	
	