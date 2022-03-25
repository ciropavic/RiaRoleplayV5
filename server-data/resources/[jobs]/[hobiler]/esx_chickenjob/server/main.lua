local maxZywych = 15   -- ile mozna miec max zywych kurczkaow w EQ
local MaxMartweKurczaki = 30   -- ile mozna miec martwych kurczakow w EQ
local MaxZapakowanychKurczakow = 30    --ile mozna miec w EQ zapakowanych kurczakow
local GotowkaSprzedaz = 125   --ilosc hajsu za 2 paczki kurczaka

local limit = 50000


-----------------------------
---nizej lepiej nie ruszaj---
-----------------------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('tost:wkladajKurczki')
AddEventHandler('tost:wkladajKurczki', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local zywyKurczak = xPlayer.getInventoryItem('alive_chicken').count

if zywyKurczak < maxZywych then
xPlayer.addInventoryItem('alive_chicken', 5)
Wait(1500)
else
TriggerClientEvent('esx:showNotification', source, '~y~You can only carry one at a time ~g~'..maxZywych.. '~y~ chickens.')
Wait(2500)
end
end)

RegisterServerEvent('tostKurczaki:przerob')
AddEventHandler('tostKurczaki:przerob', function(opcja)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local zywyKurczak = xPlayer.getInventoryItem('alive_chicken').count
local MartwyKurczak = xPlayer.getInventoryItem('slaughtered_chicken').count
local ZapakowanyKurczak = xPlayer.getInventoryItem('packaged_chicken').count

if opcja == 1 then
	if zywyKurczak > 0 and MartwyKurczak < MaxMartweKurczaki then
	xPlayer.removeInventoryItem('alive_chicken', 1)
	xPlayer.addInventoryItem('slaughtered_chicken', 2)
	Wait(1500)
	else
	TriggerClientEvent('esx:showNotification', source, '~y~You can only carry one at a time ~g~'..MaxMartweKurczaki.. '~y~ dead chickens.')
	Wait(2500)
	end
end

if opcja == 2 then
	if MartwyKurczak > 0 and ZapakowanyKurczak < MaxZapakowanychKurczakow then
	xPlayer.removeInventoryItem('slaughtered_chicken', 2)
	xPlayer.addInventoryItem('packaged_chicken', 2)
	Wait(1500)
	else
	TriggerClientEvent('esx:showNotification', source, '~y~You can only carry one at a time. ~g~'..MaxMartweKurczaki.. '~y~ dead chickens.')
	Wait(2500)
	end
end

if opcja == 3 then
	if ZapakowanyKurczak > 0 then
	xPlayer.removeInventoryItem('packaged_chicken', 1)
	if CheckJobLimit(_source, GotowkaSprzedaz) == true then
		xPlayer.addMoney(GotowkaSprzedaz)
		TriggerClientEvent('esx_xp:Add', _source, 2500)
	elseif CheckJobLimit(_source,GotowkaSprzedaz) == false then
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Günlük limitine ulaştın! Yarın mesaiye devam et şimdi dinlenme vakti...', length = 2500})
		xPlayer.addInventoryItem('slaughtered_chicken', 1)
		return
	else
	TriggerClientEvent('esx:showNotification', source, '~g~You are getting ~y~'..GotowkaSprzedaz.. '$ ~g~for two chickens.')
	Wait(1500)
	end
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