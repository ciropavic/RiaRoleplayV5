-------------------------------------
------- Created by T1GER#9080 -------
------- Cracked by R32#2445 ---------
-------------------------------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback("t1ger_carinsurance:fetchData", function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local vehicles = {}
    if xPlayer then
        MySQL.Async.fetchAll('SELECT * FROM '..Config.OwnedVehicles..' WHERE owner=@identifier',{['@identifier'] = xPlayer.getIdentifier()}, function(data)
            
            for k,v in pairs(data) do
                local vehicle = json.decode(v.vehicle)
                table.insert(vehicles, {vehicle = vehicle, plate = v.plate, insurance = v.insurance})
            end
            cb(vehicles)
        end)
    end
end)


