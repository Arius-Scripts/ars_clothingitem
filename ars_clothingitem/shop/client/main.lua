local ox_inventory = exports.ox_inventory
local shops = {}
CreateThread(function()
    for k,v in pairs(Shop) do
		print("^3Shop ^2"..k.."^3 loaded successfully!")
        if v.blip then
            blip = AddBlipForCoord(v.coords)
            SetBlipSprite(blip, v.type)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, v.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.label)
            EndTextCommandSetBlipName(blip)
        end

        for i = 1, #k, 1 do
            shops[i] = lib.points.new({
                coords = v.coords,
                distance = 3,
                eleId = k,
                onEnter = function(self)
                    lib.showTextUI('[E] - Interact', {position = "top-center",icon = 'hand',style = {borderRadius = 0,backgroundColor = '#3a4d57',color = 'white'}})
                end,
                onExit = function()
                    lib.hideTextUI()
                end,
                nearby = function(self)
                    DrawMarker(21, self.coords.x, self.coords.y, self.coords.z - 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.6,0.6,0.6,58, 77, 87, 200, false, true, 2, nil, nil, false)
                    if self.currentDistance < 2 and not IsEntityDead(cache.ped) and IsControlJustPressed(0, 38) then
						ox_inventory:openInventory('shop', {id=k, type=k})
                    end
                end
            })
        end
    end
end)