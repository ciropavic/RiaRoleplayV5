local Keys = {

  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,

  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,

  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,

  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,

  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,

  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,

  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,

  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,

}



-- action functions

local CurrentAction           = nil

local CurrentActionMsg        = ''

local CurrentActionData       = {}

local HasAlreadyEnteredMarker = false

local LastZone                = nil



local aracstat = false

local topspeed = 0

local handling = 0

local braking = 0

local accel = 0



local model = nil

local car = nil

local veh = nil



-- esx_vehicleshop funtions

local IsInShopMenu            = false

local Categories              = {}

local Vehicles                = {}

local LastVehicles            = {}

local CurrentVehicleData      = nil



-- esx

local PlayerData              = {}

local GUI = {}

ESX                           = nil

GUI.Time                      = 0



Citizen.CreateThread(function ()

  while ESX == nil do

    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    Citizen.Wait(0)

  end



  ESX.TriggerServerCallback('esx_vehicleshop:getCategories', function (categories)

    Categories = categories

  end)



  ESX.TriggerServerCallback('esx_vehicleshop:getVehicles', function (vehicles)

    Vehicles = vehicles

  end)

end)



function DeleteKatalogVehicles ()

  while #LastVehicles > 0 do

    local vehicle = LastVehicles[1]

    ESX.Game.DeleteVehicle(vehicle)

    table.remove(LastVehicles, 1)

    aracstat = false

    topspeed = 0

    handling = 0

    braking = 0

    accel = 0

    for i = 1, 5 do

      scaleform = resetscaleform(topspeed,handling,braking,accel,"mp_car_stats_01",i)

    end      

  end

end



--markers

AddEventHandler('esx_qalle_bilpriser:hasEnteredMarker', function (zone)

  if zone == 'Katalog' then

    CurrentAction     = 'cars_menu'

    CurrentActionMsg  = _U('press_e')

    CurrentActionData = {}

  end



  if zone == 'GoDownFrom' then

    CurrentAction     = 'go_down_from'

    CurrentActionMsg  = _U('press_e_to_enter')

    CurrentActionData = {}

  end



  if zone == 'GoUpFrom' then

    CurrentAction     = 'go_up_from'

    CurrentActionMsg  = _U('press_e_to_exit')

    CurrentActionData = {}

  end



end)



AddEventHandler('esx_qalle_bilpriser:hasExitedMarker', function (zone)

  if not IsInShopMenu then

    ESX.UI.Menu.CloseAll()

  end



  CurrentAction = nil

end)



function OpenShopMenu ()

  IsInShopMenu = true



  ESX.UI.Menu.CloseAll()



  local playerPed = PlayerPedId()



    Citizen.CreateThread(function()
      while true do
        Citizen.Wait(0)
        if IsInShopMenu == true then
          SetPedStealthMovement(PlayerPedId(),true,"")
          DisableControlAction(0,75,true) -- disable exit vehicle
          DisableControlAction(27,75,true) -- disable exit vehicle
        end
      end
    end)

  FreezeEntityPosition(playerPed, true)

  SetEntityVisible(playerPed, false)

  SetEntityCoords(playerPed, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z)



  local vehiclesByCategory = {}

  local elements           = {}

  local firstVehicleData   = nil



  for i=1, #Categories, 1 do

    vehiclesByCategory[Categories[i].name] = {}

  end



  for i=1, #Vehicles, 1 do

    table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])

  end



  for i=1, #Categories, 1 do

    local category         = Categories[i]

    local categoryVehicles = vehiclesByCategory[category.name]

    local options          = {}



    for j=1, #categoryVehicles, 1 do

      local vehicle = categoryVehicles[j]



      if i == 1 and j == 1 then

        firstVehicleData = vehicle

      end



      table.insert(options, vehicle.name .. ' ')

    end



    table.insert(elements, {

      name    = category.name,

      label   = category.label,

      value   = 0,

      type    = 'slider',

      max     = #Categories[i],

      options = options

    })

  end



  ESX.UI.Menu.Open(

    'default', GetCurrentResourceName(), 'vehicle_shop',

    {

      title    = 'Showroom',

      align    = 'top-left',

      elements = elements,

    },

    function (data, menu)

      local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]



      ESX.UI.Menu.Open(

        'default', GetCurrentResourceName(), 'shop_confirm',

        {

          title = vehicleData.name,

          align = 'top-left',

          elements = {

    

          },

        },

        function (data2, menu2)

          if data2.current.value == 'no' then

             menu2.close()

          end



        end,

        function (data2, menu2)

          menu2.close()

        end

      )



    end,

    function (data, menu)



      menu.close()



        DoScreenFadeOut(1000)

        Citizen.Wait(1000)

        DoScreenFadeIn(1000)

      DeleteKatalogVehicles()



      local playerPed = PlayerPedId()



      CurrentAction     = 'shop_menu'

      CurrentActionMsg  = 'shop menu'

      CurrentActionData = {}



      FreezeEntityPosition(playerPed, false)



     SetEntityCoords(playerPed, Config.Zones.GoDownFrom.Pos.x, Config.Zones.GoDownFrom.Pos.y, Config.Zones.GoDownFrom.Pos.z)

        SetEntityVisible(playerPed, true)



      IsInShopMenu = false



    end,

    function (data, menu)

      local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

      local playerPed   = PlayerPedId()



      DeleteKatalogVehicles()



      ESX.Game.SpawnLocalVehicle(vehicleData.model, {

        x = Config.Zones.ShopInside.Pos.x,

        y = Config.Zones.ShopInside.Pos.y,

        z = Config.Zones.ShopInside.Pos.z

      }, Config.Zones.ShopInside.Heading, function(vehicle)

        table.insert(LastVehicles, vehicle)

        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

        FreezeEntityPosition(vehicle, true)

        aracstat = true

        model = vehicleData.model

        veh = vehicle

        car = vehicle

        TriggerEvent("ARPF:spawn:recivekeys", vehicle)

      end)

    end

  )



  DeleteKatalogVehicles()



  ESX.Game.SpawnLocalVehicle(firstVehicleData.model, {

    x = Config.Zones.ShopInside.Pos.x,

    y = Config.Zones.ShopInside.Pos.y,

    z = Config.Zones.ShopInside.Pos.z

  }, Config.Zones.ShopInside.Heading, function (vehicle)

    table.insert(LastVehicles, vehicle)

    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

    FreezeEntityPosition(vehicle, true)

    aracstat = true

    model = firstVehicleData.model

    veh = vehicle

    TriggerEvent("ARPF:spawn:recivekeys", vehicle)

  end)



end



Citizen.CreateThread(function ()

  while true do

  Citizen.Wait(0)

    if aracstat then



    for i = 0,24 do

      SetVehicleModKit(veh,0)

      RemoveVehicleMod(veh,i)

    end



    x,y,z = table.unpack(GetEntityCoords(veh, true))



    scaleform = Initialize("mp_car_stats_01", veh, model)

    

    if model == "faggio" or model == "avarus" or model == "bati" or model == "bf400" or model == "carbonrs" or model == "cliffhanger" or model == "daemon" or model == "double" or model == "enduro" or model == "esskey" or model == "gargoyle" or model == "hakuchou" or model == "hakuchou2" or model == "manchez" or model == "nemesis" or model == "sanctus" or model == "wolfsbane" or model == "vader" or model == "sanchez" or model == "akuma" or model == "fcr" or model == "vindicator" or model == "bmx" or model == "cruiser" or model == "fixter" or model == "scorcher" or model == "tribike" or model == "tribike2" or model == "tribike3" then

      Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x+3.0,y+0.0,z+5.4, 0.0, -180.0, 0.0, 0.0, 1.0, 0.0, 6.0, 4.0, 5.0, 0)

    else

      Citizen.InvokeNative(0x87D51D72255D4E78,scaleform, x+3.0,y+1.5,z+5.2, 0.0, -180.0, 0.0, 0.0, 1.0, 0.0, 6.0, 4.0, 5.0, 0)

    end

  end

end

end)





function resetscaleform(topspeed, handling, braking, accel, resetscaleform, i)

  scaleform = RequestScaleformMovie(resetscaleform)



  while not HasScaleformMovieLoaded(scaleform) do

      Citizen.Wait(0)

  end



  PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")

  PushScaleformMovieFunctionParameterString("LOADING")

  PushScaleformMovieFunctionParameterString("PDM")

  PushScaleformMovieFunctionParameterString("MPCarHUD")

  PushScaleformMovieFunctionParameterString("Annis")

  PushScaleformMovieFunctionParameterString("Top Speed")

  PushScaleformMovieFunctionParameterString("Handling")

  PushScaleformMovieFunctionParameterString("Braking")

  PushScaleformMovieFunctionParameterString("Downforce")

  PushScaleformMovieFunctionParameterInt( (20 * i)-1 )

  PushScaleformMovieFunctionParameterInt( (20 * i)-1 )

  PushScaleformMovieFunctionParameterInt( (20 * i)-1 )

  PushScaleformMovieFunctionParameterInt( (20 * i)-1 )

  PopScaleformMovieFunctionVoid()

end



function Initialize(scaleform,veh,model)

  scaleform = RequestScaleformMovie(scaleform)



  while not HasScaleformMovieLoaded(scaleform) do

      Citizen.Wait(0)

  end



  PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")

  PushScaleformMovieFunctionParameterString(model)

  PushScaleformMovieFunctionParameterString("PDM")

  PushScaleformMovieFunctionParameterString("MPCarHUD")

  PushScaleformMovieFunctionParameterString("Annis")

  PushScaleformMovieFunctionParameterString("Maks. Hız")

  PushScaleformMovieFunctionParameterString("Hızlanma")

  PushScaleformMovieFunctionParameterString("Firen")

  PushScaleformMovieFunctionParameterString("Çekiş Gücü")

  

  local topspeed = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveMaxFlatVel') / 1.9)

  local accel = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce') * 245) 

  local braking = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce') * 32)

  local handling = math.ceil(GetVehicleHandlingFloat(veh, 'CHandlingData', 'fSteeringLock') * 1.7)



  if topspeed > 100 then

    topspeed = 100

  end

  if handling > 100 then

    handling = 100

  end

  if braking > 100 then

    braking = 100

  end

  if accel > 100 then

    accel = 100

  end



  Citizen.Trace(topspeed)

  Citizen.Trace(handling)

  Citizen.Trace(braking)

  Citizen.Trace(accel)



  PushScaleformMovieFunctionParameterInt( topspeed )

  PushScaleformMovieFunctionParameterInt( handling )

  PushScaleformMovieFunctionParameterInt( braking )

  PushScaleformMovieFunctionParameterInt( accel )

  PopScaleformMovieFunctionVoid()



  return scaleform

end





--keycontrols

Citizen.CreateThread(function ()

  while true do

    Citizen.Wait(0)



    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')

      AddTextComponentString(CurrentActionMsg)

      DisplayHelpTextFromStringLabel(0, 0, 1, -1)



      if IsControlPressed(0, Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then

        if CurrentAction == 'cars_menu' then

          OpenShopMenu()

        end



        if CurrentAction == 'go_down_from' then

            OpenShopMenu()

        end



        if CurrentAction == 'go_up_from' then

            local playerPed = PlayerPedId()

            DoScreenFadeOut(3000)

            Wait(3000)

            DoScreenFadeIn(3000)

            SetEntityCoords(playerPed, Config.Zones.GoDownFrom.Pos.x, Config.Zones.GoDownFrom.Pos.y, Config.Zones.GoDownFrom.Pos.z)

        end



        CurrentAction = nil

        GUI.Time      = GetGameTimer()

      end

    end

  end

end)



-- Display markers

Citizen.CreateThread(function ()

  while true do

    Wait(50)



    local coords = GetEntityCoords(PlayerPedId())



    for k,v in pairs(Config.Zones) do

      if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then

        if k == "GoDownFrom" then

          DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)

        end

      end

    end

  end

end)



-- Enter / Exit marker events

Citizen.CreateThread(function ()

  while true do

    Wait(50)



    local coords      = GetEntityCoords(PlayerPedId())

    local isInMarker  = false

    local currentZone = nil



    for k,v in pairs(Config.Zones) do

      if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then

        isInMarker  = true

        currentZone = k

      end

    end



    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then

      HasAlreadyEnteredMarker = true

      LastZone                = currentZone

      TriggerEvent('esx_qalle_bilpriser:hasEnteredMarker', currentZone)

    end



    if not isInMarker and HasAlreadyEnteredMarker then

      HasAlreadyEnteredMarker = false

      TriggerEvent('esx_qalle_bilpriser:hasExitedMarker', LastZone)

    end

  end

end)



---- FUNCTIONS ----

function Notify(text)

	SetNotificationTextEntry('STRING')

	AddTextComponentString(text)

	DrawNotification(false, false)

end



function DisplayHelpText(str)

	SetTextComponentFormat("STRING")

	AddTextComponentString(str)

	DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end



--notification

function sendNotification(message, messageType, messageTimeout)

  exports['mythic_notify']:SendAlert(messageType, message)

end