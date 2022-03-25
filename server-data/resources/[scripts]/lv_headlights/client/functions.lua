--[[ 
                 Headlight Menu - by BoutProduction
]]

function OpenHeadlightMenu()
    local elems = {
        {label = 'Menüyü Aç', value = 'open_list'},

}
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ColourMenu',{
        title = 'Araba Far Renkleri',
        align = 'top-left',
        elements = elems
    },
    function(data, menu)
        if data.current.value == 'open_list' then 
            ColourList()
        end

    end,
    function(data, menu)
        menu.close()
    end)
end

--[[
    All Colours
]]

function ColourList()
        local elems = {
            {label = 'Koyu Mavi', value = '1'},
            {label = 'Açık Mavi', value = '2'},
            {label = 'Turkuaz', value = '3'},
            {label = 'Yeşil', value = '4'},
            {label = 'Sarı', value = '5'},
            {label = 'Altın Rengi', value = '6'},
            {label = 'Turuncu', value = '7'},
            {label = 'Kırmızı', value = '8'},
            {label = 'Pembe', value = '9'},
            {label = 'Lila', value = '10'},
            {label = 'Mor', value = '11'},
            {label = 'Kapalı Lila', value = '12'},

        }
    
        ESX.UI.Menu.CloseAll()
    
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ColourMenu',{
            title = 'Araba Far Renkleri',
            align = 'top-left',
            elements = elems
        },
        function(data, menu)
            if data.current.value == '1' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleXenonLightsColour(veh, 1)
            end
            if data.current.value == '2' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleXenonLightsColour(veh, 2)
            end
            if data.current.value == '3' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleXenonLightsColour(veh, 3)
            end
            if data.current.value == '4' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleXenonLightsColour(veh, 4)
            end
            if data.current.value == '5' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleXenonLightsColour(veh, 5)
            end
            if data.current.value == '6' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleXenonLightsColour(veh, 6)
            end
            if data.current.value == '7' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleXenonLightsColour(veh, 7)
            end
            if data.current.value == '8' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleXenonLightsColour(veh, 8)
            end
            if data.current.value == '9' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleXenonLightsColour(veh, 9)
            end
            if data.current.value == '10' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SSetVehicleXenonLightsColour(veh, 10)
            end
            if data.current.value == '11' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SSetVehicleXenonLightsColour(veh, 11)
            end
            if data.current.value == '12' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleXenonLightsColour(veh, 12)
            end
    end,
    function(data, menu)
        menu.close()
    end)
end

--[[
    Marker, Blip and help text
]]

local location = {
    {x = 534.26,y = -169.45,z = 54.60},
    {x = 529.03,y = -169.24,z = 55.0},
    {x = 537.82,y = -179.45,z = 54.50},
    {x = 538.59,y = -189.54,z = 54.46},

}

local player = PlayerPedId()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerLoc = GetEntityCoords(player)
        for k in pairs(location) do
            if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z, 1011.34, -692.64, 56.97, true) < 20 then
            DrawMarker(20, location[k].x, location[k].y, location[k].z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 255, 50, 255, 100, true, true, 2, true, false, false, false)
        end
    end
end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(location) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, location[k].x, location[k].y, location[k].z)

            if dist <= 1.2 then
                ESX.ShowHelpNotification("Far rengini değiştirmek için ~INPUT_TALK~ tuşuna basınız ")
				if IsControlJustPressed(1,51) then 
					OpenHeadlightMenu()
				end
            end
        end
    end
end)


	-- Create blips
	Citizen.CreateThread(function()
        for k in pairs(location) do
			local blip = AddBlipForCoord(537.39, -179.0, 54.0)

			SetBlipSprite (blip, 643)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.6)
			SetBlipColour (blip, 8)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Araba Far Renk")
			EndTextCommandSetBlipName(blip)
		end
	end)
