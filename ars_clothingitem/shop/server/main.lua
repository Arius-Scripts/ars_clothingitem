local ox_inventory = exports.ox_inventory
CreateThread(function() 
    for e, f in pairs(Shop) do
        ox_inventory:RegisterShop(e, {
            name = f.label,
            inventory = f.items,
        })
    end
end)

RegisterNetEvent("ars_clothing:selectItem", function(name, t, drawable, texture)
    ox_inventory:RegisterShop(name..drawable, {
        name = "Search "..name.." #"..drawable,
        inventory = 
        {
            {name = name, price = 15, metadata = {type = t, drawable = drawable, texture = texture, label = name..' '..drawable, image = name..'_1'} },
        },
    })
end)

