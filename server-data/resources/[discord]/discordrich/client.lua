local WaitTime = 2500 -- How often do you want to update the status (In MS)

local DiscordAppId = "817357976234754059"
local DiscordAppAsset =  "riav"
local UseKMH = false
	
Citizen.CreateThread(function()
	SetDiscordAppId(DiscordAppId)
	SetDiscordRichPresenceAsset(DiscordAppAsset)
	while true do
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		Citizen.Wait(WaitTime)
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence(StreetName.." Caddesinde deli gibi koşuyor.")
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence(StreetName.. " Caddesinde koşuyor." )
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence(StreetName.." Caddesinde yürüyor ")
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence(StreetName.." Caddesinde ayakta bekliyor.")
				end
			elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				local VehSpeed = GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId()))
				local CurSpeed = UseKMH and math.ceil(VehSpeed * 3.6) or math.ceil(VehSpeed * 2.236936)
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if CurSpeed > 100 then
					SetRichPresence(StreetName.. " Caddesinde hız yapıyor "..VehName.. " içinde")
				elseif CurSpeed <= 100 and CurSpeed > 0 then
					SetRichPresence(StreetName.. " Caddesinde seyir halinde "..VehName.. " içinde")
				elseif CurSpeed == 0 then
					SetRichPresence(StreetName.. " Caddesinde park halinde bekliyor "..VehName.. " içinde")
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
					SetRichPresence(StreetName.. " Caddesinin üzerinden uçuş yapıyor "..VehName.. " içinde")
				else
					SetRichPresence(StreetName.. " Caddesine iniş yaptı. "..VehName.. " içinde bekliyor")
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence("Yüzüyor")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				SetRichPresence("Yelken açıyor "..VehName.." içinde")
			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("Submarinde takılıyor")
			end
		end
	end
end)
