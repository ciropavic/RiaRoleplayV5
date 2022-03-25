ESX  = nil

local cachedBins = {}
local trashcooldown = false

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)
        Citizen.Wait(5)
    end
end)


RegisterNetEvent("brky:trsah")
AddEventHandler("brky:trsah", function()
    local sleepThread = 1000
    local entity, entityDst = ESX.Game.GetClosestObject(entity,Config.Kutu)
    if DoesEntityExist(entity) and entityDst <= 1.5 then
        sleepThread = 5
        local freeze = PlayerPedId()
        if not trashcooldown then
        local binCoords = GetEntityCoords(entity)

            if not cachedBins[entity] then
                cachedBins[entity] = true

                OpenTrash()
            else
                exports['mythic_notify']:SendAlert('error', 'Çöpü zaten aradın!')
            end
        end
        if trashcooldown then
            exports['mythic_notify']:SendAlert('error', 'Baska çöp ara!')
        end
    end
    Citizen.Wait(sleepThread)
end)

RegisterCommand("çöpk", function()
TriggerEvent('brky:trsah')
end, false)

function OpenTrash()
    local freeze = PlayerPedId()
	FreezeEntityPosition(freeze, true)
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    Citizen.Wait(10000)
    TriggerServerEvent("brky:trashrew")
    FreezeEntityPosition(freeze, false)
    ClearPedTasks(PlayerPedId())
    trashcooldown = true
    Citizen.Wait(20000)
    trashcooldown = false
end
