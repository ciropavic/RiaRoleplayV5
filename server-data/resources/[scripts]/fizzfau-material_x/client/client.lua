ESX = nil 
pressed = false
started = false
sureBasladi = false
send = false
sure = 0
itemSure = 0
alinabilir = true
locked = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	Awake()
end)

Citizen.CreateThread(function()
	while true do
		sleep = 2500
		if gametime then
			local ped = PlayerPedId()
			local plyCoords = GetEntityCoords(ped)
			for k,v in pairs(fizzfau.DrawText.coords) do
				local dst = GetDistanceBetweenCoords(v.x, v.y, v.z, plyCoords, true)
				if dst < fizzfau.DrawText.Draw then
					if alinabilir then
						sleep = 0
						DrawMarker(fizzfau.DrawText.Type, v.x, v.y, v.z - 0.95, 0, 0.50, 0, 0, 0, 0, 1.5,1.5,1.5, 255, 0, 0, 255, 0.0, 0.10, 0, 0.0, 0, 0.0, 0)
						--DrawText3Ds(v.x, v.y, v.z, fizzfau.DrawText.scale.x, fizzfau.DrawText.scale.y,  fizzfau.DrawText.text)
						if dst < 1.5 then
							SetTime()
							sureBasladi = true
							yakin = true
						else
							itemSure = 0
						end
					else
						sleep = 0
						DrawText3Ds(v.x, v.y, v.z, fizzfau.DrawText.scale.x, fizzfau.DrawText.scale.y,  "Madde alınmış!")
					end
				else
					yakin = false
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
		sleep = 1000
		if alinabilir and gametime then
			if sureBasladi then
				if yakin then
					if sure > 0 then
						sleep = 60000
						if itemSure ~= 0 then
							exports.mythic_notify:SendAlert("error", "Geri Sayım Başladı: " .. sure .. " Dakika Bekle")
							itemSure = itemSure - 1000
							sure = sure - 1
							if sure == 0 then
								Citizen.Wait(1000)
								exports.mythic_notify:SendAlert("error", "Geri Sayım Bitti - Malzeme Hazır")
							end
						end
					elseif sure == 0 and sureBasladi then
						sleep = 0
						if not pressed and yakin then
							sleep = 0
							for k,v in pairs(fizzfau.DrawText.coords) do
								DrawText3Ds(v.x, v.y, v.z, fizzfau.DrawText.scale.x, fizzfau.DrawText.scale.y,  "[E] ile maddeyi topla!")
							end
							if IsControlJustPressed(0, 46) then
								TriggerServerEvent('fizzfau-playroom:reward', fizzfau.Rewards.item.name, fizzfau.Rewards.item.count)
								TriggerServerEvent('fizzfau-playroom:alinamaz')
								if fizzfau.Rewards.money ~= 0 or fizzfau.Rewards.money ~= nil then
									TriggerServerEvent('fizzfau-playroom:addMoney', fizzfau.Rewards.money)
								end
								pressed = true
							end
						end
					else
						sleep = 1000
					end
				else
					sleep = 1000
					sureBasladi = false
					exports.mythic_notify:SendAlert('error', 'Uzaklaştın!')
					SetTime()
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

--[[
Citizen.CreateThread(function()
	while true do
		ESX.TriggerServerCallback('fizzfau-playroom:GetClock', function(data)
			if (tonumber(data[1]) >= tonumber(fizzfau.Clock.Start.hour) and tonumber(data[1]) < tonumber(fizzfau.Clock.Finish.hour)) then
				gametime = true
			else
				gametime = false
			end
		end)
		Citizen.Wait(60000)
	end
end)
--]]

function Awake()
	for k,v in pairs(fizzfau.Blip.coords) do
		local radius = AddBlipForRadius(v.coord, v.radius)
		local blip = AddBlipForCoord(v.coord)	
		SetBlipSprite (blip, v.sprite)
		SetBlipScale  (blip, v.scale)
		SetBlipColour (blip, v.color)
		SetBlipColour (radius, v.rcolor)
		SetBlipAlpha(radius, v.ralpha)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(v.name)
		EndTextCommandSetBlipName(blip)
	end
end


function DrawText3Ds(x,y,z, sx, sy, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(sx, sy)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 400
	DrawRect(_x,_y+0.0125, 0.0002+ factor, 0.025, 0, 0, 0, 50)
end

function SetTime()
	if not sureBasladi then
		itemSure = 1000 * 15 * 60
		sure = 15
	end
end

RegisterNetEvent('fizzfau-playroom:alinamaz')
AddEventHandler('fizzfau-playroom:alinamaz', function()
	alinabilir = false
end)

RegisterNetEvent('fizzfau-playroom:alinabilir')
AddEventHandler('fizzfau-playroom:alinabilir', function()
	pressed = false
	started = false
	sureBasladi = false
	send = false
	sure = 0
	itemSure = 0
	alinabilir = true
	send = false
end)
