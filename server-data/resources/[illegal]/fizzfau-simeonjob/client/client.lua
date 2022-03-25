ESX = nil
PlayerData = {}
car = 0
VehicleNameLabel = nil
playerLabel = nil
playerVeh = nil
xd = 0
missionState = false
action = nil

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
end)

function CreateDeliveryPed(x,y,z,h)

  local hashKey = `s_m_y_xmech_02`

  local pedType = 5

  RequestModel(hashKey)
  while not HasModelLoaded(hashKey) do
      RequestModel(hashKey)
      Citizen.Wait(100)
  end


  deliveryPed = CreatePed(pedType, hashKey, x,y,z - 0.98,h, 0, 0)


  ClearPedTasks(deliveryPed)
  ClearPedSecondaryTask(deliveryPed)
  TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
  SetPedFleeAttributes(deliveryPed, 0, 0)
  SetPedCombatAttributes(deliveryPed, 17, 1)

  SetPedSeeingRange(deliveryPed, 0.0)
  SetPedHearingRange(deliveryPed, 0.0)
  SetPedAlertness(deliveryPed, 0)
  SetPedKeepTask(deliveryPed, true)
  SetPedDiesWhenInjured(deliveryPed, false)
  SetEntityInvincible(deliveryPed, true)
  FreezeEntityPosition(deliveryPed, true)

end

function KeyGive()
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    FreezeEntityPosition(deliveryPed, false)
    local ped = GetPlayerPed(-1)
    TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 0.2)
    PlayAmbientSpeech1(deliveryPed, Config.Speech.speech, Config.Speech.param, 1)
    startAnim(ped, "mp_common", "givetake1_a")
    startAnim(deliveryPed, "mp_common", "givetake1_a")
    Citizen.Wait(1500)
    ClearPedTasksImmediately(deliveryPed)
    ClearPedTasksImmediately(ped)
  
    Citizen.Wait(2000)
    Delivery()
  else
    exports['mythic_notify']:SendAlert('error', _U('in_vehicle'))
  end
end

function Delivery()
  local coords = GetEntityCoords(deliveryPed)
  local pedvehicle = ESX.Game.GetClosestVehicle(coords, modelFilter , 5.0, 0, 71)
  local model = GetEntityModel(pedvehicle)
  local vehName = GetDisplayNameFromVehicleModel(model)
  print(vehName)
  if vehName == VehicleNameLabel then
    FreezeEntityPosition(deliveryPed, false)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      TaskLeaveVehicle(PlayerPedId(), playerVeh, 0)
      while IsPedInVehicle(PlayerPedId(), playerVeh, true) do
        Citizen.Wait(0)
      end
      Citizen.Wait(1000)
    end
    
    TriggerServerEvent("fizzfau-simeonjob:removeblip")
    TriggerServerEvent('fizzfau-simeonjob:addMoney')
    if DoesEntityExist(pedvehicle) then
      TaskVehicleDriveWander(deliveryPed, pedvehicle, 25.0, 1)
      Citizen.Wait(1000)
      --TaskVehicleDriveToCoord(deliveryPed, vehicle, 100.0, 100.0, 100.0, 55, model, 1, 100.0, 1)
      SetEntityAsNoLongerNeeded(pedvehicle)
	    SetPedAsNoLongerNeeded(deliveryPed)
      Citizen.Wait(50000)
      DeleteEntity(pedvehicle)
    end
    missionState = false
    createdped = false
    found = false
    send = false
    removeit = false
  else
    exports['mythic_notify']:SendAlert('error', _U('wrong_car'))
  end
end

function GiveMission()
  local ped = PlayerPedId()
  FreezeEntityPosition(ped_info, false)
  TaskTurnPedToFaceEntity(ped_info, PlayerPedId(), 0.2)
      Citizen.Wait(250)
      PlayAmbientSpeech1(ped_info, Config.Speech.speech, Config.Speech.param, 1)
      startAnim(ped, "mp_common", "givetake1_a")
      startAnim(ped_info, "mp_common", "givetake1_a")
      Citizen.Wait(1500)
      ClearPedTasksImmediately(ped_info)
      ClearPedTasksImmediately(ped)
      car = random_elem(Config.Cars)
      car = GetHashKey(car)
      missionState = true
      notify = false
      VehicleNameLabel =  GetDisplayNameFromVehicleModel(car)
      local VehicleName = GetLabelText(VehicleNameLabel)
      print(VehicleNameLabel)
      if Config.UseGcphone then
        --exports['mythic_notify']:SendAlert('inform', _U('details_sent'), 5000)
        TriggerServerEvent('esx_phone:send', 'police', _U("bring_car", VehicleName), true)
      else
        exports['mythic_notify']:SendAlert('inform', _U("bring_car", VehicleName), 5000)
      end
      Citizen.Wait(1500)
      FreezeEntityPosition(ped_info, true)
      ClearPedTasksImmediately(ped_info)
end

function CreateBlip()
  if Config.Blip.use then
		blip = AddBlipForCoord(Config.Simeon.x,Config.Simeon.y,Config.Simeon.z)
    SetBlipSprite(blip, Config.Blip.sprite)
    SetBlipColour(blip, Config.Blip.colour)
    SetBlipScale(blip, Config.Blip.scale)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U("blip_name"))
    EndTextCommandSetBlipName(blip)
  end
end

function random_elem(tb)
  local keys = {}
  for k in pairs(tb) do table.insert(keys, k) end
  return tb[keys[math.random(#keys)]]
end

Citizen.CreateThread(function()
    
  local ped_hash = Config.PedHash

  RequestModel(ped_hash)
  while not HasModelLoaded(ped_hash) do
      Citizen.Wait(1)
  end
  CreateBlip()
  ped_info = CreatePed(1, ped_hash, Config.Simeon.x, Config.Simeon.y, Config.Simeon.z, Config.Simeon.h, false, true)
  SetBlockingOfNonTemporaryEvents(ped_info, true) -- değiştirmeyin / do not touch
  SetPedDiesWhenInjured(ped_info, false) -- pedin ölümlü veya ölümsüz olmasını ayarlamak için / makes ped immortal
  SetPedCanPlayAmbientAnims(ped_info, true) -- değiştirmeyin / do not touch
  SetPedCanRagdollFromPlayerImpact(ped_info, false) --pedin yere düşmesini engellemek için / makes ped stil stand even get attacked
  SetEntityInvincible(ped_info, true)	-- pedin ölümsüz olması için / makes ped invincible
  FreezeEntityPosition(ped_info, true)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if missionState then
      if IsPedInAnyVehicle(PlayerPedId(), false) then
        playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        local playerModel = GetEntityModel(playerVeh)
        local playerLabel = GetDisplayNameFromVehicleModel(playerModel)
        if VehicleNameLabel == playerLabel then
          local coords = GetEntityCoords(PlayerPedId())
          if not notify then
            found = true
            xd = random_elem(Config.Locations)
            SetNewWaypoint(xd.x, xd.y, xd.z)
            CreateDeliveryPed(xd.x, xd.y, xd.z, xd.h)
            exports['mythic_notify']:SendAlert('error', _U("found_car"), 5000)
            exports['mythic_notify']:SendAlert('error', _U("waypoint_setted"), 5000)
            TriggerServerEvent('fizzfau-simeonjob:alertcopschat')
            notify = true
          end
          TriggerServerEvent('fizzfau-simeonjob:alertcops', coords.x, coords.y, coords.z)
          
          Citizen.Wait(5000)
        end
      end
    else
      Citizen.Wait(5000)
    end
  end 
end)
createdped = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if not missionState then
      local coordsim = GetEntityCoords(PlayerPedId())
      local distance = GetDistanceBetweenCoords(coordsim, Config.Simeon.x, Config.Simeon.y, Config.Simeon.z, false)
      if distance < 2.5 then
        Draw3D(Config.Simeon.x, Config.Simeon.y, Config.Simeon.z + 2, _U("press_button"))
        if IsControlJustPressed(0, 46) then
          GiveMission()
        end
      end
    end

    if found then
      local coords = GetEntityCoords(PlayerPedId())
      local dist = GetDistanceBetweenCoords(coords, xd.x, xd.y, xd.z, false)
      
      if dist < Config.Marker.draw then
        Draw3D(xd.x, xd.y, xd.z + 1, _U("press_button"))
        if dist < 2.5 then 
          if IsControlJustPressed(0, 46) then
            playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            local playerModel = GetEntityModel(playerVeh)
            local playerLabel = GetDisplayNameFromVehicleModel(playerModel)
            KeyGive()
          end
        end
      end
    end
  end 
end)

function startAnim(ped, dictionary, anim)
  Citizen.CreateThread(function()
    RequestAnimDict(dictionary)
    while not HasAnimDictLoaded(dictionary) do
      Citizen.Wait(0)
    end
      TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
  end)
end

function stopAnim(ped)
  StopAnimTask(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
end

function startPropAnim(ped, dictionary, anim, propname, bone)
  Citizen.CreateThread(function()
    RequestAnimDict(dictionary)
    while not HasAnimDictLoaded(dictionary) do
      Citizen.Wait(0)
    end
      attachObject(ped, propname, bone)
      TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
  end)
end

function stopPropAnim(ped, propname)
  StopAnimTask(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
  DeleteEntity(prop)
end

function attachObject(ped, propname, bone)
  prop = CreateObject(GetHashKey(propname), 0, 0, 0, true, true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, bone), 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, true, true, false, true, 1, true)
end

function Draw3D(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  
  SetTextScale(0.35, 0.35)
  SetTextFont(0)
  SetTextProportional(2)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 400
  --DrawRect(_x,_y+0.0125, 0.0002+ factor, 0.025, 0, 0, 0, 50)
end
send = false
removeit = false
RegisterNetEvent('fizzfau-simeonjob:setcopblip')
AddEventHandler('fizzfau-simeonjob:setcopblip', function(cx, cy, cz)
  if not removeit then
    RemoveBlip(copblip)
    copblip = AddBlipForCoord(cx, cy, cz)
    SetBlipSprite(copblip, 161)
    SetBlipScale(copblipy, 2.0)
    SetBlipColour(copblip, 8)
    PulseBlip(copblip)
    Citizen.Wait(60*1000*Config.Notify.remove)
    removeit = true
    if DoesBlipExist(copblip) and not send then
      RemoveBlip(copblip)
      send=true
      exports['mythic_notify']:SendAlert('error', _U("blip_removed"), 5000)
    end
  end
end)

RegisterNetEvent('fizzfau-simeonjob:removeblip')
AddEventHandler('fizzfau-simeonjob:removeblip', function()
  if DoesBlipExist(copblip) then
    RemoveBlip(copblip)
    exports['mythic_notify']:SendAlert('error',  _U("blip_removed"), 5000)
    removeit = true
  end
end)