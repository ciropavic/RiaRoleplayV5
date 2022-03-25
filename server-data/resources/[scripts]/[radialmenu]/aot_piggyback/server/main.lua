ESX = nil

local give = false
local usedRope = false

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('esx_barbie_lyftupp:checkRope')
AddEventHandler('esx_barbie_lyftupp:checkRope', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local ropeQuantity = xPlayer.getInventoryItem('Rope').count
	
	if ropeQuantity > 0 then
		TriggerClientEvent('esx_barbie_lyftupp:trueRope', source) -- เปิด
	else
		TriggerClientEvent('esx_barbie_lyftupp:falseRope', source) -- ปิด
	end
end)

RegisterServerEvent('esx_barbie_lyftupp:removeRope')
AddEventHandler('esx_barbie_lyftupp:removeRope', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.removeInventoryItem('Rope', 1)
	TriggerClientEvent('esx_barbie_lyftupp:trueUsedRope', source)
	
end)

RegisterServerEvent('cmg3_animations:sync')
AddEventHandler('cmg3_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	print("got to srv cmg3_animations:sync")
	print("got that fucking attach flag as: " .. tostring(attachFlag))
	TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
	print("triggering to target: " .. tostring(targetSrc))
	TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg3_animations:stop')
AddEventHandler('cmg3_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
end)

RegisterServerEvent('esx_barbie_lyftupp:lyfter')
AddEventHandler('esx_barbie_lyftupp:lyfter', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('esx_barbie_lyftupp:upplyft', targetPlayer.source, source)
end)

RegisterServerEvent('cmg2_animations:stop')
AddEventHandler('cmg2_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg2_animations:cl_stop', targetSrc)
end)

RegisterServerEvent('esx_barbie_lyftupp:lyfteruppn')
AddEventHandler('esx_barbie_lyftupp:lyfteruppn', function(source)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, {type='error', text = 'Biri seni kucaklıyor'})

end)

RegisterServerEvent('esx_barbie_lyftupp:sync')
AddEventHandler('esx_barbie_lyftupp:sync', function(target, animationLib, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	print("got to srv esx_barbie_lyftupp:sync")
	TriggerClientEvent('esx_barbie_lyftupp:syncTarget', targetSrc, source, animationLib, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
	print("triggering to target: " .. tostring(targetSrc))
	TriggerClientEvent('esx_barbie_lyftupp:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg2_animations:sync')
AddEventHandler('cmg2_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	print("got to srv cmg2_animations:sync")
	TriggerClientEvent('cmg2_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
	print("triggering to target: " .. tostring(targetSrc))
	TriggerClientEvent('cmg2_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('esx_barbie_lyftupp:stop')
AddEventHandler('esx_barbie_lyftupp:stop', function(targetSrc)
	TriggerClientEvent('esx_barbie_lyftupp:cl_stop', targetSrc)
end)

print('esx_lyftupp_piggyback 1.0 by AOTCARIBBEAN')

