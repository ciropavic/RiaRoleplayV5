ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('calculator', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem("calculator").count > 0 then
        TriggerClientEvent('calculator:on', source)
    else
     TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Hesap makinen yok marketten alabilirsin',  length = 3000})    
    end
end)