-- someone clean this up, we dont need VOTING ON A 3 JOB GAMEMODE WITH A WHITELIST FOR ONE

local JobTab = {}
local JCount = 0
function GM:JobRegister(name,custjob)

JCount = JCount + 1
local job = custjob
job.Team = JobCount
job.Name = job.Name 								or "Undefined"
job.CustomCheck = job.CustomCheck				    or function(ply) return true end
job.CustomFail = job.CustomFail 					or "Cannot switch to this job!"
job.Weapons = job.Weapons 							or  {"weapon_phygun","weapon_toolgun"}
job.RequiresVote = job.RequiresVote					or false
job.Salary = job.Salary 							or 50
job.CanStartVote = job.CanStartVote 				or true
job.Model = job.Model 								or {"models/player/group01/male_02.mdl"}
job.Color = job.Color 								or Color(0,255,0)
job.Max = job.Max 									or 10
job.Desc = job.Desc 								or [[ undefined job ]]
job.NChangeFrom = job.NChangeFrom 					or 1

JobTab[name] = table.insert(Ethereal.Jobs, job )
  
	team.SetUp(#Ethereal.Jobs, name, job.Color)
	local Team = #Ethereal.Jobs
	
	print("TEAM REGISTERED: "..Team.." "..name.." "..team.GetName(Team) )  
	return Team

end

TEAM_CITIZEN = GM:JobRegister("Citizen",{
Max = 100,
Desc = [[Member of Apex City ]],
Name = "Citizen",
Salary = 66
} )
TEAM_COP = GM:JobRegister("Police",{
Max = 5,
Desc = [[Police of Apex City ]],
Name = "Police",
Weapons = {"arrestbaton"},
Salary = 88
} )

TEAM_EMT = GM:JobRegister("EMT",{
Max = 2,
Desc = [[Medics of Apex City ]],
Name = "EMT",
Weapons = {"defib"},
Salary = 50
} )




