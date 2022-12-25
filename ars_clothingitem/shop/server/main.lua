local ox_inventory = exports.ox_inventory
CreateThread(function() 
    for e, f in pairs(Shop) do
        ox_inventory:RegisterShop(e, {
            name = f.label,
            inventory = f.items,
        })
    end
end)