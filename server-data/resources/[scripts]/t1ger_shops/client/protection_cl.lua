local access = false

CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    TriggerServerEvent('loaf_test:getAccess')
    while not access do Wait(0) end
    
    plyEmployeeID = 0
    RegisterNetEvent('t1ger_shops:updateEmployeeID')
    AddEventHandler('t1ger_shops:updateEmployeeID', function(employeeID)
        plyEmployeeID = employeeID
    end)

    -- Function to empty basket:
    function EmptyShopBasket(reason)
        if reason ~= nil then
            TriggerServerEvent('t1ger_shops:emptyShopBasket', basket.shopID, basket.items)
            Citizen.Wait(200)
            ShowNotifyESX(reason)
        end
        basket.bill = 0
        basket.items = {}
        basket.shopID = 0
    end

    -- Check if item exists in basket:
    function IsItemInBasket(item)
        for i = 1, #basket.items do if item == basket.items[i].item then return true, i end end
        return false, nil
    end
end)

RegisterNetEvent('loaf_test:setAccess')
AddEventHandler('loaf_test:setAccess', function(res)
    access = res
end)