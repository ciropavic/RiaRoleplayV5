-- Settings
local depositAtATM = true -- Allows the player to deposit at an ATM rather than only in banks (Default: false)
local giveCashAnywhere = false -- Allows the player to give CASH to another player, no matter how far away they are. (Default: false)
local withdrawAnywhere = false -- Allows the player to withdraw cash from bank account anywhere (Default: false)
local depositAnywhere = false -- Allows the player to deposit cash into bank account anywhere (Default: false)
local displayBankBlips = true -- Toggles Bank Blips on the map (Default: true)
local displayAtmBlips = false -- Toggles ATM blips on the map (Default: false) // THIS IS UGLY. SOME ICONS OVERLAP BECAUSE SOME PLACES HAVE MULTIPLE ATM MACHINES. NOT RECOMMENDED
local enableBankingGui = true -- Enables the banking GUI (Default: true) // MAY HAVE SOME ISSUES

-- ATMS
local atms = {
  [1] = -1126237515,
  [2] = 506770882,
  [3] = -870868698,
  [4] = 150237004,
  [5] = -239124254,
  [6] = -1364697528,  
}


v_5_b_atm1=150237004 
v_5_b_atm2=-239124254 

prop_atm_03=-1364697528 


RegisterNetEvent('bank:checkATM')
AddEventHandler('bank:checkATM', function()
  if IsNearATM() then
    atmOpen = true
    openGui()
    bankOpen = true
  else
    TriggerEvent("DoLongHudText","No ATM.",2)
  end
end)

function IsNearATM()
  for i = 1, #atms do
    local objFound = GetClosestObjectOfType( GetEntityCoords(GetPlayerPed(-1)), 0.75, atms[i], 0, 0, 0)

    if DoesEntityExist(objFound) then
      TaskTurnPedToFaceEntity(GetPlayerPed(-1), objFound, 3.0)
      return true
    end
  end

  return false
end
-- Banks
local banks = {
  {name="Hades Bank", id=108, x=150.266, y=-1040.203, z=29.374},
  {name="Posedion Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
  {name="Zeus Bank", id=108, x=-2962.582, y=482.627, z=15.703},
  {name="Artemis Bank", id=108, x=-112.202, y=6469.295, z=31.626},
  {name="Ares Bank", id=108, x=314.187, y=-278.621, z=54.170},
  {name="Medusa Bank", id=108, x=-351.534, y=-49.529, z=49.042},
  {name="Hephaistos Bank", id=108, x=1176.0833740234, y=2706.3386230469, z=37.157722473145},
  {name="Car Bank", id=108, x=-56.0833740234, y=-1097.3386230469, z=26.157722473145},

}

-- Display Map Blips
Citizen.CreateThread(function()
  if (displayBankBlips == true) then
    for _, item in pairs(banks) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, 11)
      SetBlipScale(item.blip, 0.7)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
  end
end)

-- NUI Variables
local atBank = false
local atATM = false
local bankOpen = false
local atmOpen = false

-- Open Gui and Focus NUI
function openGui()
	TriggerEvent("mythic_progbar:client:progress", {
			name = "searching_inv",
			duration = 1500,
			label = "Kart Takılıyor",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = true,
					disableCombat = true,
			},
			animation = {
				animDict = "amb@prop_human_atm@male@enter",
				anim = "enter",
			}
	}, function(status)
		if not status then
			SetNuiFocus(true, true)
			SendNUIMessage({openBank = true})
			TriggerServerEvent('bank:balance')
			TriggerEvent("banking:viewCash")
		end
	end)

end

-- Close Gui and disable NUI
function closeGui()
	SetNuiFocus(false, false)
	SendNUIMessage({openBank = false})
	TriggerEvent("mythic_progbar:client:progress", {
		name = "bruh",
		duration = 1000,
		label = "Kart Çıkarılıyor",
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = true,
				disableCombat = true,
		},
		animation = {
			animDict = "amb@prop_human_atm@male@exit",
			anim = "exit",
		}
	}, function(status)
	if not status then
		bankOpen = false
		atmOpen = false
	end
	end)	
end

RegisterCommand('atm', function()

  TriggerEvent("bank:checkATM")
end)

atmuse = false
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 
function bankanimation()
    local player = GetPlayerPed( -1 )
    if IsNearATM() then
      if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 

            loadAnimDict( "amb@prop_human_atm@male@enter" )
            loadAnimDict( "amb@prop_human_atm@male@exit" )
            loadAnimDict( "amb@prop_human_atm@male@idle_a" )

          if ( atmuse ) then 
              ClearPedTasks(GetPlayerPed(-1))
              TaskPlayAnim( player, "amb@prop_human_atm@male@exit", "exit", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
              atmuse = false
              local finished = exports["np-taskbar"]:taskBar(3000,"Kart Çıkarılıyor")
				Wait(3000)
              ClearPedTasksImmediately(GetPlayerPed(-1))
          else
              atmuse = true
              TaskPlayAnim( player, "amb@prop_human_atm@male@idle_a", "idle_b", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
          end
      end
    else
        if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 

            loadAnimDict( "mp_common" )

            if ( atmuse ) then 
                ClearPedTasks(GetPlayerPed(-1))
                TaskPlayAnim( player, "mp_common", "givetake1_a", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
                atmuse = false
                local finished = exports["np-taskbar"]:taskBar(1000,"Kart Çıkarılıyor1")
				Wait(1000)
                ClearPedTasksImmediately(GetPlayerPed(-1))
            else
                atmuse = true
                TaskPlayAnim( player, "mp_common", "givetake1_a", 1.0, 1.0, -1, 49, 0, 0, 0, 0 )
                Citizen.Wait(1000)
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

-- If GUI setting turned on, listen for INPUT_PICKUP keypress
if enableBankingGui then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)

      local ply = GetPlayerPed(-1)
      local plyCoords = GetEntityCoords(ply, 0)
      local closestbank = 1000.0
      local scanid = 0

      if not (IsInVehicle()) and not bankOpen then
        for i = 1, #banks do
          local distance = GetDistanceBetweenCoords(banks[i].x, banks[i].y, banks[i].z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
          if(distance < closestbank) then
            scanid = i
            closestbank = distance
          end
        end
      end

      if(closestbank < 1.5 and scanid ~= 0) then
          local cdst = closestbank
          while cdst < 1.5 do
            Citizen.Wait(1)

            local plyCoords = GetEntityCoords(ply, 0)
            cdst = GetDistanceBetweenCoords(banks[scanid].x, banks[scanid].y, banks[scanid].z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            
            
               DrawText3D(banks[scanid].x, banks[scanid].y, banks[scanid].z,"Bankaya kartınızı takmak için [E] kasınızı oynatınız")
             -- if not IsInVehicle() then exports["np-base"]:getModule("Util"):MissionText("Press '~b~Context Action Key~w~' (Default: ~b~E~w~) to view your account", 500) else exports["np-base"]:getModule("Util"):MissionText("You ~r~cannot~w~~w~ use the bank in a vehicle", 500) end
              atBank = true
              if IsControlJustPressed(1, 38)  then -- IF INPUT_PICKUP Is pressed
                  openGui()
                  bankOpen = true
              end
              if bankOpen then
                Citizen.Wait(1000)
              end
          end
      else

        if(atmOpen or bankOpen) then
          closeGui()
          atmOpen = false
          bankOpen = false
        end
        if atBank then
          atBank = false
        end

        Citizen.Wait(math.ceil(closestbank*20))
      end
    end
  end)
end

-- Disable controls while GUI open
Citizen.CreateThread(function()
  while true do
    if bankOpen or atmOpen then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisableControlAction(0, 24, active) -- Attack
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end
    end
    Citizen.Wait(0)
  end
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNUICallback('balance', function(data, cb)
TriggerServerEvent('bank:balance')
  SendNUIMessage({openSection = "balance"})
  cb('ok')
end)

RegisterNUICallback('withdraw', function(data, cb)
  SendNUIMessage({openSection = "withdraw"})
  cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
  SendNUIMessage({openSection = "deposit"})
  cb('ok')
end)

RegisterNUICallback('transfer', function(data, cb)
  SendNUIMessage({openSection = "transfer"})
  cb('ok')
end)

RegisterNUICallback('quickCash', function(data, cb)
  TriggerEvent('bank:withdraw', 100)
  cb('ok')
end)

RegisterNUICallback('withdrawSubmit', function(data, cb)
  TriggerEvent('bank:withdraw', tonumber(data.amount))
  cb('ok')
end)

RegisterNUICallback('depositSubmit', function(data, cb)
  TriggerEvent('bank:deposit', tonumber(data.amount))
  cb('ok')
end)

RegisterNUICallback('transferSubmit', function(data, cb)
  local fromPlayer = GetPlayerServerId();
  TriggerEvent('bank:transfer', tonumber(fromPlayer), tonumber(data.toPlayer), tonumber(data.amount))
  cb('ok')
end) --]]

-- Check if player is near an atm


-- Check if player is in a vehicle
function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

-- Check if player is near a bank
function IsNearBank()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(banks) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= 2) then
      return true
    end
  end
end

-- Check if player is near another player
function IsNearPlayer(player)
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
  local ply2Coords = GetEntityCoords(ply2, 0)
  local distance = Vdist2(plyCoords, ply2Coords)
  if(distance <= 5) then
    return true
  end
end

-- Process deposit if conditions met
RegisterNetEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
  if(IsNearBank() == true ) then
    if (IsInVehicle()) then
      --print("You ~r~cannot~w~ use the ATM in a vehicle")
	  exports['mythic_notify']:SendAlert('inform', 'ATM araçtayken kullanılamaz')
	  --exports["np-base"]:getModule("Util"):MissionText("You ~r~cannot~w~ use the ATM in a vehicle", 500)
    else
      TriggerServerEvent("bank:deposit", tonumber(amount))
	  TriggerServerEvent('bank:balance')
	  TriggerEvent('banking:viewBalance')
	  TriggerEvent('banking:viewCash')
    end
  else
	if depositAtATM then
	  TriggerServerEvent("bank:deposit", tonumber(amount))
	  TriggerServerEvent('bank:balance')
	  TriggerEvent('banking:viewBalance')
	  TriggerEvent('banking:viewCash')
	else
    --exports["np-base"]:getModule("Util"):MissionText("You ~r~cannot~w~ deposit at an ATM", 2000)
	--print("You ~r~cannot~w~ deposit at an ATM")
	exports['mythic_notify']:SendAlert('inform', 'ATM bu işlemi gerçekleştiremez')
	end
  end
end)

-- Process withdraw if conditions met
RegisterNetEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
  if(IsNearATM() == true or IsNearBank() == true) then
    if (IsInVehicle()) then
      --print("You ~r~cannot~w~ use the bank in a vehicle")
	  exports['mythic_notify']:SendAlert('inform', 'Bankayı araçtayken kullanamazsın.')
	  --exports["np-base"]:getModule("Util"):MissionText("You ~r~cannot~w~ use the bank in a vehicle", 500)
    else
      TriggerServerEvent("bank:withdraw", tonumber(amount))
      TriggerServerEvent('bank:balance')
	  TriggerEvent('banking:viewBalance')
	  TriggerEvent('banking:viewCash')
    end
  end
end)

-- Process give dm if conditions met
RegisterNetEvent('dirtyMoney:givedm')
AddEventHandler('dirtyMoney:givedm', function(toPlayer, amount)
  if not IsNearPlayer(toPlayer) then TriggerEvent('chatMessage', "", {255, 0, 0}, "^1You are not near this player!") return end

  local target = GetPlayerFromServerId(tonumber(toPlayer))
  local targetPos = GetEntityCoords(GetPlayerPed(target))

  local userCoords = GetEntityCoords(GetPlayerPed(-1))

  if Vdist2(targetPos, userCoords) > 15.0 then
      TriggerEvent('chatMessage', "", {255, 0, 0}, "^1You are not near this player!")
      return
  end

  local player2 = GetPlayerFromServerId(tonumber(toPlayer))
  local playing = IsPlayerPlaying(player2)
  
  if (playing ~= false) then
    TriggerServerEvent("dirtyMoney:givedm", toPlayer, tonumber(amount))
  else
    TriggerEvent('chatMessage', "", {255, 0, 0}, "^1This player is not online!");
  end
end)



-- Process give cash if conditions met
RegisterNetEvent('bank:givecash')
AddEventHandler('bank:givecash', function(toPlayer, amount)
  if not IsNearPlayer(toPlayer) then TriggerEvent('chatMessage', "", {255, 0, 0}, "^1You are not near this player!") return end

  local target = GetPlayerFromServerId(tonumber(toPlayer))
  local targetPos = GetEntityCoords(GetPlayerPed(target))

  local userCoords = GetEntityCoords(GetPlayerPed(-1))

  if Vdist2(targetPos, userCoords) > 15.0 then
      TriggerEvent('chatMessage', "", {255, 0, 0}, "^1You are not near this player!")
      return
  end

  local player2 = GetPlayerFromServerId(tonumber(toPlayer))
  local playing = IsPlayerPlaying(player2)
  
  if (playing ~= false) then
    TriggerServerEvent("bank:givecash", toPlayer, tonumber(amount))
  else
    TriggerEvent('chatMessage', "", {255, 0, 0}, "^1This player is not online!");
  end
end)

-- Process bank transfer if player is online
RegisterNetEvent('bank:transfer')
AddEventHandler('bank:transfer', function(fromPlayer, toPlayer, amount)
  local player2 = GetPlayerFromServerId(toPlayer)
  local playing = IsPlayerPlaying(player2)
  if (playing ~= false) then
    TriggerServerEvent("bank:transfer", toPlayer, tonumber(amount))
  else
    TriggerEvent('chatMessage', "", {255, 0, 0}, "^1This player is not online!");
  end
  TriggerServerEvent('bank:balance')
end)

-- Send NUI message to update bank balance
RegisterNetEvent('banking:updateBalance')
AddEventHandler('banking:updateBalance', function(balance2, show)
  local id = PlayerId()
  local playerName = GetPlayerName(id)
	SendNUIMessage({
		updateBalance = true,
		balance = tonumber(balance2),
    player = playerName,
    show = show
	})
end)

RegisterNetEvent('banking:updateCash')
AddEventHandler('banking:updateCash', function(balance, show)
  local id = PlayerId()
  local playerName = GetPlayerName(id)
	SendNUIMessage({
		updateCash = true,
		cash = balance,
    show = show
	})
end)

RegisterNetEvent("banking:viewBalance")
AddEventHandler("banking:viewBalance", function()
  SendNUIMessage({
    viewBalance = true
  })
end)

-- Send NUI Message to display add balance popup
RegisterNetEvent("banking:addBalance")
AddEventHandler("banking:addBalance", function(amount)
	SendNUIMessage({
		addBalance = true,
		amount = amount
	})
end)

RegisterNetEvent("banking:removeBalance")
AddEventHandler("banking:removeBalance", function(amount)
	SendNUIMessage({
		removeBalance = true,
		amount = amount
	})
end)

RegisterNetEvent("banking:addCash")
AddEventHandler("banking:addCash", function(amount)
	SendNUIMessage({
		addCash = true,
		amount = amount
	})
end)

-- Send NUI Message to display remove balance popup
RegisterNetEvent("banking:removeCash")
AddEventHandler("banking:removeCash", function(amount)
	SendNUIMessage({
		removeCash = true,
		amount = amount
	})
end)

RegisterNetEvent("np-base:addedMoney")
AddEventHandler("np-base:addedMoney", function(amt, total)
    TriggerEvent("banking:updateCash", total)
    TriggerEvent("banking:addCash", amt)
end)

RegisterNetEvent("np-base:removedMoney")
AddEventHandler("np-base:removedMoney", function(amt, total)
    TriggerEvent("banking:updateCash", total)
    TriggerEvent("banking:removeCash", amt)
end)


RegisterNetEvent("banking:viewCash")
AddEventHandler("banking:viewCash", function()
  SendNUIMessage({
		viewCash = true
	})
end)