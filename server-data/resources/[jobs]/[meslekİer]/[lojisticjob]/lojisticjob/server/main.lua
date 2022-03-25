ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'lojistic', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'lojistic', _U('lojistic_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'lojistic', 'lojistic', 'society_lojistic', 'society_lojistic', 'society_lojistic', {type = 'private'})



RegisterServerEvent('esx_lojisticjob:getStockItem')
AddEventHandler('esx_lojisticjob:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lojistic', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_lojisticjob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lojistic', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('esx_lojisticjob:putStockItems')
AddEventHandler('esx_lojisticjob:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lojistic', function(inventory)

    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

  end)

end)


RegisterServerEvent('esx_lojisticjob:getFridgeStockItem')
AddEventHandler('esx_lojisticjob:getFridgeStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lojistic_fridge', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_lojisticjob:getFridgeStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lojistic_fridge', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('Announceuniouv')
AddEventHandler('Announceuniouv', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'lojistic', '~b~Ad lojistic', 'lojistic is open!', 'CHAR_ASHLEY', 8)
	end
end)

RegisterServerEvent('Announceunifer')
AddEventHandler('Announceunifer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'lojistic', '~b~Ad lojistic', 'lojistic is close !', 'CHAR_ASHLEY', 8)
	end
end)

RegisterServerEvent('esx_lojisticjob:putFridgeStockItems')
AddEventHandler('esx_lojisticjob:putFridgeStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lojistic_fridge', function(inventory)

    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

  end)

end)


RegisterServerEvent('esx_lojisticjob:buyItem')
AddEventHandler('esx_lojisticjob:buyItem', function(itemName, price, itemLabel)

    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local weight = xPlayer.getInventoryItem(itemName).weight
    local qtty = xPlayer.getInventoryItem(itemName).count
    local societyAccount = nil

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_lojistic', function(account)
        societyAccount = account
      end)
    
    if societyAccount ~= nil and societyAccount.money >= price then
        if qtty <= weight then
            societyAccount.removeMoney(price)
            xPlayer.addInventoryItem(itemName, 1)
            TriggerClientEvent('esx:showNotification', _source, _U('bought') .. itemLabel)
        else
            TriggerClientEvent('esx:showNotification', _source, _U('max_item'))
        end
    else
        TriggerClientEvent('esx:showNotification', _source, _U('not_enough'))
    end

end)


RegisterServerEvent('esx_lojisticjob:craftingCoktails')
AddEventHandler('esx_lojisticjob:craftingCoktails', function(itemValue)

    local _source = source
    local _itemValue = itemValue
    TriggerClientEvent('esx:showNotification', _source, _U('assembling_cocktail'))

    if _itemValue == 'WEAPON_PISTOL' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local pistolkabza    = xPlayer.getInventoryItem('pistolkabza').count
            local pistolmandal      = xPlayer.getInventoryItem('pistolmandal').count
            local pistolmekanizma     = xPlayer.getInventoryItem('pistolmekanizma').count
            local pistolyay     = xPlayer.getInventoryItem('pistolyay').count

            if pistolkabza < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('pistolkabza') .. '~w~')
            elseif pistolmandal < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('pistolmandal') .. '~w~')
            elseif pistolmekanizma < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('pistolmekanizma') .. '~w~')
            elseif pistolyay < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('pistolyay') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('pistolkabza', 1)
                    xPlayer.removeInventoryItem('pistolmandal', 1)
                    xPlayer.removeInventoryItem('pistolmekanizma', 1)
                    xPlayer.removeInventoryItem('pistolyay', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('WEAPON_PISTOL') .. ' ~w~!')
                    xPlayer.removeInventoryItem('pistolkabza', 1)
                    xPlayer.removeInventoryItem('pistolmandal', 1)
                    xPlayer.removeInventoryItem('pistolmekanizma', 1)
                    xPlayer.removeInventoryItem('pistolyay', 1)
                    xPlayer.addInventoryItem('WEAPON_PISTOL', 1)
                end
            end

        end)
    end

    if _itemValue == 'WEAPON_PUMPSHOTGUN' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local shotgunkabza   = xPlayer.getInventoryItem('shotgunkabza').count
            local shotgunmekanizma     = xPlayer.getInventoryItem('shotgunmekanizma').count
            local shotgunyay    = xPlayer.getInventoryItem('shotgunyay').count
            local shotgunmandal   = xPlayer.getInventoryItem('shotgunmandal').count

            if shotgunkabza < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('shotgunkabza') .. '~w~')
            elseif shotgunmekanizma < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('shotgunmekanizma') .. '~w~')
            elseif shotgunyay < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('shotgunyay') .. '~w~')
            elseif shotgunmandal < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('shotgunmandal') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('shotgunkabza', 1)
                    xPlayer.removeInventoryItem('shotgunmekanizma', 1)
                    xPlayer.removeInventoryItem('shotgunyay', 1)
                    xPlayer.removeInventoryItem('shotgunmandal', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('WEAPON_PUMPSHOTGUN') .. ' ~w~!')
                    xPlayer.removeInventoryItem('shotgunkabza', 1)
                    xPlayer.removeInventoryItem('shotgunmekanizma', 1)
                    xPlayer.removeInventoryItem('shotgunyay', 1)
                    xPlayer.removeInventoryItem('shotgunmandal', 1)
                    xPlayer.addInventoryItem('WEAPON_PUMPSHOTGUN', 1)
                end
            end

        end)
    end
    
    if _itemValue == 'WEAPON_MINISMG' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local hafifmakinalikabza     = xPlayer.getInventoryItem('hafifmakinalikabza').count
            local hafifmakinalimandal      = xPlayer.getInventoryItem('hafifmakinalimandal').count
            local hafifmakinalimekanizma     = xPlayer.getInventoryItem('hafifmakinalimekanizma').count
            local hafifmakinaliyay   = xPlayer.getInventoryItem('hafifmakinaliyay').count
            if hafifmakinalikabza < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('hafifmakinalikabza') .. '~w~')
            elseif hafifmakinalimandal < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('hafifmakinalimandal') .. '~w~')
            elseif hafifmakinalimekanizma < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('hafifmakinalimekanizma') .. '~w~')
            elseif hafifmakinaliyay < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('hafifmakinaliyay') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('hafifmakinalikabza', 1)
                    xPlayer.removeInventoryItem('hafifmakinalimandal', 1)
                    xPlayer.removeInventoryItem('hafifmakinalimekanizma', 1)
                    xPlayer.removeInventoryItem('hafifmakinaliyay', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('WEAPON_MINISMG') .. ' ~w~!')
                    xPlayer.removeInventoryItem('hafifmakinalikabza', 1)
                    xPlayer.removeInventoryItem('hafifmakinalimandal', 1)
                    xPlayer.removeInventoryItem('hafifmakinalimekanizma', 1)
                    xPlayer.removeInventoryItem('hafifmakinaliyay', 1)
                    xPlayer.addInventoryItem('WEAPON_MINISMG', 1)
                end
            end

        end)
    end

    if _itemValue == 'WEAPON_ADVANCEDRIFLE' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local aryay     = xPlayer.getInventoryItem('aryay').count
            local arkabza      = xPlayer.getInventoryItem('arkabza').count
            local armandal     = xPlayer.getInventoryItem('armandal').count
            local armekanizma      = xPlayer.getInventoryItem('armekanizma').count

            if aryay < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('aryay') .. '~w~')
            elseif arkabza < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('arkabza') .. '~w~')
            elseif armandal < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('armandal') .. '~w~')
            elseif armekanizma < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('armekanizma') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('aryay', 1)
                    xPlayer.removeInventoryItem('arkabza', 1)
                    xPlayer.removeInventoryItem('armandal', 1)
                    xPlayer.removeInventoryItem('armekanizma', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('rhumcoca') .. ' ~w~!')
                    xPlayer.removeInventoryItem('aryay', 1)
                    xPlayer.removeInventoryItem('arkabza', 1)
                    xPlayer.removeInventoryItem('armandal', 1)
                    xPlayer.removeInventoryItem('armekanizma', 1)
                    xPlayer.addInventoryItem('WEAPON_ADVANCEDRIFLE', 1)
                end
            end

        end)
    end

    if _itemValue == 'vodkaenergy' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('energy').count
            local bethQuantity      = xPlayer.getInventoryItem('vodka').count
            local gimelQuantity     = xPlayer.getInventoryItem('ice').count

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('energy') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vodka') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('ice') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('energy', 2)
                    xPlayer.removeInventoryItem('vodka', 2)
                    xPlayer.removeInventoryItem('ice', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('vodkaenergy') .. ' ~w~!')
                    xPlayer.removeInventoryItem('energy', 2)
                    xPlayer.removeInventoryItem('vodka', 2)
                    xPlayer.removeInventoryItem('ice', 1)
                    xPlayer.addInventoryItem('vodkaenergy', 1)
                end
            end

        end)
    end

    if _itemValue == 'vodkafruit' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('jusfruit').count
            local bethQuantity      = xPlayer.getInventoryItem('vodka').count
            local gimelQuantity     = xPlayer.getInventoryItem('ice').count

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('jusfruit') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vodka') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('ice') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('jusfruit', 2)
                    xPlayer.removeInventoryItem('vodka', 2)
                    xPlayer.removeInventoryItem('ice', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('vodkafruit') .. ' ~w~!')
                    xPlayer.removeInventoryItem('jusfruit', 2)
                    xPlayer.removeInventoryItem('vodka', 2)
                    xPlayer.removeInventoryItem('ice', 1)
                    xPlayer.addInventoryItem('vodkafruit', 1) 
                end
            end

        end)
    end

    if _itemValue == 'rhumfruit' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('jusfruit').count
            local bethQuantity      = xPlayer.getInventoryItem('rhum').count
            local gimelQuantity     = xPlayer.getInventoryItem('ice').count

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('jusfruit') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('rhum') .. '~w~')
            elseif gimelQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('ice') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('jusfruit', 2)
                    xPlayer.removeInventoryItem('rhum', 2)
                    xPlayer.removeInventoryItem('ice', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('rhumfruit') .. ' ~w~!')
                    xPlayer.removeInventoryItem('jusfruit', 2)
                    xPlayer.removeInventoryItem('rhum', 2)
                    xPlayer.removeInventoryItem('ice', 1)
                    xPlayer.addInventoryItem('rhumfruit', 1)
                end
            end

        end)
    end

    if _itemValue == 'teqpaf' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('limonade').count
            local bethQuantity      = xPlayer.getInventoryItem('tequila').count

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('limonade') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tequila') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('limonade', 2)
                    xPlayer.removeInventoryItem('tequila', 2)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('teqpaf') .. ' ~w~!')
                    xPlayer.removeInventoryItem('limonade', 2)
                    xPlayer.removeInventoryItem('tequila', 2)
                    xPlayer.addInventoryItem('teqpaf', 1)
                end
            end

        end)
    end

    if _itemValue == 'mojito' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('rhum').count
            local bethQuantity      = xPlayer.getInventoryItem('limonade').count
            local gimelQuantity     = xPlayer.getInventoryItem('menthe').count
            local daletQuantity      = xPlayer.getInventoryItem('ice').count

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('rhum') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('limonade') .. '~w~')
            elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('menthe') .. '~w~')
            elseif daletQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('ice') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('rhum', 2)
                    xPlayer.removeInventoryItem('limonade', 2)
                    xPlayer.removeInventoryItem('menthe', 2)
                    xPlayer.removeInventoryItem('ice', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('mojito') .. ' ~w~!')
                    xPlayer.removeInventoryItem('rhum', 2)
                    xPlayer.removeInventoryItem('limonade', 2)
                    xPlayer.removeInventoryItem('menthe', 2)
                    xPlayer.removeInventoryItem('ice', 1)
                    xPlayer.addInventoryItem('WEAPON_PISTOL', 1)
                end
            end

        end)
    end

    if _itemValue == 'mixapero' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('bolcacahuetes').count
            local bethQuantity      = xPlayer.getInventoryItem('bolnoixcajou').count
            local gimelQuantity     = xPlayer.getInventoryItem('bolpistache').count
            local daletQuantity     = xPlayer.getInventoryItem('bolchips').count

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bolcacahuetes') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bolnoixcajou') .. '~w~')
            elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bolpistache') .. '~w~')
            elseif daletQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bolchips') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('bolcacahuetes', 2)
                    xPlayer.removeInventoryItem('bolnoixcajou', 2)
                    xPlayer.removeInventoryItem('bolpistache', 2)
                    xPlayer.removeInventoryItem('bolchips', 1)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('mixapero') .. ' ~w~!')
                    xPlayer.removeInventoryItem('bolcacahuetes', 2)
                    xPlayer.removeInventoryItem('bolnoixcajou', 2)
                    xPlayer.removeInventoryItem('bolpistache', 2)
                    xPlayer.removeInventoryItem('bolchips', 2)
                    xPlayer.addInventoryItem('mixapero', 1)
                end
            end

        end)
    end

    if _itemValue == 'metreshooter' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('jager').count
            local bethQuantity      = xPlayer.getInventoryItem('vodka').count
            local gimelQuantity     = xPlayer.getInventoryItem('whisky').count
            local daletQuantity     = xPlayer.getInventoryItem('tequila').count

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('jager') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vodka') .. '~w~')
            elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('whisky') .. '~w~')
            elseif daletQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tequila') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('jager', 2)
                    xPlayer.removeInventoryItem('vodka', 2)
                    xPlayer.removeInventoryItem('whisky', 2)
                    xPlayer.removeInventoryItem('tequila', 2)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('metreshooter') .. ' ~w~!')
                    xPlayer.removeInventoryItem('jager', 2)
                    xPlayer.removeInventoryItem('vodka', 2)
                    xPlayer.removeInventoryItem('whisky', 2)
                    xPlayer.removeInventoryItem('tequila', 2)
                    xPlayer.addInventoryItem('metreshooter', 1)
                end
            end

        end)
    end

    if _itemValue == 'jagercerbere' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('jagerbomb').count
            local bethQuantity      = xPlayer.getInventoryItem('vodka').count
            local gimelQuantity     = xPlayer.getInventoryItem('tequila').count

            if alephQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('jagerbomb') .. '~w~')
            elseif bethQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('vodka') .. '~w~')
            elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('tequila') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('jagerbomb', 1)
                    xPlayer.removeInventoryItem('vodka', 2)
                    xPlayer.removeInventoryItem('tequila', 2)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('jagercerbere') .. ' ~w~!')
                    xPlayer.removeInventoryItem('jagerbomb', 1)
                    xPlayer.removeInventoryItem('vodka', 2)
                    xPlayer.removeInventoryItem('tequila', 2)
                    xPlayer.addInventoryItem('jagercerbere', 1)
                end
            end

        end)
    end

end)


ESX.RegisterServerCallback('esx_lojisticjob:getVaultWeapons', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_lojistic', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_lojisticjob:addVaultWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeWeapon(weaponName)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_lojistic', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = weapons[i].count + 1
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 1
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('esx_lojisticjob:removeVaultWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addWeapon(weaponName, 1000)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_lojistic', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 0
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('esx_lojisticjob:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)
