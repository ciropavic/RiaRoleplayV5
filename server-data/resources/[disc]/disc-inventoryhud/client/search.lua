local secondarySearchInventory = {
    type = 'player',
    owner = '',
    seize = true
}
local secondaryStealInventory = {
    type = 'player',
    owner = '',
    steal = true
}



RegisterNetEvent('disc-inventoryhud:search')

AddEventHandler('disc-inventoryhud:search', function()

    local player = ESX.GetPlayerData()

        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

        if closestPlayer ~= -1 and closestDistance <= 3.0 then

            local searchPlayerPed = GetPlayerPed(closestPlayer)

            if IsEntityPlayingAnim(searchPlayerPed, 'mp_arresting', 'idle', 3) or IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) or IsEntityDead(searchPlayerPed) or GetEntityHealth(searchPlayerPed) <= 0 then

                ESX.TriggerServerCallback('disc-inventoryhud:getIdentifier', function(identifier)

                    secondarySearchInventory.owner = identifier

                    openInventory(secondarySearchInventory)

                end, GetPlayerServerId(closestPlayer))

            else

                exports['mythic_notify']:SendAlert('error', 'Kişi ellerini kaldırmalı!')

            end

        end

end)

RegisterNetEvent('disc-inventoryhud:steal')

AddEventHandler('disc-inventoryhud:steal', function()

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 3.0 then

        local searchPlayerPed = GetPlayerPed(closestPlayer)

        if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) or IsEntityDead(searchPlayerPed) then

            ESX.TriggerServerCallback('disc-inventoryhud:getIdentifier', function(identifier)

                secondaryStealInventory.owner = identifier

                openInventory(secondaryStealInventory)

            end, GetPlayerServerId(closestPlayer))

        else

            exports['mythic_notify']:SendAlert('error', 'Kişi ellerini kaldırmalı!')

        end

    end

end)