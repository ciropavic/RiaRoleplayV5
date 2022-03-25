ESX = nil
EGYT = {}

local multa = 0

local isWhitelisted = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        for k,v in pairs(Config.Radares) do
            local player = GetPlayerPed(-1)
            local coords = GetEntityCoords(player, true)
            if GetDistanceBetweenCoords(v.x, v.y, v.z, coords["x"], coords["y"], coords["z"]) < 20 then
            --    EGYT.Debug('Has sido cazado por un radar.')              
                EGYT.CheckSpeed(v.velocidadmaxima)
                Citizen.Wait(10000)
            end
        end
    end
end)

Citizen.CreateThread(function()
    if Config.EnableBlips == true then
        for k,v in pairs(Config.Radares) do
            local blip = AddBlipForCoord(v.x, v.y)

            SetBlipSprite (blip, 604)
            SetBlipDisplay(blip, 4)
            SetBlipColour(blip, 1)
            SetBlipScale  (blip, 0.7)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Radares')
            EndTextCommandSetBlipName(blip)
        end
    end
end)

EGYT.CheckSpeed = function(maxVel)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if IsPedInVehicle(playerPed, vehicle, true) then
        if GetPedInVehicleSeat(vehicle, -1) == playerPed then
            local Speed = math.floor(GetEntitySpeed(playerPed) * 3.6 * 100)/100
            if Speed >= maxVel then
                for k,v in ipairs(Config.VehiculosExcluidos) do
                    if GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)) == v then
                        isWhitelisted = true
                    end
                end
                if not isWhitelisted == true then
                    local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
                    local plate = GetVehicleNumberPlateText(vehicle)

                    if Speed - maxVel < 80 then
                        multa = Config.MultaBase * Config.Multiplicador.normal
                    elseif Speed - maxVel >= 120 then
                        multa = Config.MultaBase * Config.Multiplicador.mas20
                    elseif Speed - maxVel >= 140 then
                        multa = Config.MultaBase * Config.Multiplicador.mas40
                    elseif Speed - maxVel >= 160 then
                        multa = Config.MultaBase * Config.Multiplicador.mas60
                    elseif Speed - maxVel > 180 then
                        multa = Config.MultaBase * Config.Multiplicador.mas100
                    end

                    TriggerServerEvent('egyt_radares:setfine', vehicleName, plate, Speed, multa)

                   -- EGYT.Debug('El vehículo ' .. vehicleName .. ' con matricula ' .. plate .. ' ha sido cazado ha '.. Speed ..' km/h ha recibido una multa de '.. multa ..'.')
                else
                   -- EGYT.Debug('El vehículo ha sido cazado pero está en la Whitelist')
                    isWhitelisted = false
                end 
            end
        end
    else
      --  EGYT.Debug('No estás en un vehículo')
    end
end

