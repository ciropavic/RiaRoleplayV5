-------------------------------------
------- Created by T1GER#9080 -------
------- Cracked by R32#2445 ---------
-------------------------------------


RegisterNetEvent('t1ger_carinsurance:openMenu')
AddEventHandler('t1ger_carinsurance:openMenu', function()
    OpenInsuranceMenu()
end)

function OpenInsuranceMenu()
    menuOpen = true
    local playerPed  = GetPlayerPed(-1)
    FreezeEntityPosition(playerPed, true)
    local elements = {}

    ESX.TriggerServerCallback("t1ger_carinsurance:fetchData", function(vehicles)

        for k,v in pairs(vehicles) do
            local vehHash = v.vehicle.model
            local vehName = GetDisplayNameFromVehicleModel(vehHash)
            local vehLabel = GetLabelText(vehName)

            table.insert(elements,{ label = vehLabel.." ("..v.plate..")" , name = vehLabel, plate = v.plate, insurance = v.insurance})
        end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), "insurance_main_menu",
            {   title    = Lang['insurance_menu_title'],
                align    = Config.ShopMenuAlign,
                elements = elements
            },function(data, menu)
                menu.close()
                OpenBuyMenu(data.current.plate, data.current.insurance, data.current.name)
            end, function(data, menu)
                menu.close()
                ESX.UI.Menu.CloseAll()
                FreezeEntityPosition(playerPed, false)
                menuOpen = false
        end)
    end)
end

open = false
RegisterNetEvent('t1ger_carinsurance:openCL')
AddEventHandler('t1ger_carinsurance:openCL', function(data, vehPlate)
    open = true
    SendNUIMessage({ action = "open", array  = data, plate   = vehPlate })
end)
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(0, Config.KeyToHidePaper) and open then
            SendNUIMessage({
                action = "close"
                })
            open = false
        end
    end
end)


