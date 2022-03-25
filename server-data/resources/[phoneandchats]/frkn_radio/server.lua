TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterUsableItem('radio', function(source, item, slot)
    TriggerClientEvent('frkn_radio:openRadio', source)
end)

RegisterServerEvent('frkn_radio:requestPData')
AddEventHandler('frkn_radio:requestPData', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then
        if xPlayer.job ~= nil then
            TriggerClientEvent('frkn_radio:loadPData', source, xPlayer.job)
        end
    end
end)