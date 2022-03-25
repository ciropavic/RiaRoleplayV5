Citizen.CreateThread(function()
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
        name = 'stash',
        label = _U('stash'),
        slots = 100
    })
end)

Citizen.CreateThread(function()
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
        name = 'stash',
        label = 'Depo',
        slots = 100
    })
end)

Citizen.CreateThread(function()
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
        name = 'motel',
        label = 'Motel',
        slots = 80
    })
end)
