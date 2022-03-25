ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sh1no-serveretkontrol')
AddEventHandler('sh1no-serveretkontrol', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("shx_stone").count >= 10 then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Daha fazla et taşıyamazsın!'})
    else
        if xPlayer.getInventoryItem('shx_stone').count > 0 then
        TriggerClientEvent("sh1no-tacoetkontrol", source)
        xPlayer.removeInventoryItem("stone", 1)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = "Et pişirmek için etin yok!"})
        end
    end
end)

RegisterServerEvent('sh1no-etlitaco')
AddEventHandler('sh1no-etlitaco', function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem("shx_taco").count >= 10 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Daha fazla taco taşıyamazsın!', 2, 6500})
        else 
            
        if xPlayer.getInventoryItem('shx_parmul').count > 0 and xPlayer.getInventoryItem('shx_salca').count > 0 and xPlayer.getInventoryItem('shx_mercan').count > 0 and xPlayer.getInventoryItem('shx_yosun').count > 0 then
            xPlayer.removeInventoryItem("shx_parmul", 1)
            xPlayer.removeInventoryItem("shx_salca", 1)
            xPlayer.removeInventoryItem("shx_mercan", 1)
            xPlayer.removeInventoryItem("shx_yosun", 1)
            xPlayer.addInventoryItem("shx_taco", 1)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Taco yapmak için yeterli malzemen yok!'})
        end
    end
  end
end)

RegisterServerEvent('sh1no-fishtacoyaptim')
AddEventHandler('sh1no-fishtacoyaptim', function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem("shx_fishtaco").count >= 10 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Daha fazla balıklı taco taşıyamazsın!'})
        else 
            
        if xPlayer.getInventoryItem('shx_parmul').count > 0 and xPlayer.getInventoryItem('shx_salca').count > 0 and xPlayer.getInventoryItem('shx_mercan').count > 0 then
            xPlayer.removeInventoryItem("shx_parmul", 1)
            xPlayer.removeInventoryItem("shx_salca", 1)
            xPlayer.removeInventoryItem("shx_mercan", 1)
            xPlayer.addInventoryItem("shx_fishtaco", 1)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Balıklı taco yapmak için yeterli malzemen yok!'})
        end
    end
  end
end)

RegisterServerEvent('sh1no-tacopaketledim')
AddEventHandler('sh1no-tacopaketledim', function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil then
        if xPlayer.getInventoryItem("shx_paketlenmistaco").count >= 10 then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Daha fazla paketlenmiş taco taşıyamazsın!'})
        else 
            
        if xPlayer.getInventoryItem('shx_fishtaco').count > 0 then
            xPlayer.removeInventoryItem("shx_fishtaco", 1)
            xPlayer.addInventoryItem("shx_paketlenmistaco", 1)
        else
            if xPlayer.getInventoryItem('shx_taco').count > 0 then
                xPlayer.removeInventoryItem("shx_taco", 1)
                xPlayer.addInventoryItem("shx_paketlenmistaco", 1)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Paketlemek için tacon yok!'})
            end
        end
    end
  end
end)

RegisterNetEvent('sh1no-parakontrol')
AddEventHandler('sh1no-parakontrol', function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 50) then
		xPlayer.removeMoney(50)

		TriggerClientEvent('sh1no-kontrolgecti', source) -- true
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Yeterli paran yok!'})
	end	
end)

RegisterServerEvent('sh1no-tacouyusturucukontrol')
AddEventHandler('sh1no-tacouyusturucukontrol', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem('shx_paketlenmistaco').count > 0 and xPlayer.getInventoryItem('1gr_roka').count > 0 then
        xPlayer.removeInventoryItem("1gr_roka", 1)
        xPlayer.removeInventoryItem("shx_paketlenmistaco", 1)
        xPlayer.addMoney(500)
        TriggerClientEvent('esx_xp:Add', source, 2500)
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text ="Teslimat başarılıydı, dükkana dönüp yeni iş al!"})
    else
        if xPlayer.getInventoryItem('shx_paketlenmistaco').count > 0 then
            xPlayer.removeInventoryItem("shx_paketlenmistaco", 1)
            xPlayer.addMoney(100)
            TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text ="Güzel yaptın, dükkana dönüp yeni iş al!"})
	else
        TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = "Paketlenmiş tacon yok!"})
        end
    end
end)