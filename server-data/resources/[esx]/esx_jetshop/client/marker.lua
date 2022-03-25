local HasAlreadyEnteredMarker = false
local LastZone                = nil

CurrentAction     = nil
CurrentActionMsg  = ''
CurrentActionData = {}

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'jet_shop' then
					if not Config.LicenseEnable then
						OpenjetShop(Config.Zones.jetShops[CurrentActionData.zoneNum])
					else -- check for license

						ESX.TriggerServerCallback('esx_license:checkLicense', function(hasjetLicense)
							if hasjetLicense then
								OpenjetShop(Config.Zones.jetShops[CurrentActionData.zoneNum])
							else
								OpenLicenceMenu(Config.Zones.jetShops[CurrentActionData.zoneNum])
							end
						end, GetPlayerServerId(PlayerId()), 'jet')
					end
				elseif CurrentAction == 'garage_out' then
					OpenjetGarage(Config.Zones.Garages[CurrentActionData.zoneNum])
				elseif CurrentAction == 'garage_in' then
					StorejetInGarage(CurrentActionData.vehicle, Config.Zones.Garages[CurrentActionData.zoneNum].StoreTP)
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('esx_jet:hasEnteredMarker', function(zone, zoneNum)
	if zone == 'jet_shop' then
		CurrentAction     = 'jet_shop'
		CurrentActionMsg  = _U('jet_shop_open')
		CurrentActionData = { zoneNum = zoneNum }
	elseif zone == 'garage_out' then
		CurrentAction     = 'garage_out'
		CurrentActionMsg  = _U('garage_open')
		CurrentActionData = { zoneNum = zoneNum }
	elseif zone == 'garage_in' then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
	
		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)
	
			if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
				CurrentAction     = 'garage_in'
				CurrentActionMsg  = _U('garage_store')
				CurrentActionData = { vehicle = vehicle, zoneNum = zoneNum }
			end
		end
	end
end)

AddEventHandler('esx_jet:hasExitedMarker', function()
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local isInMarker, hasExited, letSleep = false, false, true
		local currentZone, currentZoneNum

		for i=1, #Config.Zones.jetShops, 1 do
			local distance = GetDistanceBetweenCoords(coords, Config.Zones.jetShops[i].Outside, true)

			if distance < Config.DrawDistance then
				DrawMarker(Config.MarkerType, Config.Zones.jetShops[i].Outside, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, 100, false, true, 2, false, nil, nil, false)
				letSleep = false
			end

			if distance < Config.Marker.x then
				isInMarker     = true
				currentZone    = 'jet_shop'
				currentZoneNum = i
			end
		end

		for i=1, #Config.Zones.Garages, 1 do
			local distance = GetDistanceBetweenCoords(coords, Config.Zones.Garages[i].GaragePos, true)

			if distance < Config.DrawDistance then
				DrawMarker(Config.MarkerType, Config.Zones.Garages[i].GaragePos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, 100, false, true, 2, false, nil, nil, false)
				letSleep = false
			end

			if distance < Config.Marker.x then
				isInMarker     = true
				currentZone    = 'garage_out'
				currentZoneNum = i
			end

			distance = GetDistanceBetweenCoords(coords, Config.Zones.Garages[i].StorePos, true)

			if distance < Config.DrawDistance then
				DrawMarker(Config.MarkerType, Config.Zones.Garages[i].StorePos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.StoreMarker.x, Config.StoreMarker.y, Config.StoreMarker.z, Config.StoreMarker.r, Config.StoreMarker.g, Config.StoreMarker.b, 100, false, true, 2, false, nil, nil, false)
				letSleep = false
			end

			if distance < Config.StoreMarker.x then
				isInMarker     = true
				currentZone    = 'garage_in'
				currentZoneNum = i
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastZone ~= currentZone or LastZoneNum ~= currentZoneNum)) then
			if
				(LastZone ~= nil and LastZoneNum ~= nil) and
				(LastZone ~= currentZone or LastZoneNum ~= currentZoneNum)
			then
				TriggerEvent('esx_jet:hasExitedMarker', LastZone)
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			LastZoneNum = currentZoneNum

			TriggerEvent('esx_jet:hasEnteredMarker', currentZone, currentZoneNum)
		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_jet:hasExitedMarker')
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Blips
Citizen.CreateThread(function()
	local blipList = {}

	for i=1, #Config.Zones.Garages, 1 do
		table.insert(blipList, {
			coords = Config.Zones.Garages[i].GaragePos,
			text   = _U('blip_garage'),
			sprite = 372,
			color  = 0,
			scale  = 0.6
		})
	end

	for i=1, #Config.Zones.jetShops, 1 do
		table.insert(blipList, {
			coords = Config.Zones.jetShops[i].Outside,
			text   = _U('blip_shop'),
			sprite = 423,
			color  = 0,
			scale  = 0.6
		})
	end

	for i=1, #blipList, 1 do
		CreateBlip(blipList[i].coords, blipList[i].text, blipList[i].sprite, blipList[i].color, blipList[i].scale)
	end
end)

function CreateBlip(coords, text, sprite, color, scale)
	local blip = AddBlipForCoord(coords.x, coords.y)

	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)

	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
end
