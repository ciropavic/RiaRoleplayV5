ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('egyt_radares:setfine')
AddEventHandler('egyt_radares:setfine', function(vehicleName, plate, Speed, fine)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		local retrivedInfo = {plate = plate}

		if result[1] then
			local xTarget = ESX.GetPlayerFromIdentifier(result[1].owner)

			MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
			{
				['@identifier']  = result[1].owner,
				['@sender']      = 'LSPD - Radar System',
				['@target_type'] = 'society',
				['@target']      = 'society_police',
				['@label']       = 'Araç Adı :' .. vehicleName .. ', Plaka ' .. plate .. ' Hız :' .. Speed .. ' km/s.',
				['@amount']      = fine
			}, function(rowsChanged)
				if xTarget then
					TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'error', text =  'Hız cezası! Trafik canavarı yakalandın Hız :' .. Speed .. ' km/h.'})
				end
			end)
		end
	end)
end)
