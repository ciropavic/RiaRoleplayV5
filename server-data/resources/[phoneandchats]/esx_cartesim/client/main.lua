local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                           = nil
local GUI                     = {}
GUI.Time                      = 0
local isInMarker      = false

RegisterNetEvent('esx_cartesim:OpenSim')
AddEventHandler('esx_cartesim:OpenSim', function()
	OpenPhoneMenu()
end)

function OpenSimMenu()

	ESX.UI.Menu.CloseAll()

	local elements = {}
	local elements2 = {}
  
	  ESX.TriggerServerCallback('esx_cartesim:GetList', function(sim)
  
		  for _,v in pairs(sim) do
  
			  table.insert(elements, {label = tostring(v.number), value = v})
			  
		  end
  
		  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'phone_change',
		  {
			  title    = 'Liste des cartes SIM',
			  elements = elements,
		  },
	  function(data, menu)
  
		local elements2 = {
			{label = 'Use', value = 'sim_use'},
			{label = 'Give', value = 'sim_give'},
		  	{label = 'Delete', value = 'sim_delete'}
		  }
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sim_change', {
			title    = "What do you want to do with the Sim Card?",
			elements = elements2,
  
		  }, 
		  function(data2, menu2)
  
			if data2.current.value == 'sim_use' then
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('esx_cartesim:sim_use', data.current.value.number)
				ESX.ShowNotification("You have activated the SIM card ~o~" .. data.current.value.number)
			end
			if data2.current.value == 'sim_give' then
				ESX.UI.Menu.CloseAll()
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification('No players nearby!')
				else
					TriggerServerEvent('esx_cartesim:sim_give', data.current.value.number, GetPlayerServerId(closestPlayer))
				end
			end
			if data2.current.value == 'sim_delete' then
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('esx_cartesim:sim_delete', data.current.value.number)
				ESX.ShowNotification("You threw the sim card ~o~" .. data.current.value.number)
			end

			menu2.close()
		  end, function(data2, menu2)
			menu2.close()
		  end)
  
		  end,
		  function(data, menu)
			  menu.close()
		  end
	  )	
	end)
  
end

function OpenPhoneMenu()

	ESX.UI.Menu.CloseAll()

	local elements = {
	  --{label = 'Ouvrir', value = 'open_phone'},
	  {label = 'SIM Card', value = 'sim_phone'}
	}
  
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'phone_actions',
	  {
		title    = 'Phone',
		elements = elements
	  },
	  function(data, menu)
  
		if data.current.value == 'open_phone' then
			ESX.UI.Menu.CloseAll()
			ESX.TriggerServerCallback('esx_cartesim:CheckSim', function(sim)
				if sim then
					TriggerEvent('gcphone:Open')
				else
					ESX.ShowNotification("You don't have a SIM card!")
				end
			end)

		end

		if data.current.value == 'sim_phone' then
			OpenSimMenu()
		end
  
	  end,
	  function(data, menu)
  
		menu.close()
	  end
	)
  
end

  Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	end
  end)

RegisterCommand('simlist', function(source, args, raw)
    OpenPhoneMenu()
end)



RegisterCommand('simsteal', function(source, args, raw)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'random@mugging3', 'handsup_standing_base', 3) or IsPlayerDead(closestPlayer) then

			TriggerServerEvent('esx_cartesim:sim_cal', GetPlayerServerId(closestPlayer))

		else 
			ESX.ShowNotification("The person is not raised hands or dead")
		--	exports['mythic_notify']:SendAlert('error', 'The person is not raised hands or dead', 3000)
		
		end
		
    else
		ESX.ShowNotification("No players nearby!")
      --  exports['mythic_notify']:SendAlert('error', 'No players nearby!')
    end
end)
