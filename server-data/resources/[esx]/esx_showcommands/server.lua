--{ Türkçeleştirme ve düzenleme yapılmıştır --www.fivemturk.com }--
ESX = nil
local RegisteredSocieties = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getBankFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('bank')
	return account.money

end
  


RegisterCommand('meslek', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.label
    local jobgrade = xPlayer.job.grade_label

--TriggerClientEvent('esx:showNotification', _source, 'You are working as: ~g~' .. job .. ' ~s~-~g~ ' .. jobgrade)
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Meslegin: ' .. job .. ' - ' .. jobgrade, length = 5000})  
end)

RegisterCommand('parabak', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
    local wallet 		= getMoneyFromUser(source)

--TriggerClientEvent('esx:showNotification', _source, 'You currently have ~g~$~g~' .. wallet .. ' ~s~in your wallet~g~ ')
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Paran: $' .. wallet, length = 5000 })
end)

RegisterCommand('bankapara', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
    local bank 			= getBankFromUser(source)

--TriggerClientEvent('esx:showNotification', _source, 'You currently have ~g~$~g~' .. bank .. ' ~s~in your bank~g~ ')
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Banka paran: $' .. bank, length = 5000 })
end)




RegisterCommand('kasapara', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.grade_name == 'boss' then
		local society = GetSociety(xPlayer.job.name)

		if society ~= nil then
			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				money = account.money
			end)
		else
			money = 0
		end
		
                --TriggerClientEvent('esx:showNotification', _source, 'You currently have ~g~$~g~' .. money .. ' ~s~in the society account~g~ ')
	        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Sirketteki Depo Paran: $' .. money })
																	
	else

	        --TriggerClientEvent('esx:showNotification', _source, '~r~Access not granted!')
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Erisim yok!', length = 5000})
																			
	end
end)

TriggerEvent('esx_society:getSocieties', function(societies) 
	RegisteredSocieties = societies
end)

function GetSociety(name)
  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      return RegisteredSocieties[i]
    end
  end
end
