local house = {}

Ethereal.Housing = Ethereal.Housing or {}
Ethereal.Housing.Houses = Ethereal.Housing.Houses or {}

function Ethereal.Housing.CreateHouse(ID)
	local House = {}
	House.ID = ID
	House.__index = House

	Ethereal.Housing.Houses[House.ID] = House

	return setmetatable(House, house)
end
