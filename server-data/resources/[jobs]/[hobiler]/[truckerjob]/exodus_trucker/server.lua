local limit = 35000

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

for k, v in pairs(Config.Jobs) do
    v['taken'] = false
end

RegisterServerEvent('esx_ets:startJob')
AddEventHandler('esx_ets:startJob', function(id)
    local xPlayer, hasJob = ESX.GetPlayerFromId(source), true
    if Config.Job['jobRequired'] then
        if xPlayer.job.name == Config.Job['jobName'] then
            hasJob = true
        else
            hasJob = false
        end
    end
    if hasJob then
        if not Config.Jobs[id]['taken'] then
            Config.Jobs[id]['taken'] = true
            TriggerClientEvent('esx_ets:start', xPlayer.source, Config.Jobs[id], id)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, Strings['somebody_doing'])
        end
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, Strings['not_job'])
    end
end)

RegisterServerEvent('esx_ets:jobMenu')
AddEventHandler('esx_ets:jobMenu', function()
    local elements, xPlayer = {}, ESX.GetPlayerFromId(source)
    for k, v in pairs(Config.Jobs) do
        if not v['taken'] then
            table.insert(elements, {label = v.title, value = k})
        end
    end
    TriggerClientEvent('esx_ets:menu', xPlayer.source, elements)
end)

RegisterServerEvent('esx_ets:jobFinished')
AddEventHandler('esx_ets:jobFinished', function(id, damages)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if Config.Jobs[id]['taken'] then
        local price, health = Config.Jobs[id].payment, (damages['body_health'] + damages['engine_health']) / 2
        for k, v in pairs(damages['windows']) do health = health - 30 end
        for k, v in pairs(damages['tires']) do health = health - 35 end
        for k, v in pairs(damages['doors']) do health = health - 40 end
        if health <= 900 and health > 800 then price = price - 50 elseif health <= 800 and health > 700 then price = price - 75 elseif health <= 700 and health > 600 then price = price - 100 elseif health <= 600 and health > 300 then price = price - 150 elseif health <= 300 then price = price - 350 end
        if price >= 0 then
            if CheckJobLimit(_source, price) == true then
                xPlayer.addMoney(price)
                TriggerClientEvent('esx_xp:Add', _source, 2500)
            elseif CheckJobLimit(_source, price) == false then
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Günlük limitine ulaştın!', length = 2500})
        else
            xPlayer.removeMoney(price)
            TriggerClientEvent('esx:showNotification', xPlayer._source, (Strings['paid_damages']):format(price))
        end
        Wait(Config.ReAdd * 1000)
        Config.Jobs[id]['taken'] = false
    end
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