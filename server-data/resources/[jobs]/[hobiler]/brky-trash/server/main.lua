local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterServerEvent("brky:trashrew")
AddEventHandler("brky:trashrew", function()
    local player = ESX.GetPlayerFromId(source)

    local luck = math.random(0, 100)

    if luck >= 90 then
       player.addInventoryItem('elmalikek', 2)
    elseif luck < 80 and luck >= 70 then
        player.addInventoryItem('fixkit', 2)
    elseif luck < 70 and luck >= 60 then
        player.addInventoryItem('fixkit', 2)
    elseif luck < 60 and luck >= 50 then
        player.addInventoryItem('fixkit', 2)
    elseif luck < 50 and luck >= 40 then
        player.addInventoryItem('fixkit', 2)
    elseif luck < 40 and luck >= 30 then
        player.addInventoryItem('lighter', 2)
    elseif luck < 30 and luck >= 20 then
        player.addInventoryItem('lighter', 2)
    elseif luck < 20 and luck >= 10 then
        player.addInventoryItem('lighter', 2)
    elseif luck < 10 and luck >= 1 then
        player.addInventoryItem('lighter', 2)
    end
end)
