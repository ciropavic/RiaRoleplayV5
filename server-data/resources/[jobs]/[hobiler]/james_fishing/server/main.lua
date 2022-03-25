ESX = nil

local limit = 50000

local cachedData = {}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterUsableItem(Config.FishingItems["rod"]["name"], function(source)
	TriggerClientEvent("james_fishing:tryToFish", source)
end)

ESX.RegisterServerCallback("james_fishing:receiveFish", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	player.removeInventoryItem(Config.FishingItems["bait"]["name"], 1)
	player.addInventoryItem(Config.FishingItems["fish"]["name"], math.random(4,7))
	
	callback(true)
end)

ESX.RegisterServerCallback("james_fishing:sellFish", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	local fishItem = Config.FishingItems["fish"]

	local fishCount = player.getInventoryItem(fishItem["name"])["count"]
	local fishPrice = fishItem["price"]

	if fishCount > 0 then
		player.removeInventoryItem(fishItem["name"], 1)
		if CheckJobLimit(source, fishPrice) == true then
			player.addMoney(fishPrice)
			TriggerClientEvent('esx_xp:Add', source, 2500)
		elseif CheckJobLimit(source,fishPrice) == false then
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Günlük çalışma limitine ulaştın!', length = 2500})
			player.addInventoryItem(fishItem["name"], 1)
			callback(false)
			return
	end
end
end)

function CheckJobLimit(source, amount)
    local _source = source
    local player = ESX.GetPlayerFromId(_source)
    local result = MySQL.Sync.fetchAll("SELECT joblimit FROM users WHERE identifier = @identifier", {
        ["@identifier"] = player.identifier,
	})

    if result[1].joblimit >= limit then -- limit sayısı
    	return false
    else
        MySQL.Async.execute("UPDATE users SET joblimit = @joblimit WHERE identifier = @identifier", {
            ["@joblimit"] = result[1].joblimit + amount, -- günlük limiti aşmayıp satış yaptığı için sql de o kişinin satışını arttırma
            ["@identifier"] = player.identifier
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