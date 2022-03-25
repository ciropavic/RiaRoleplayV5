local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0
ESX = nil
doorstatus = false
bonuscracked = false
hacked = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('fizzfau-doorlock:vangelico')
AddEventHandler('fizzfau-doorlock:vangelico', function(data)
	if not doorstatus then
		TriggerClientEvent('fizzfau-doorlock:vangelico', -1, data)
		--TriggerClientEvent('fizzfau-vangelico:rob', source)
		Citizen.Wait(Config.SecBetwNextRob)
		TriggerClientEvent('fizzfau-doorlock:vangelico', -1, false)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, {type='error', text='Bu yakın zamanda kullanıldı!'})
	end
	
end)

RegisterServerEvent('fizzfau-doorlock:bonus')
AddEventHandler('fizzfau-doorlock:bonus', function(data)
	if not bonuscracked then
		TriggerClientEvent('fizzfau-doorlock:bonus', -1, data)
		--TriggerClientEvent('fizzfau-vangelico:rob', source)
		Citizen.Wait(Config.SecBetwNextRob)
		TriggerClientEvent('fizzfau-doorlock:bonus', -1, false)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, {type='error', text='Bu yakın zamanda kullanıldı!'})
	end
	
end)

RegisterServerEvent('fizzfau-vangelico:addBank')
AddEventHandler('fizzfau-vangelico:addBank', function(data)
	local xplayer = ESX.GetPlayerFromId(source)
	xplayer.addAccountMoney('bank', data)	
end)

RegisterServerEvent('fizzfau-doorlock:hacked')
AddEventHandler('fizzfau-doorlock:hacked', function(data)
	if not hacked then
		TriggerClientEvent('fizzfau-doorlock:hacked', -1, data)
		--TriggerClientEvent('fizzfau-vangelico:rob', source)
		Citizen.Wait(Config.SecBetwNextRob)
		TriggerClientEvent('fizzfau-doorlock:hacked', -1, false)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, {type='error', text='Bu yakın zamanda kullanıldı!'})
	end
	
end)

ESX.RegisterServerCallback('fizzfau-vangelico:checkItem', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	itemcount = xPlayer.getInventoryItem(item).count
	if itemcount > 0 then
		cb(true)
	else
		cb(false)
	end
end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('esx_vangelico_robbery:toofar')
AddEventHandler('esx_vangelico_robbery:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	TriggerClientEvent('fizzfau:asked', source)

	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayers[i], {type='error', text=_U('robbery_cancelled_at') .. Stores["jewelry"].nameofstore})
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('mythic_notify:client:SendAlert', source, {type='error', text=_U('robbery_has_cancelled') .. Stores["jewelry"].nameofstore})
	end
end)

RegisterServerEvent('esx_vangelico_robbery:endrob')
AddEventHandler('esx_vangelico_robbery:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	TriggerClientEvent('fizzfau:asked', source)

	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayers[i], _U('end'))
			TriggerClientEvent('esx_vangelico_robbery:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_vangelico_robbery:robberycomplete', source)
		robbers[source] = nil
		TriggerClientEvent('mythic_notify:client:SendAlert', source, {type='error', text=_U('robbery_has_ended') .. Stores[robb].nameofstore})
	end
end)

RegisterServerEvent('esx_vangelico_robbery:rob')
AddEventHandler('esx_vangelico_robbery:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.SecBetwNextRob and store.lastrobbed ~= 0 then
			doorstatus = true
			bonuscracked = true
			hacked = true
            TriggerClientEvent('esx_vangelico_robbery:togliblip', source)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, {type='error', text=_U('already_robbed') .. (Config.SecBetwNextRob - (os.time() - store.lastrobbed)) .. _U('seconds')})
			return
		end

		if rob == false then

			rob = true
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == 'police' then
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayers[i], {type='success', text=_U('rob_in_prog') .. store.nameofstore})
					TriggerClientEvent('esx_vangelico_robbery:setblip', xPlayers[i], Stores[robb].position)
				end
			end
			-- doorstatus = false
			-- bonuscracked = false
			-- hacked = false
			TriggerClientEvent('mythic_notify:client:SendAlert', source, {type='success', text=_U('started_to_rob') .. store.nameofstore .. _U('do_not_move')})
			TriggerClientEvent('mythic_notify:client:SendAlert', source, {type='inform', text=_U('alarm_triggered')})
			TriggerClientEvent('mythic_notify:client:SendAlert', source, {type='inform', text=_U('hold_pos')})
			TriggerClientEvent('esx_vangelico_robbery:currentlyrobbing', source, robb)
            CancelEvent()
			Stores[robb].lastrobbed = os.time()
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, {type='inform', text=_U('robbery_already')})
		end
	end
end)

RegisterServerEvent('fizzfau-hacknotify')
AddEventHandler('fizzfau-hacknotify', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	local store = Stores[robb]

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayers[i], {type='error', text='Hack işlemi tespit edildi! ' .. Stores["jewelry"].nameofstore})
			TriggerClientEvent('esx_vangelico_robbery:setblip', xPlayers[i], Stores["jewelry"].position)
		end
	end
end)

RegisterServerEvent('esx_vangelico_robbery:gioielli')
AddEventHandler('esx_vangelico_robbery:gioielli', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('jewels', math.random(Config.MinJewels, Config.MaxJewels))
end)

RegisterServerEvent('lester:vendita')
AddEventHandler('lester:vendita', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local reward = math.floor(Config.PriceForOneJewel * Config.MaxJewelsSell)

	xPlayer.removeInventoryItem('jewels', Config.MaxJewelsSell)
	xPlayer.addMoney(reward)
end)

ESX.RegisterServerCallback('esx_vangelico_robbery:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)

