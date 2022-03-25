ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('maymuncuk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent("welldone_lockpick:open", xPlayer.source)
end)

RegisterServerEvent('welldone_lockpick:add')
AddEventHandler('welldone_lockpick:add', function(source, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('lockpick', 1)
end)

RegisterServerEvent('welldone_lockpick:remove')
AddEventHandler('welldone_lockpick:remove', function(source, item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('maymuncuk', 1)
end)