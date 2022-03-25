ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('gcphone:getbilling', function(source, cb)
	local e=ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier',{["@identifier"]=e.identifier},function(result)
		local billingg = {}
		for i=1, #result, 1 do
			table.insert(billingg, {id = result[i].id, label = result[i].label, sender=result[i].sender, target=result[i].target, amount=result[i].amount}) 
		end
		cb(billingg)
	end)
end)




RegisterServerEvent("gcPhone:faturapayBill")
AddEventHandler("gcPhone:faturapayBill", function(id, sender, amount, target, sharedAccountName)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE id = @id', {
		['@id'] = id
	}, function(data)

	local xTarget = ESX.GetPlayerFromIdentifier(sender)
	local target = data[1].target
	local target_type = data[1].target_type
	
	if target_type=='player' then
	
	if xTarget ~= nil then	
    if amount ~= nil then
        if xPlayer.getBank() >= amount then	

					MySQL.Async.execute('DELETE from billing WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						xPlayer.removeAccountMoney('bank', amount)
						xTarget.addAccountMoney('bank',amount)
						TriggerClientEvent('updatebilling', e.source,src)
						TriggerClientEvent("esx:showNotification", src, "The bill has been paid $" .. amount)
						TriggerClientEvent("esx:showNotification", sender, "You don't have enough money.")
						TriggerClientEvent("esx:showNotification", xTarget.source, "The bill has been paid $" .. amount)

					end)
					
				else
					TriggerClientEvent("esx:showNotification", sender, "You don't have enough money.")
					TriggerClientEvent("esx:showNotification", src, "The bill has been paid $" .. amount)


				end

			else
				
				TriggerClientEvent("esx:showNotification", xTarget.source, "The bill has been paid of $" .. amount)

			end				
	
    end
	
	
	
	
	else
TriggerEvent('esx_addonaccount:getSharedAccount', target, function(account)	

        if xPlayer.getAccount("bank").money >= amount then	

					MySQL.Async.execute('DELETE from billing WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						xPlayer.removeAccountMoney('bank', amount)
						account.addMoney(amount)
						TriggerClientEvent('updatebilling', xPlayer.source, id)
						TriggerClientEvent("esx:showNotification", src, "The bill has been paid $" .. amount)
						if xTarget ~= nil then
						TriggerClientEvent("esx:showNotification", xTarget.source, "The bill has been paid $" .. amount)
						end

					end)
					
				else
					TriggerClientEvent("esx:showNotification", src, "You don't have enough money.")
					if xTarget ~= nil then
						TriggerClientEvent('esx:showNotification', xTarget.source, "He doesn't have enough money.")
					end

				end

end)

end





end)
end)

