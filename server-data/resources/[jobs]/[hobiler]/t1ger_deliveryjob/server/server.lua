-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

ESX = nil
local limit = 50000

TriggerEvent(Config.ESXSHAREDOBJECT, function(obj) ESX = obj end)

RegisterServerEvent('t1ger_deliveryjob:fetchCompanySV')
AddEventHandler('t1ger_deliveryjob:fetchCompanySV', function()
    local xPlayers = ESX.GetPlayers()
    local players  = {}
    local DataFected = false
	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, { source = xPlayer.source, identifier = xPlayer.identifier, companyID = 0 })
    end
    MySQL.Async.fetchAll("SELECT * FROM t1ger_deliveryjob", {}, function(results)
        if #results > 0 then 
            for l,ply in pairs(players) do
                for k,v in pairs(results) do
                    if ply.identifier == v.identifier then
                        ply.companyID = v.companyID
                    end
                    if k == #results then DataFected = true end
                end
            end
        else
            DataFected = true
        end
    end)
    while not DataFected do Wait(5) end
    local plyCompanyID = 0
    if DataFected then 
        for k,v in pairs(players) do
            if v.companyID > 0 then plyCompanyID = v.companyID else plyCompanyID = 0 end
            TriggerClientEvent('t1ger_deliveryjob:fetchCompanyCL', v.source, plyCompanyID)
        end
    end
end)

-- Get Owned Companies:
ESX.RegisterServerCallback('t1ger_deliveryjob:getTakenCompanies',function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ownedCompanies = {}
    MySQL.Async.fetchAll("SELECT * FROM t1ger_deliveryjob",{}, function(data)
        for k,v in pairs(data) do
            table.insert(ownedCompanies,{id = v.companyID, name = v.name})
        end
        cb(ownedCompanies)
    end)
end)

-- Purchase Company:
ESX.RegisterServerCallback('t1ger_deliveryjob:buyCompany',function(source, cb, id, val, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = 0
    if Config.PayCompanyWithCash then
        money = xPlayer.getMoney()
    else
        money = xPlayer.getAccount('bank').money
    end
	if money >= val.price then
		if Config.PayCompanyWithCash then
			xPlayer.removeMoney(val.price)
		else
			xPlayer.removeAccountMoney('bank', val.price)
		end
        MySQL.Sync.execute("INSERT INTO t1ger_deliveryjob (identifier, companyID, name) VALUES (@identifier, @companyID, @name)", {['identifier'] = xPlayer.identifier, ['companyID'] = id, ['name'] = name})
        cb(true)
    else
        cb(false)
    end
end)

-- Sell Company:
ESX.RegisterServerCallback('t1ger_deliveryjob:sellCompany',function(source, cb, id, val, sellPrice)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT companyID FROM t1ger_deliveryjob WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
        if data[1].companyID ~= nil then 
            if data[1].companyID == id then
                MySQL.Async.execute("DELETE FROM t1ger_deliveryjob WHERE companyID=@companyID", {['@companyID'] = id}) 
                if Config.ReciveSoldCompanyCash then
                    xPlayer.addMoney(sellPrice)
                else
                    xPlayer.addAccountMoney('bank',sellPrice)
                end
                cb(true)
            else
                cb(false)
        end
    end
    end)
end)

-- Reanme Company:
ESX.RegisterServerCallback('t1ger_deliveryjob:renameCompany',function(source, cb, id, val, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT companyID FROM t1ger_deliveryjob WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
        if data[1].companyID ~= nil then 
            if data[1].companyID == id then
                MySQL.Sync.execute("UPDATE t1ger_deliveryjob SET name = @name WHERE companyID = @companyID", {
                    ['@name'] = name,
                    ['@companyID'] = id
                })
                cb(true)
            else
                cb(false)
            end
        end
    end)
end)

-- Purchase Certificate:
ESX.RegisterServerCallback('t1ger_deliveryjob:buyCertifcate',function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local certificate = nil
    local certificatePrice = Config.CertificatePrice
    MySQL.Async.fetchAll("SELECT * FROM t1ger_deliveryjob WHERE identifier = @identifier AND companyID = @companyID", {
        ['@identifier'] = xPlayer.identifier,
        ['@companyID'] = id
    }, function(data)
        if data[1] ~= nil then 
            if data[1].companyID == id then
                if data[1].certificate == 0 then
                    local money = 0
                    if Config.PayCompanyWithCash then
                        money = xPlayer.getMoney()
                    else
                        money = xPlayer.getAccount('bank').money
                    end
                    if money >= certificatePrice then
                        if Config.PayCompanyWithCash then
                            xPlayer.removeMoney(certificatePrice)
                        else
                            xPlayer.removeAccountMoney('bank', certificatePrice)
                        end
                        MySQL.Sync.execute("UPDATE t1ger_deliveryjob SET certificate = @certificate WHERE companyID = @companyID", {
                            ['@certificate'] = 1,
                            ['@companyID'] = id
                        })
                        cb(true)
                    else
                        cb(false)
                    end
                else
                    cb(1)
                end
            else
                cb(nil)
            end
        end
    end)
end)

ESX.RegisterServerCallback('t1ger_deliveryjob:vehDepositFee',function(source, cb, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local plyMoney = 0
    if Config.DepositInCash then 
        plyMoney = xPlayer.getMoney() 
    else
        plyMoney = xPlayer.getAccount("bank").money
    end
    if plyMoney >= amount then
        if Config.DepositInCash then 
            xPlayer.removeMoney(amount)
            Wait(250)
            plyMoney = xPlayer.getMoney() 
        else
            xPlayer.removeAccountMoney("bank", amount)
        end
        cb(true)
    else
        cb(false)
    end
end)

-- Add reward:
RegisterServerEvent('t1ger_deliveryjob:retrievePaycheck')
AddEventHandler('t1ger_deliveryjob:retrievePaycheck', function(paycheck, vehDeposit, giveDeposit)
    local xPlayer = ESX.GetPlayerFromId(source)
    if giveDeposit then
        xPlayer.addMoney(vehDeposit)
        TriggerClientEvent('t1ger_deliveryjob:ShowNotifyESX', xPlayer.source, (Lang['deposit_returned']:format(vehDeposit)))
    end
    if CheckJobLimit(xPlayer.source, paycheck) == true then
		xPlayer.addMoney(paycheck)
        TriggerClientEvent('esx_xp:Add', source, 2500)
	elseif CheckJobLimit(xPlayer.source,paycheck) == false then
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Günlük limitine ulaştın!', length = 2500})
		return
    TriggerClientEvent('t1ger_deliveryjob:ShowNotifyESX', xPlayer.source, (Lang['paycheck_received']:format(paycheck)))
    end
    MySQL.Async.fetchAll("SELECT level FROM t1ger_deliveryjob WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
        if data[1].level ~= nil then 
            MySQL.Sync.execute("UPDATE t1ger_deliveryjob SET level = @level WHERE identifier = @identifier", {
                ['@level'] = data[1].level + Config.AddLevelAmount,
                ['@identifier'] = xPlayer.identifier
            })
        end
    end)
end)

-- Orders from T1GER_Shops
local orders = {}
RegisterServerEvent('t1ger_deliveryJob:sendOrderSV')
AddEventHandler('t1ger_deliveryJob:sendOrderSV', function(orderData)
    table.insert(orders, {data = orderData, taken = false})
end)

ESX.RegisterServerCallback('t1ger_deliveryjob:fetchShopOrders',function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.T1GER_Shops then
        cb(orders)
    end
end)

RegisterServerEvent('t1ger_deliveryJob:updateOrderState')
AddEventHandler('t1ger_deliveryJob:updateOrderState', function(orderData, state)
    if #orders > 0 then
        for k,v in pairs(orders) do
            if orderData.data.orderItem == v.data.orderItem and orderData.data.shopID == v.data.shopID then
                if orderData.data.itemPrice == v.data.itemPrice then
                    v.taken = true
                end
            end
        end
    end
end)

RegisterServerEvent('t1ger_deliveryJob:orderDeliveryDone')
AddEventHandler('t1ger_deliveryJob:orderDeliveryDone', function(orderData)
    local tableUpdated = false
    if #orders > 0 then
        for k,v in pairs(orders) do
            if orderData.data.orderItem == v.data.orderItem and orderData.data.shopID == v.data.shopID then
                if orderData.data.itemPrice == v.data.itemPrice then
                    table.remove(orders, k)
                    tableUpdated = true
                end
            end 
        end
        while not tableUpdated do Wait(5) end
        if tableUpdated then
            TriggerEvent('t1ger_shops:addOrderToStock', orderData) 
        end
    end
end)

ESX.RegisterServerCallback('t1ger_deliveryjob:getCompanyData', function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT * FROM t1ger_deliveryjob WHERE identifier = @identifier AND companyID = @companyID", {
        ['@identifier'] = xPlayer.identifier,
        ['@companyID'] = id
        }, function (data)
                --print(data[1].level,data[1].certificate)
                if data[1].companyID ~= nil then
                    if data == 0 then
                        cb(nil)
                    else
                        cb(data[1].level,data[1].certificate)
                    end
                end
        end)
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