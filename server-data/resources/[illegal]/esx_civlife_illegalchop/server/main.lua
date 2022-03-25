--[[
	KrizFrost Illegal Chop Shop
	Free Release on FiveM Forums [DO NOT SELL NOR RE-RELEASE WITHOUT MY PERMISSION]
	[Aug 29, 2019]
]]

ESX = nil

local limit = 25000

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('esx_civlife_illegalchop:success')
AddEventHandler('esx_civlife_illegalchop:success', function(pay)
local xPlayer = ESX.GetPlayerFromId(source)
if CheckJobLimit(xPlayer.source, pay) == true then
	xPlayer.addMoney(pay)
elseif CheckJobLimit(xPlayer.source, pay) == false then
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Günlük limitine ulaştın!', length = 2500})
	xPlayer.addInventoryItem(drugType, drugamount)
	return
end
end)


function CheckJobLimit(source, amount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
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