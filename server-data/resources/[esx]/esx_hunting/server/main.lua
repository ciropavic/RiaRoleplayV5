ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx-qalle-hunting:reward')
AddEventHandler('esx-qalle-hunting:reward', function(Weight)
    local xPlayer = ESX.GetPlayerFromId(source)

    if Weight >= 1 then
        xPlayer.addInventoryItem('meat', 1)
    elseif Weight >= 9 then
        xPlayer.addInventoryItem('meat', 2)
    elseif Weight >= 15 then
        xPlayer.addInventoryItem('meat', 3)
    end

    xPlayer.addInventoryItem('leather', math.random(1, 4))
        
end)

RegisterServerEvent('esx-qalle-hunting:sell')
AddEventHandler('esx-qalle-hunting:sell', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    local MeatPrice = 400
    local LeatherPrice = 300

    local MeatQuantity = xPlayer.getInventoryItem('meat').count
    local LeatherQuantity = xPlayer.getInventoryItem('leather').count

    if MeatQuantity > 0 or LeatherQuantity > 0 then
        xPlayer.addMoney(MeatQuantity * MeatPrice)
        xPlayer.addMoney(LeatherQuantity * LeatherPrice)

        xPlayer.removeInventoryItem('meat', MeatQuantity)
        xPlayer.removeInventoryItem('leather', LeatherQuantity)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source,  {type='error', text = 'Sattın ' .. LeatherQuantity + MeatQuantity .. '  Kazandığın para $' .. LeatherPrice * LeatherQuantity + MeatPrice * MeatQuantity})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source , {type='error', text='Çantan da et veya hayvan derisi yok'})
    end
        
end)

function sendNotification(xsource, message, messageType, messageTimeout)
    TriggerClientEvent('notification', xsource, message)
end


RegisterServerEvent('hunting:removeWeapons')
AddEventHandler('hunting:removeWeapons', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('WEAPON_MUSKET', 1)
    xPlayer.removeInventoryItem('WEAPON_HATCHET', 1)
end)

RegisterServerEvent('hunting:addWeapons')
AddEventHandler('hunting:addWeapons', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('WEAPON_MUSKET', 1)
    xPlayer.addInventoryItem('WEAPON_HATCHET', 1)
end)