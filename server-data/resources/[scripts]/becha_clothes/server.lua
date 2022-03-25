ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('becha_clothes:getPlayerDressing', function(source, cb)
    local xPlayer  = ESX.GetPlayerFromId(source)
  
    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
        local count    = store.count('dressing')
        local labels   = {}

        for i=1, count, 1 do
            local entry = store.get('dressing', i)
            table.insert(labels, entry.label)
        end
  
        cb(labels)
    end)
end)

ESX.RegisterServerCallback('becha_clothes:getPlayerOutfit', function(source, cb, num)
    local xPlayer  = ESX.GetPlayerFromId(source)
  
    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
        local outfit = store.get('dressing', num)
        cb(outfit.skin)
    end)
end)

RegisterServerEvent('becha_clothes:saveOutfit')
AddEventHandler('becha_clothes:saveOutfit', function(label, skin)

    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() <0 then 
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type='error', text = 'Kıyafet almak için paranız yok'})
    else
    xPlayer.removeMoney(150)
    end
	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)

		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)
	end)
end)