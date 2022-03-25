TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'ck', 'admin', function(source, args, user)
    MySQL.Async.execute('DELETE FROM users WHERE identifier = @identifier', {
		['@identifier'] = args[1]
    })

    MySQL.Async.execute('DELETE FROM addon_account_data WHERE owner = @owner', {
		['@owner'] = args[1]
    })

    MySQL.Async.execute('DELETE FROM datastore_data WHERE owner = @owner', {
		['@owner'] = args[1]
    })

    MySQL.Async.execute('DELETE FROM datastore_data WHERE owner = @owner', {
		['@owner'] = args[1]
    })

    MySQL.Async.execute('DELETE FROM characters WHERE identifier = @identifier', {
		['@identifier'] = args[1]
    })

    MySQL.Async.execute('DELETE FROM characters_motel WHERE userIdentifier = @userIdentifier', {
		['@userIdentifier'] = args[1]
    })

    MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner = @owner', {
		['@owner'] = args[1]
    })

    MySQL.Async.execute('DELETE FROM phone_users_contacts WHERE identifier = @identifier', {
		['@identifier'] = args[1]
    })

    MySQL.Async.execute('DELETE FROM phone_users_contacts WHERE identifier = @identifier', {
		['@identifier'] = args[1]
    })

    MySQL.Async.execute('DELETE FROM user_inventory WHERE identifier = @identifier', {
		['@identifier'] = args[1]
    })

    MySQL.Async.execute('DELETE FROM user_lastcharacter WHERE steamid = @steamid', {
		['@steamid'] = args[1]
    })
    
    MySQL.Async.execute('DELETE FROM user_licenses WHERE owner = @owner', {
		['@owner'] = args[1]
    })

    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'Başarıyla ' .. args[1] .. ' steam hex\'e ck atıldı.'})
end)