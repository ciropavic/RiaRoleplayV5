ESX = nil

Wrapper.TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Wrapper.RegisterNetEvent('blargleambulance:finishLevel')
Wrapper.AddEventHandler('blargleambulance:finishLevel', function(levelFinished)
    ESX.GetPlayerFromId(source).addInventoryItem(Config.Formulas.moneyPerLevel(levelFinished))
    TriggerClientEvent('esx_xp:Add', source, 2500)
end)