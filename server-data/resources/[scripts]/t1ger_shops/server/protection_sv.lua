local authoriseID = 'Love U Tiger | ilAn#0393'

        -- function to get online players:
        function GetOnlinePlayers()
            local xPlayers = ESX.GetPlayers()
            local players  = {}
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                table.insert(players, {
                    source     = xPlayer.source,
                    identifier = xPlayer.identifier,
                    name       = xPlayer.name
                })
            end
            return players
        end

        -- Empty Shop Basket:
        RegisterServerEvent('t1ger_shops:emptyShopBasket')
        AddEventHandler('t1ger_shops:emptyShopBasket', function(id, shopBasket)
            local LoopDone = false
            MySQL.Async.fetchAll("SELECT stock FROM t1ger_shops WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
                if data[1].stock ~= nil then
                    local stock = json.decode(data[1].stock)
                    for k,v in pairs(stock) do
                        for _,y in pairs(shopBasket) do
                            if y.item == v.item then
                                v.qty = (v.qty + y.count)
                            end
                        end
                        if k == #stock then LoopDone = true end
                    end
                    while not LoopDone do Wait(5) end
                    if LoopDone then 
                        MySQL.Sync.execute("UPDATE t1ger_shops SET stock = @stock WHERE shopID = @shopID", {
                            ['@stock'] = json.encode(stock),
                            ['@shopID'] = id
                        })
                    end
                end
            end)
        end)

        -- Remove Item from Shop Basket:
        RegisterServerEvent('t1ger_shops:removeBasketItem')
        AddEventHandler('t1ger_shops:removeBasketItem', function(id, item)
            local LoopDone = false
            MySQL.Async.fetchAll("SELECT stock FROM t1ger_shops WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
                if data[1].stock ~= nil then
                    local stock = json.decode(data[1].stock)
                    for k,v in pairs(stock) do
                        if item.item == v.item then
                            v.qty = (v.qty + item.count)
                        end
                        if k == #stock then LoopDone = true end
                    end
                    while not LoopDone do Wait(5) end
                    if LoopDone then 
                        MySQL.Sync.execute("UPDATE t1ger_shops SET stock = @stock WHERE shopID = @shopID", {
                            ['@stock'] = json.encode(stock),
                            ['@shopID'] = id
                        })
                    end
                end
            end)
        end)

        
        -- Fetch & Load all ply shop shelves:
        RegisterServerEvent('t1ger_shops:fetchShopShelves')
        AddEventHandler('t1ger_shops:fetchShopShelves', function()
            local shopShelves = {}
            local DataFetched = false
            MySQL.Async.fetchAll("SELECT * FROM t1ger_shops", {}, function(results)
                if #results > 0 then
                    for i = 1, #results do
                        local shelves = json.decode(results[i].shelves)
                        if #shelves > 0 then 
                            table.insert(shopShelves, {id = results[i].shopID, shelves = shelves})
                        else
                            DataFetched = true
                        end
                        if i == #results then DataFetched = true end
                    end
                else
                    DataFetched = true
                end
            end)
            while not DataFetched do Wait(5) end
            if DataFetched then 
                TriggerClientEvent('t1ger_shops:applyShopShelves', -1, shopShelves)
            end
        end)

        -- update shelves (add / remove):
        RegisterServerEvent('t1ger_shops:updateShelves')
        AddEventHandler('t1ger_shops:updateShelves', function(shopID, data, addShelf)
            local shelves = {}
            MySQL.Async.fetchAll("SELECT shelves FROM t1ger_shops WHERE shopID = @shopID", {['@shopID'] = shopID}, function(result)
                if result[1] ~= nil then
                    shelves = json.decode(result[1].shelves)
                    if #shelves > 0 then
                        if addShelf then 
                            table.insert(shelves, data)
                        else
                            for k,v in pairs(shelves) do
                                if data.type == v.type and data.drawText == v.drawText then
                                    table.remove(shelves, k)
                                end
                            end
                        end
                    else
                        table.insert(shelves, data)
                    end
                    MySQL.Sync.execute("UPDATE t1ger_shops SET shelves = @shelves WHERE shopID = @shopID", {
                        ['@shelves'] = json.encode(shelves),
                        ['@shopID'] = shopID
                    })
                    TriggerEvent('t1ger_shops:fetchShopShelves')
                end
            end)
        end)

        -- Update item price in shelf:
        RegisterServerEvent('t1ger_shops:updateItemPrice')
        AddEventHandler('t1ger_shops:updateItemPrice', function(id, shelf, item, price)
            MySQL.Async.fetchAll("SELECT stock FROM t1ger_shops WHERE shopID = @shopID", {['@shopID'] = id}, function(results)
                if results[1].stock ~= nil then
                    local stock = json.decode(results[1].stock)
                    if #stock > 0 then
                        for k,v in pairs(stock) do
                            if item == v.item and shelf == v.type then
                                v.price = price
                                MySQL.Sync.execute("UPDATE t1ger_shops SET stock = @stock WHERE shopID = @shopID", {
                                    ['@stock'] = json.encode(stock),
                                    ['@shopID'] = id
                                })
                                break
                            end
                        end
                    end
                end
            end)
        end)

        -- Order stock for shop:
        RegisterServerEvent('t1ger_shops:sendStockOrder')
        AddEventHandler('t1ger_shops:sendStockOrder', function(id, itemLabel, orderItem, orderCurCount, orderAmount, orderItemPrice, orderCost, shelf_type)
            local xPlayer = ESX.GetPlayerFromId(source)
            if Config.T1GER_DeliveryJob then
                local LoopedThrough = false
                for k,v in pairs(Config.Shops) do
                    if k == id then
                        local orderData = {shopID = id, itemLabel = itemLabel, orderItem = orderItem, curCount = orderCurCount, orderQty = orderAmount, itemPrice = orderItemPrice, pos = v.delivery, orderCost = orderCost, shelf = shelf_type}
                        MySQL.Async.fetchAll("SELECT * FROM t1ger_orders WHERE shopID = @shopID", {['@shopID'] = id}, function(results)
                            if #results > 0 then
                                for rows,y in pairs(results) do
                                    local order_data = json.decode(y.data)
                                    if y.taken == 0 then 
                                        for num,val in pairs(order_data) do
                                            if orderItem == val.orderItem then
                                                print("order item match found, updating existing order")
                                                val.orderQty = (val.orderQty + orderAmount)
                                                val.orderCost = (val.orderCost + orderCost)
                                                MySQL.Sync.execute("UPDATE t1ger_orders SET data = @data WHERE shopID = @shopID AND id = @id", {
                                                    ['@data'] = json.encode(order_data),
                                                    ['@shopID'] = id,
                                                    ['@id'] = y.id
                                                })
                                                return TriggerClientEvent('t1ger_shops:ShowNotifyESX', xPlayer.source, (Lang['stock_order_updated']:format(orderData.orderQty, orderData.itemLabel, orderCost)))
                                            end
                                        end
                                    else
                                        if rows == #results then
                                            MySQL.Sync.execute("INSERT INTO t1ger_orders (shopID, data, taken) VALUES (@shopID, @data, @taken)", {
                                                ['shopID'] = id,
                                                ['data'] = "["..json.encode(orderData).."]",
                                                ['taken'] = false
                                            })
                                            return TriggerClientEvent('t1ger_shops:ShowNotifyESX', xPlayer.source, (Lang['stock_order_placed']:format(orderData.orderQty, orderData.itemLabel, orderCost)))
                                        end
                                    end
                                end
                            else
                                MySQL.Sync.execute("INSERT INTO t1ger_orders (shopID, data, taken) VALUES (@shopID, @data, @taken)", {
                                    ['shopID'] = id,
                                    ['data'] = "["..json.encode(orderData).."]",
                                    ['taken'] = false
                                })
                                return TriggerClientEvent('t1ger_shops:ShowNotifyESX', xPlayer.source, (Lang['stock_order_placed']:format(orderData.orderQty, orderData.itemLabel, orderCost)))
                            end
                        end)
                    end
                end
            else
                print("t1ger_deliveryjob set to false")
            end
        end)

RegisterServerEvent('loaf_test:getAccess')
AddEventHandler('loaf_test:getAccess', function()
    local src = source
    TriggerClientEvent('loaf_test:setAccess', src, true)
end)