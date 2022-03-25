ESX.RegisterServerCallback('gcPhone:getCars', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return; end
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE `owner` = @cid and type = @type",{
	    ["@cid"] = xPlayer.identifier,
        ["@type"] = "car"
		},function(result)
		local valcik = {}
		for i=1, #result, 1 do
			table.insert(valcik, {plate = result[i].plate, garage = result[i].garage, props = json.decode(result[i].vehicle)}) 
		end
		cb(valcik)
	end)
end)

ESX.RegisterServerCallback('erp_garage:checkMoney2', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local deudas = 0
	local result = MySQL.Sync.fetchAll('SELECT * FROM billing WHERE identifier = @identifier',{['@identifier'] = xPlayer.identifier})
	for i=1, #result, 1 do
		amount     = result[i].amount
		deudas = deudas + amount
		if deudas >= 10 then
			cb("deudas")
		end
	end
	if xPlayer.get('bank') >= 50 then
		cb(true)
	else
		cb(false)
	end
end)



ESX.RegisterServerCallback('gcPhone:loadVehicle', function(source, cb, plate)
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `plate` = @plate', {['@plate'] = plate}, function(vehicle)

		
		cb(vehicle)
	end)
end)

RegisterServerEvent('gcPhone:finish')
AddEventHandler('gcPhone:finish', function(plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx:showNotification', _source, _U('vale_get'))
	xPlayer.removeAccountMoney('bank', Config.ValePrice)
end)

RegisterServerEvent('gcPhone:valet-car-set-outside')
AddEventHandler('gcPhone:valet-car-set-outside', function(plate)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        MySQL.Async.execute('UPDATE owned_vehicles SET `garage` = @garage, `state` = @state WHERE `plate` = @plate', {
            ['@plate'] = plate,
			['@state'] = 0,
            ['@garage'] = "OUT",
        })
    end
end)