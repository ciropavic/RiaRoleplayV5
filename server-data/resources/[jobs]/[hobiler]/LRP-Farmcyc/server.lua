ESX = nil
local limit = 50000

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent("Farmcyc:recoleccion")
AddEventHandler("Farmcyc:recoleccion", function()

    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	local recoleccionsuerte = math.random(1,100)
	local cangrejos = xPlayer.getInventoryItem('cangrejos').count	
	local camarones = xPlayer.getInventoryItem('camarones').count	

         if recoleccionsuerte < 50 then

         	   if xPlayer.getInventoryItem('cangrejos').count >= 20 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Daha fazla yengeç alamazsın', length = 2500})
else 

         	xPlayer.addInventoryItem("cangrejos", math.random(1,5)) 
         
              end

         elseif recoleccionsuerte > 51 then 
         	
         	if xPlayer.getInventoryItem('camarones').count >= 20 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Daha fazla karides alamazsın', length = 2500})
else 

            xPlayer.addInventoryItem("camarones", math.random(1,5)) 
        end

            end 
		
end)




ESX.RegisterServerCallback('Farmcyc:empaquetado:cangrejos', function (source, cb)
	
	local _source = source
	
	local xPlayer  = ESX.GetPlayerFromId(_source)
			
			if xPlayer.getInventoryItem('cajadecangrejos').count >= 4 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Daha fazla sandık tasıyamazsın', length = 2500})

else

				if xPlayer.getInventoryItem('cangrejos').count >= 5 then


 
					xPlayer.removeInventoryItem('cangrejos', 4) 
					Citizen.Wait(1000)
					xPlayer.addInventoryItem('cajadecangrejos', 1) 

					cb(true)

				else
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yengeçlerin yeterli değil', length = 2500})
				cb(false)
				end
			
      		end

end)

ESX.RegisterServerCallback('Farmcyc:empaquetado:camarones', function (source, cb)
	
	local _source = source
	
	local xPlayer  = ESX.GetPlayerFromId(_source)
			
			if xPlayer.getInventoryItem('cajadecamarones').count >= 5 then
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Daha fazla sandık tasıyamazsın', length = 2500})

else

				if xPlayer.getInventoryItem('camarones').count >= 4 then


 
					xPlayer.removeInventoryItem('camarones', 4) 
					Citizen.Wait(1000)
					xPlayer.addInventoryItem('cajadecamarones', 1) 

					cb(true)

				else
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Karidesiniz yok', length = 2500})
				cb(false)
				end
			
      		end

end)

RegisterNetEvent('Ventadecamarones')
AddEventHandler('Ventadecamarones', function()
	local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local camarones = xPlayer.getInventoryItem('cajadecamarones').count
    local PrecioCamarones = Config.PCamaron
   
if camarones > 0 then
    xPlayer.removeInventoryItem('cajadecamarones', 1)
	if CheckJobLimit(_source, PrecioCamarones) == true then
		xPlayer.addMoney(PrecioCamarones)
		TriggerClientEvent('esx_xp:Add', _source, 2500)
	elseif CheckJobLimit(_source,PrecioCamarones) == false then
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Günlük limitine ulaştın!', length = 2500})
		xPlayer.addInventoryItem('cajadecamarones', 1)
		return
elseif camarones < 1 then
	TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Satacak karidesiniz yok', length = 2500})

end
end

end)



RegisterNetEvent('Ventadecangrejos')
AddEventHandler('Ventadecangrejos', function()
	local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local cangrejos = xPlayer.getInventoryItem('cajadecangrejos').count
    local PrecioCangrejos = Config.PCangrejo

if cangrejos > 0 then


    xPlayer.removeInventoryItem('cajadecangrejos', 1)
	if CheckJobLimit(_source, PrecioCangrejos) == true then
		xPlayer.addMoney(PrecioCangrejos)
		TriggerClientEvent('esx_xp:Add', _source, 2500)
	elseif CheckJobLimit(_source,PrecioCangrejos) == false then
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Günlük limitine ulaştın!', length = 2500})
		xPlayer.addInventoryItem('cajadecangrejos', 1)
		return
elseif cangrejos < 1 then
	TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Satacak yengeçleriniz yok', length = 2500})
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