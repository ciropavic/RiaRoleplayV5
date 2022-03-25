ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(50)
        ESX = exports["es_extended"]:getSharedObject()
    end
end)

local display = false

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('calculator:off')
	end
end)

RegisterNUICallback('NUIFocusOff', function()
	TriggerEvent('calculator:off')
end)

RegisterNetEvent('calculator:on')
AddEventHandler('calculator:on', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'ui', 
        display = true
    })
    display = true
end)

RegisterNetEvent('calculator:off')
AddEventHandler('calculator:off', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'ui', 
        display = false
    })
    display = false
end)