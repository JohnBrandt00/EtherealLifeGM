Ethereal.Maque = {}
Ethereal.Maque.__index = Ethereal.Maque


if not file.IsDir( "Ethereal_Maque", "DATA" ) then
	file.CreateDir( "Ethereal_Maque" )

end

function Ethereal.CacheClubMusic( ID,url )

	return setmetatable( { Url = url, ID = ID, Ready = false, Downloading = false,Failcount = 0}, Ethereal.Maque )
end



function Ethereal.Maque:Download( )
	print("[maque] downloading")
	if self:IsDownloading( ) or self:IsReady( ) then
		return
	end
	self.UID = util.CRC( self.ID ) .. ".txt"
	
	
	
	if file.Exists("Ethereal_Maque/"..self.UID,"DATA") then
	self.Downloading = false
	self.Ready = true
	print("[maque] song already exists")
	return false
end
	
	
	http.Fetch( self.Url,
		function( body, len, headers, code )
			print("[maque] fetching url")
			http.Fetch( util.JSONToTable(body)["link"],
				function( body, len, headers, code )
					print("[maque] fetching audio")
					file.Write( "Ethereal_Maque/" .. self.UID, body )
					self.Downloading = false
					self.Ready = true
					hook.Call("Ethereal_Maque_Downloaded",self,self.UID,self.Path)
		end) end,

		function ( err )
			self.Failcount = self.Failcount + 1
			if( self.Failcount < 5) then 
				notification.AddLegacy( "Error fetching texture '" .. self.UID .. "': " .. err .. "\n",NOTIFY_ERROR,2 )
				self:Download()
			end
		end
	)
end


function Ethereal.Maque:IsReady( )
	
	return self.Ready
end

function Ethereal.Maque:IsDownloading( )
	return self.Downloading
end


function Ethereal.Maque:GetPath( )
	if self:IsDownloading( ) or not self:IsReady( ) then
		return ""
	end
	
	local x = ( "data/Ethereal_Maque/" .. self.UID )
	return x
end
