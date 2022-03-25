ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fizzfau-playroom:reward')
AddEventHandler('fizzfau-playroom:reward', function(name, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(name, count)
end)

ESX.RegisterServerCallback('fizzfau-playroom:GetClock', function(source, cb)
	local ts = os.time()
	local time = {hour = os.date('%H', ts), minute = os.date('%M', ts)}
	cb({
		time.hour,
		time.minute
	})
end)

RegisterServerEvent('fizzfau-playroom:alinamaz')
AddEventHandler('fizzfau-playroom:alinamaz', function()
	TriggerClientEvent('fizzfau-playroom:alinamaz', -1)
end)

RegisterServerEvent('fizzfau-playroom:alinabilir')
AddEventHandler('fizzfau-playroom:alinabilir', function()
	TriggerClientEvent('fizzfau-playroom:alinabilir', -1)
end)


function Reset()
	print("sex")
	TriggerEvent('fizzfau-playroom:alinabilir')
end

RegisterServerEvent('fizzfau-playroom:addMoney')
AddEventHandler('fizzfau-playroom:addMoney', function(money)
	local player = ESX.GetPlayerFromId(source)
	player.addMoney(money)
end)

ESX.RegisterServerCallback('fizzfau-itemcheck', function(source, cb, item)
	local player = ESX.GetPlayerFromId(source)
	local item_count = player.getInventoryItem(item).count
	if item_count > 0 then
		cb(true)
	else
		cb(false)
	end
end)

-- TriggerEvent('rcon:runAt', fizzfau.Clock.Start, 00, Reset)