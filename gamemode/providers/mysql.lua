require('mysqloo')

local SQLConnected = false
local wasretry = false
local mysql_hostname = 'fi.apex.gs' 
local mysql_username = 'billhackweb' 
local mysql_password = '#^_g4B5djAvCeggAkuG41ejIC46t27ZUc5K8Xy63zkV4wB5hlBwQGPHgQogzBqRwB5hlBwQGPHg' 
local mysql_database = 'billhackweb_ethereallife' 
local mysql_port = 3306 

function CheckSQL()
    if(!SQLConnected) then 
        return 
    end
end

local db = mysqloo.connect(mysql_hostname, mysql_username, mysql_password, mysql_database, mysql_port)

function db:onConnected()
    Ethereal:DebugPrint(Ethereal.DebugLevels['Critical'],"Database connected!")
    SQLConnected = true
	Ethereal.DB = db
end

function db:onConnectionFailed(err)
    Ethereal:DebugPrint(Ethereal.DebugLevels['Critical'],"Database failed to connect! error: "..err)
    
end
db:connect()


function PROVIDER:ParseData(ply,query,callback,...)
    CheckSQL()
    local values = {...}

    query = string.format(query,unpack(values))

    local querystring = db:query(query)
     
    function querystring:onSuccess(data)
   
      
        if #data > 0 then
            local row = data[1]
           
            callback(row)
            return row
        else
            callback(nil)
        end
    end
     
    function querystring:onError(err, sql)
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            db:connect()
            db:wait()
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            Ethereal:DebugPrint(Ethereal.DebugLevels['Critical'],'Re-connection failed!')
            return
            end
        end
        Ethereal:DebugPrint(Ethereal.DebugLevels['Critical'],'Ethereal Life MySQL: Query Failed: ' .. err .. ' (' .. sql .. ')')
    end
     
    querystring:start()

   
end























































































--[[
function PROVIDER:GetData(ply, callback)
    if not shouldmysql then return  end
    
    local qs = [[
    SELECT *
    FROM `EtherealLife`
    WHERE UID = '%s'
    ]-]
	print(qs,ply:UniqueID())
    qs = string.format(qs, ply:UniqueID())
    print(qs)
	local q = db:query(qs)
     
    function q:onSuccess(data)
        if #data > 0 then
            local row = data[1]
         
           
				print(row)
            callback(row)
        else
            callback({})
        end
    end
     
    function q:onError(err, sql)
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            db:connect()
            db:wait()
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            ErrorNoHalt("Re-connection to database server failed.")
            callback({})
            return
            end
        end
        MsgN('Ethereal Life MySQL: Query Failed: ' .. err .. ' (' .. sql .. ')')
        q:start()
    end
     
    q:start()
end


function PROVIDER:CreatePlayerDB(ply, callback)
    if not shouldmysql then return  end
    
    local qs = [[
    INSERT INTO `EtherealLife` (UID, Username,SID,NickName,Wallet,Bank,HouseID,HouseInventory,HouseFurniture,JobWhitelist,Inventory)
    VALUES ('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s')
    ] ]
	print(qs,ply:UniqueID())
    qs = string.format(qs, ply:UniqueID(),ply:Nick(),ply:SteamID(),ply:Nick(),100,5000,false,'[]','[]','[]','[]')
    print(qs)
	local q = db:query(qs)
     
    function q:onSuccess(data)
        if #data > 0 then
            local row = data[1]
         
           
			
            callback(row)
        else
            callback({})
        end
    end
     
    function q:onError(err, sql)
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            db:connect()
            db:wait()
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            ErrorNoHalt("Re-connection to database server failed.")
            callback({})
            return
            end
        end
        MsgN('Ethereal Life MySQL: Query Failed: ' .. err .. ' (' .. sql .. ')')
        q:start()
    end
     
    q:start()
end


function PROVIDER:AddToBank(ply, amt)
    if not shouldmysql then end
	local qs = [[
    INSERT INTO `EtherealLife` (UID, Savings)
    VALUES ('%s','%s')
    ON DUPLICATE KEY UPDATE 
        Savings = VALUES(Savings)
    ] ]
    qs = string.format(qs, ply:UniqueID(), amt )
	
    local q = db:query(qs)
     
    function q:onError(err, sql)
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            db:connect()
            db:wait()
        if db:status() ~= mysqloo.DATABASE_CONNECTED then
            ErrorNoHalt("Re-connection to database server failed.")
            return
            end
        end
        MsgN('VRP MySQL: Query Failed: ' .. err .. ' (' .. sql .. ')')
        q:start()
    end
     
    q:start()
end


--]]

--[[


--]]