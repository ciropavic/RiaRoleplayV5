--#################################################################################--

-- First version done by rubylium then adapted for esx and finished by Ozne#4870

-- question or more scripts here : https://discord.gg/nx3TKM5

--#################################################################################--


ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('RubyMenu:getUsergroup', function(source, cb)
     local xPlayer = ESX.GetPlayerFromId(source)
     local group = xPlayer.getGroup()
     cb(group)
end)

platenum = math.random(00001, 99998)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local r = math.random(00001, 99998)
		platenum = r
	end
end)

function SendWebhookMessageMenuStaff(webhook,message)
	webhook = ""
	if webhook ~= "none" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterServerEvent("AdminMenu:StaffOnOff")
AddEventHandler("AdminMenu:StaffOnOff", function(status)

	local xPlayers	= ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
          local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          if status == true then
               TriggerClientEvent('chatMessage', xPlayers[i], '', {255, 0, 0}, "Bir personel moderasyon modundan yeni geçti : "..source..".")
               print(status)
          elseif status == false then
               TriggerClientEvent('chatMessage', xPlayers[i], '', {255, 0, 0}, "Bir personel moderasyon modundan yeni geçti : "..source..".")
               print(status)
		end
	end	
end)


RegisterServerEvent("logMenuAdmin")
AddEventHandler("logMenuAdmin", function(option)
	local date = os.date('*t')
	
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	name = GetPlayerName(source)
	SendWebhookMessageMenuStaff(webhook,"**Kullanılan Yönetici Menüsü** \n```diff\nOyuncular: "..name.."\nOyuncu Kimligi: "..source.." \nSecenek etkinlestirildi: "..option.."\n+ Tarih: " .. date.day .. "." .. date.month .. "." .. date.year .. " - " .. date.hour .. ":" .. date.min .. ":" .. date.sec .. "\n[Tespit #".. platenum .."].```")
end)


RegisterServerEvent("kickAllPlayer2")
AddEventHandler("kickAllPlayer2", function()
	local message = money
	print(message)
	local xPlayers	= ESX.GetPlayers()
	TriggerEvent('SavellPlayerAuto')
	Citizen.Wait(2000)
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		DropPlayer(xPlayers[i], 'Sunucuya Restart Atılıcaktır')
	end
	

end)


RegisterServerEvent("ReviveAll")
AddEventHandler("ReviveAll", function()
	name = GetPlayerName(source)
	local xPlayers	= ESX.GetPlayers()
	SendWebhookMessageMenuStaff(webhook,"**Bir personel herkesi canlandırdı** \n```diff\nOyuncular: "..name.."\nOyuncu Kimligi: "..source.." \n[Tespit #".. platenum .."].```")
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerEvent('esx_ambulancejob:revive', xPlayers[i])
		xPlayer.triggerEvent('esx_ambulancejob:revive')
	end
end)


RegisterServerEvent("tplklk")
AddEventHandler("tplklk", function (arg1, arg2, arg3)
	MySQL.Sync.execute('DELETE from communityservice', {})
end)



RegisterServerEvent("saksofon-dellobject")
AddEventHandler("saksofon-dellobject", function()
	TriggerClientEvent("wld:delallobject", -1)
end)

RegisterServerEvent("saksofon-dellpeds")
AddEventHandler("saksofon-dellpeds", function()
	TriggerClientEvent("wld:delallpeds", -1)
end)

RegisterServerEvent("saksofon-dellallveh")
AddEventHandler("saksofon-dellallveh", function()
	TriggerClientEvent("wld:delallveh", -1)
end)

RegisterServerEvent("spawnVehAll")
AddEventHandler("spawnVehAll", function()
	TriggerClientEvent("SpawnAllVeh", -1)
end)



