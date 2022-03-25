-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Open Insurance Paper
RegisterServerEvent('t1ger_carinsurance:openSV')
AddEventHandler('t1ger_carinsurance:openSV', function(player, target, plate)
	local identifier = ESX.GetPlayerFromId(player).identifier
	local _source 	 = ESX.GetPlayerFromId(target).source
	local vehFound   = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier}, function (user)
		local vehPlate = nil
		local vehIns = 0
		local vehHash = nil
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT * FROM '..Config.OwnedVehicles..' WHERE owner=@identifier',{['@identifier'] = identifier}, function(vehData) 
				for k,v in pairs(vehData) do
					if plate == v.plate then
						local vehicle = json.decode(v.vehicle)
						vehHash = vehicle.model
						vehIns = v.insurance
						vehPlate = v.plate
						vehFound = true
					end
				end
				if vehFound then
					local label
					if vehIns == 0 then
						label = "NO"
					elseif vehIns == 1 then
						label = "YES"
					end
					local info = {
						user = user,
						carPlate = vehPlate,
						carIns = label,
						carHash = vehHash,
					}
					TriggerClientEvent('t1ger_carinsurance:openCL', _source, info, plate)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', length = 5000, text = "Such a machine does not exist" })
					---TriggerClientEvent('t1ger_carinsurance:ShowNotifyESX', _source, Lang['plate_not_exists'])
				end
			end)
		end
	end)
end)

-- Callback to check vehicle insurance state:
ESX.RegisterServerCallback("t1ger_carinsurance:checkInsurance", function(source, cb, vehPlate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local carPlate = vehPlate
	local data = MySQL.Sync.fetchAll('SELECT * FROM '..Config.OwnedVehicles..'')
	local hasInsurance = false
	local invalidPlate = true
	for k,v in pairs(data) do
		if carPlate == v.plate then
			if v.insurance == 1 then
				hasInsurance = true
			elseif v.insurance == 0 then
				hasInsurance = false
			end
			invalidPlate = false
			cb(hasInsurance)
		end
	end
	if invalidPlate == true then
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', length = 5000, text = "Such a machine does not exist" })
		---TriggerClientEvent('t1ger_carinsurance:ShowNotifyESX', xPlayer.source, Lang['plate_not_exists'])
	end
end)

-- Server event to update vehicle insurance state:
RegisterServerEvent("t1ger_carinsurance:updateInsurance")
AddEventHandler("t1ger_carinsurance:updateInsurance", function(plate,updatedIns)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
		MySQL.Async.fetchAll('SELECT * FROM '..Config.OwnedVehicles..' WHERE owner=@identifier',{['@identifier'] = xPlayer.getIdentifier()}, function(data) 

			for k,v in pairs(data) do
				if plate == v.plate then
					MySQL.Async.execute('UPDATE '..Config.OwnedVehicles..' SET insurance=@insurance WHERE plate=@plate',{['@plate'] = plate,['@insurance'] = updatedIns}, function() end)
					break
				end
			end
			
		end)
	end
end)

-- Server event to calculate insurance fees:
RegisterServerEvent("t1ger_carinsurance:getPayment")
AddEventHandler("t1ger_carinsurance:getPayment", function(OwnedVeh)
	local xPlayer = ESX.GetPlayerFromId(source)
	local data3 = MySQL.Sync.fetchAll('SELECT * FROM vehicles') -- get data
	local FoundCarData = {}	-- table 
	
	-- get vehicle prices for insured vehicles:
	for k,v in pairs(data3) do
		for r,t in pairs(OwnedVeh) do
			if v.model == t.name then
				table.insert(FoundCarData,{name = t.name, price = v.price, plate = t.plate})
			end
		end
	end
	local paid = true
	-- calculate price
	local insPrice = 500
	for k,v in pairs(FoundCarData) do
		insPrice = insPrice + v.price
	end
	-- pay x % of the total ins Price
	local newPrice = math.floor(insPrice * (Config.PaymentFactor/100))
	xPlayer.removeAccountMoney('bank', newPrice)
end)

-- Callback to fetch insured vehicles for an identifier:
ESX.RegisterServerCallback("t1ger_carinsurance:fetchInsuredCars", function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local cars = {}
	if xPlayer then
		MySQL.Async.fetchAll('SELECT * FROM '..Config.OwnedVehicles..' WHERE owner=@identifier',{['@identifier'] = xPlayer.getIdentifier()}, function(data) 
			for k,v in pairs(data) do
				if v.insurance == 1 then
					local vehicle = json.decode(v.vehicle)
					table.insert(cars, {vehicle = vehicle, plate = v.plate, insurance = v.insurance})
				end
			end
			cb(cars)
		end)
	end
end)

