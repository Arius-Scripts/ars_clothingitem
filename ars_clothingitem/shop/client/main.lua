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



lib.registerContext({
    id = 'clothingMenu',
    title = 'Clothing Shop',
    options = {
        {
            title = 'Shop',
            description = 'Open clothing shop',
            onSelect = function(args)
                lib.hideContext()
                shopInput()
            end,
        },
        {
            title = 'Search',
            description = 'Search clothing by clicking here!',
            onSelect = function(args)
                lib.hideContext()
                selectInput()
            end,
        },
    },
})


function shopInput()
    local input = lib.inputDialog('Shop', {
        { type = 'select', label = 'Type', options = {
            { value = 'torso', label = 'Torso' },
            { value = 'pants', label = 'Pants' },
            { value = 'shirt', label = 'Shirt'},
            { value = 'shoes', label = 'Shoes'},
            { value = 'mask', label = 'Mask'},
            { value = 'bag', label = 'Bag'},

            { value = 'hat', label = 'Hat'},
            { value = 'glasses', label = 'Glasses'},
            { value = 'watch', label = 'Watch'},
            { value = 'earrings', label = 'Earrings'},
        }},
    })

    if input then

        value = input[1]

		ox_inventory:openInventory('shop', {id=value, type=value})

    end
end


local types = {
    torso = 11,
    pants = 4,
    shoes = 6,
    shirt = 8,
    mask = 1,
    bag = 5,

    hat = 0,
    glasses = 1,
    watch = 6,
    earrings = 2,
}

function selectInput()
    local input = lib.inputDialog('Shop', {
        { type = 'select', label = 'Type', options = {
            { value = 'torso', label = 'Torso' },
            { value = 'pants', label = 'Pants' },
            { value = 'shirt', label = 'Shirt'},
            { value = 'shoes', label = 'Shoes'},
            { value = 'mask', label = 'Mask'},
            { value = 'bag', label = 'Bag'},

            { value = 'hat', label = 'Hat'},
            { value = 'glasses', label = 'Glasses'},
            { value = 'watch', label = 'Watch'},
            { value = 'earrings', label = 'Earrings'},
        }},
        { type = "number", label = "Drawable", default = 1 },
        { type = "number", label = "Texture", default = 0 },
    })

    if input then

        value = input[1]
        drawable = input[2]
        texture = input[3]

        TriggerServerEvent("ars_clothing:selectItem", value, tonumber(types[value]), drawable, texture)
        exports.ox_inventory:openInventory('shop', { type = value..drawable, id = 1})
    end
end

function openClothingMenu()
    lib.showContext('clothingMenu')
end


RegisterCommand("clothingmenu", function()
    lib.showContext('clothingMenu')
end)

exports('openClothingMenu', openClothingMenu)
