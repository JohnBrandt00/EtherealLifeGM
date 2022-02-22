Ethereal.DebugLevels = {
	Debug = true,
	Low = true, 
	Medium =true, 
	High = true,
	Critical = true,
	Broadcast = true,
	Developer = true

}


function Ethereal:DebugPrint(level,text)

	if(level) then
		MsgC(Color(255,0,0),"[ETHEREAL DEBUG] ",Color(255,255,255),text,"\n" )
	end

end


