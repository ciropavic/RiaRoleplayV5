ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ESX.RegisterServerCallback('noble:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local qtty = xPlayer.getInventoryItem(item).count
	cb(qtty)
end)

print('[^2noble-bodycam^0] - Started!')

function getIdentity(source)

	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = source})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

ESX.RegisterUsableItem('bodycam', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('noble:bodycam', source)
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		 if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
		if xPlayer.getInventoryItem('bodycam').count >= 1 then 
            local name = getIdentity(xPlayer.identifier)
			TriggerClientEvent('bodycam:show', xPlayers[i], 'Ad Soyad : ' .. name.firstname .. name.lastname, 'Rütbe : ' .. xPlayer.job.grade_label)
		 else 
			TriggerClientEvent('bodycam:close', xPlayers[i])
			end
		end
	end
end
end)

