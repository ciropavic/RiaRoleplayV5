ESX = nil
local limit = 50000

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'realestateagent' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('esx_taglialegnasdr:legnatagliata')
AddEventHandler('esx_taglialegnasdr:legnatagliata', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('wood', Config.Wood)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Ağaçları başarıyla kestin', length = 2500})
end)

RegisterServerEvent('esx_taglialegnasdr:segatura')
AddEventHandler('esx_taglialegnasdr:segatura', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('cutted_wood', 100)
	xPlayer.removeInventoryItem('wood', 100)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Vay be ne kadar güçlüsün paramparça odunlar', length = 2500})
end)

RegisterServerEvent('esx_taglialegnasdr:tavole')
AddEventHandler('esx_taglialegnasdr:tavole', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('packaged_plank', 100)
	xPlayer.removeInventoryItem('cutted_wood', 100)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Parçalanmış odunları paketledin', length = 2500})
end)


RegisterServerEvent('esx_taglialegnasdr:venditablip')
AddEventHandler('esx_taglialegnasdr:venditablip', function(quantity)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local fattura  = Config.Money

	if CheckJobLimit(_source, fattura) == true then
		xPlayer.addMoney(fattura)
		xPlayer.removeInventoryItem('packaged_plank', 1)
		TriggerClientEvent('esx_xp:Add', _source, 2500)
	elseif CheckJobLimit(_source,fattura) == false then
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Günlük limitine ulaştın!', length = 2500})
		return

	end
end)

function CheckJobLimit(source, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local result = MySQL.Sync.fetchAll("SELECT joblimit FROM users WHERE identifier = @identifier", {
        ["@identifier"] = xPlayer.identifier,
	})

    if result[1].joblimit >= limit then -- limit sayısı
    	return false
    else
        MySQL.Async.execute("UPDATE users SET joblimit = @joblimit WHERE identifier = @identifier", {
            ["@joblimit"] = result[1].joblimit + amount, -- günlük limiti aşmayıp satış yaptığı için sql de o kişinin satışını arttırma
            ["@identifier"] = xPlayer.identifier
        })
        return true
    end
end

function ResetJobLimits()
    local sqlresult = MySQL.Sync.fetchAll("SELECT * FROM users")

    for i = 1, #sqlresult, 1 do
        MySQL.Async.execute("UPDATE users SET joblimit = @joblimit WHERE identifier = @identifier", {
            ["@joblimit"] = 0,
            ["@identifier"] = sqlresult[i].identifier
        })
    end
    print("^1Meslek limitleri sıfırlandı.^0")
end


TriggerEvent('cron:runAt', 00, 00, ResetJobLimits)