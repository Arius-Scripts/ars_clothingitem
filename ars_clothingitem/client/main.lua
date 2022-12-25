local ox_inventory = exports.ox_inventory
local on = {}

exports('clothes', function(data, slot) 
	local ped = cache.ped
	
	local playerModel = GetEntityModel(ped)
	if playerModel == "mp_m_freemode_01" or playerModel == 1885233650 then
		sex = Config.Clothes[data.name].male
	else
		sex = Config.Clothes[data.name].female
	end

	ox_inventory:useItem(data, function(data)
		if data then
			drawable = GetPedDrawableVariation(ped, data.metadata.type)
			if drawable ~= sex then on[data.name] = true end
			if not on[data.name] then
				on[data.name] = true
				lib.requestAnimDict(Config.Clothes[data.name].dict, 10)
				TaskPlayAnim(ped, Config.Clothes[data.name].dict, Config.Clothes[data.name].anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
				Citizen.Wait(1500)
				print(data.metadata.type, data.metadata.drawable, data.metadata.texture)
				SetPedComponentVariation(ped, data.metadata.type, data.metadata.drawable, data.metadata.texture, 1)
				ClearPedTasks(ped)
			else
				on[data.name] = false
				lib.requestAnimDict(Config.Clothes[data.name].dict, 10)
				TaskPlayAnim(ped, Config.Clothes[data.name].dict, Config.Clothes[data.name].anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
				Citizen.Wait(1500)
				SetPedComponentVariation(ped, data.metadata.type, sex, 0, 0)
				ClearPedTasks(ped)
			end
		end
	end)
end)


exports('accessories', function(data, slot) 
	local ped = cache.ped
	ox_inventory:useItem(data, function(data)
		if data then
			propon = GetPedPropIndex(ped, data.metadata.type)
			if propon ~= -1 then on[data.name] = true end
			if not on[data.name] then
				on[data.name] = true
				lib.requestAnimDict(Config.Clothes[data.name].dict, 10)
				TaskPlayAnim(ped, Config.Clothes[data.name].dict, Config.Clothes[data.name].anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
				Citizen.Wait(1500)
				print(data.metadata.type, data.metadata.drawable, data.metadata.texture)
				SetPedPropIndex(ped, data.metadata.type, data.metadata.drawable, data.metadata.texture, 1)
				ClearPedTasks(ped)
			else
				on[data.name] = false
				lib.requestAnimDict(Config.Clothes[data.name].dict, 10)
				TaskPlayAnim(ped, Config.Clothes[data.name].dict, Config.Clothes[data.name].anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
				Citizen.Wait(1500)
				ClearPedProp(ped, data.metadata.type)
				ClearPedTasks(ped)
			end
		end
	end)
end)

