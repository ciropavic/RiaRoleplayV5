ESX = nil
local limit = 50000

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("buyPickAxe:minerJob")
AddEventHandler("buyPickAxe:minerJob", function(shopCostMenu)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() < shopCostMenu then
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Yeterli paranız yok', length = 2500})
    else
    xPlayer.removeMoney(shopCostMenu)
    xPlayer.addInventoryItem("pickaxe", 1)
    end
end)


RegisterNetEvent("buyBread:minerJob")
AddEventHandler("buyBread:minerJob", function(shopCostMenu)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() < shopCostMenu then
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Yeterli paranız yok', length = 2500})
    else
    xPlayer.removeMoney(shopCostMenu)
    xPlayer.addInventoryItem("bread", 1)
    end
end)


RegisterNetEvent("buyWater:minerJob")
AddEventHandler("buyWater:minerJob", function(shopCostMenu)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() < shopCostMenu then
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Yeterli paranız yok', length = 2500})
    else
    xPlayer.removeMoney(shopCostMenu)
    xPlayer.addInventoryItem("water", 1)
    end
end)


RegisterServerEvent("refreshItems:minerJob") 
AddEventHandler("refreshItems:minerJob", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
		
	local goldCount = xPlayer.getInventoryItem('gold').count
	local ironCount = xPlayer.getInventoryItem('iron').count
	local pickaxeCount = xPlayer.getInventoryItem('pickaxe').count
    

    TriggerClientEvent("refreshGold:minerJob", source, goldCount)
    TriggerClientEvent("refreshIron:minerJob", source, ironCount)
    TriggerClientEvent("refreshPickaxe:minerJob", source, pickaxeCount)
end)


RegisterNetEvent("sellResource:minerJob")
AddEventHandler("sellResource:minerJob", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    local goldCount = xPlayer.getInventoryItem('gold').count
    local ironCount = xPlayer.getInventoryItem('iron').count

    local randomGoldCash = math.random(50, 100)
    local randomIronCash = math.random(10, 20)


    local goldReward = 1 * randomGoldCash
    local ironReward = 1 * randomIronCash
    local completReward = 1 + 1

    if goldCount > 0 then
        xPlayer.removeInventoryItem("gold", 1)
        if CheckJobLimit(_source, goldReward) == true then
            xPlayer.addMoney(goldReward)
            TriggerClientEvent('esx_xp:Add', _source, 2500)
        elseif CheckJobLimit(_source,goldReward) == false then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Günlük limitine ulaştın!', length = 2500})
            xPlayer.addInventoryItem('gold', 1)
            return

    end
    if ironCount > 0 then
        xPlayer.removeInventoryItem("iron", 1)
        xPlayer.addMoney(ironReward)
        if CheckJobLimit(_source, ironReward) == true then
            xPlayer.addMoney(ironReward)
        elseif CheckJobLimit(_source,ironReward) == false then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Günlük limitine ulaştın!', length = 2500})
            xPlayer.addInventoryItem('iron', 1)
            return

    end

    if completReward == 0 then

    else
        TriggerClientEvent("showReward:minerJob", source, completReward)
    end
    
end
end
end)


RegisterNetEvent("addItems:minerJob")
AddEventHandler("addItems:minerJob", function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local randomItem = math.random(1,100)

    local randomeIronCounter = math.random(1,3)

    if randomItem < 65 then
        xPlayer.addInventoryItem("iron", randomeIronCounter)
    else
        xPlayer.addInventoryItem("gold", 1)
    end

end)


RegisterNetEvent("removePickaxe:minerJob")
AddEventHandler("removePickaxe:minerJob", function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local randomDestroy = math.random(1,100)
   
    print(randomDestroy)
    if randomDestroy < 80 then
        
    else
        TriggerClientEvent("pickaxeBroken:minerJob", source)
        xPlayer.removeInventoryItem("pickaxe", 1)
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