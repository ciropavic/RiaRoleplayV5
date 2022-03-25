--- Bu mod Fransua tarafından FivemTürk'e özel olarak paylaşılmıştır. Lütfen sağda solda benim diye dolaşmayın.
--- Bu mod Fransua tarafından FivemTürk'e özel olarak paylaşılmıştır. Lütfen sağda solda benim diye dolaşmayın.
--- Bu mod Fransua tarafından FivemTürk'e özel olarak paylaşılmıştır. Lütfen sağda solda benim diye dolaşmayın.


Citizen.CreateThread( function()
	
	while true do
	Wait(1)
	
	
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, false)
	local driver = GetPedInVehicleSeat(vehicle, -1)
	
	
			
	
	
	
	if IsPedInAnyVehicle(ped) then	
			
			
			
			if driver == ped and IsVehicleOnAllWheels(vehicle) then
			
				local GetHandlingfInitialDragCoeff = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff")
				local GetHandlingfDriveBiasFront = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDriveBiasFront')
				local GetHandlingfSteeringLock = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock")
				local GetHandlingfTractionCurveMax = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax")
				local GetHandlingfTractionCurveMin = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin")
				local GetHandlingfTractionCurveLateral = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral")
				local GetHandlingfLowSpeedTractionLossMult = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult")
			
				if IsControlJustReleased(0, 178) and ((GetVehicleClass(vehicle) == 0) or (GetVehicleClass(vehicle) == 1) or (GetVehicleClass(vehicle) == 2) or (GetVehicleClass(vehicle) == 3) or (GetVehicleClass(vehicle) == 4) or (GetVehicleClass(vehicle) == 5) or (GetVehicleClass(vehicle) == 6) or (GetVehicleClass(vehicle) == 7) or (GetVehicleClass(vehicle) == 9)) then
			
					if GetHandlingfInitialDragCoeff >= 50.0 then
						DriftOff()
					else
						DriftOn()
					end
				
			end	
			end
		else
		
		
		end
	end
end)

function DriftOff()
				local ped = GetPlayerPed(-1)
				local vehicle = GetVehiclePedIsIn(ped, false)
					
				local removeFromfInitialDragCoeff = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff")-90.22)
				local removeFromfDriveInertia = (GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fDriveInertia')-0.31)
				local removeFromfSteeringLock = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock")-22.0)
				local removeFromfTractionCurveMax = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax")+1.1)
				local removeFromfTractionCurveMin = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin")+0.4)
				local removeFromfTractionCurveLateral = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral")-2.5)
				local removeFromfLowSpeedTractionLossMult = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult")+0.57)
				local currentEngineMod = GetVehicleMod(vehicle, 11)
	
				    exports['mythic_notify']:SendAlert('inform',' TCS, ABS, EPS Açıldı. ', 2500, { ['background-color'] = '#00FFFF', ['color'] = '#000000' })			
					exports['mythic_notify']:SendAlert('inform',' Araç Standart Sürüş Modunda.', 2500, { ['background-color'] = '#00FFFF', ['color'] = '#000000' })
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff', removeFromfInitialDragCoeff)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDriveInertia', removeFromfDriveInertia)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fSteeringLock', removeFromfSteeringLock)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMax', removeFromfTractionCurveMax)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMin', removeFromfTractionCurveMin)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveLateral', removeFromfTractionCurveLateral)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fLowSpeedTractionLossMult', removeFromfLowSpeedTractionLossMult)
					SetVehicleEnginePowerMultiplier(vehicle, 0.0)					
					SetVehicleModKit(vehicle, 0)
					SetVehicleMod(vehicle, 11, currentEngineMod, true) 
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff"))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fDriveInertia'))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock"))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax"))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin"))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral"))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult"))
					print('stock')
				
	
end

function DriftOn()
			
				local ped = GetPlayerPed(-1)
				local vehicle = GetVehiclePedIsIn(ped, false)

				local addTofInitialDragCoeff = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff")+90.22)
				local addTofDriveInertia = (GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fDriveInertia')+0.31)
				local addTofSteeringLock = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock")+22.0)
				local addTofTractionCurveMax = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax")-1.1)
				local addTofTractionCurveMin = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin")-0.4)
				local addTofTractionCurveLateral = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral")+2.5)
				local addTofLowSpeedTractionLossMult = (GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult")-0.57)
				
					
		
				    exports['mythic_notify']:SendAlert('inform',' TCS, ABS, EPS Kapatıldı. ', 2500, { ['background-color'] = '#00FFFF', ['color'] = '#000000' })			
					exports['mythic_notify']:SendAlert('inform',' Kemerini Sıkı Bağla Drift Moduna Geçtin.', 2500, { ['background-color'] = '#00FFFF', ['color'] = '#000000' })
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDragCoeff', addTofInitialDragCoeff)

						if GetHandlingfDriveBiasFront == 0.0 then
							SetVehicleEnginePowerMultiplier(vehicle, 190.0)
						else
							SetVehicleEnginePowerMultiplier(vehicle, 100.0)
						end
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDriveInertia', addTofDriveInertia)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fSteeringLock', addTofSteeringLock)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMax', addTofTractionCurveMax)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMin', addTofTractionCurveMin)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveLateral', addTofTractionCurveLateral)
					SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fLowSpeedTractionLossMult', addTofLowSpeedTractionLossMult)
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff"))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fDriveInertia'))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fSteeringLock"))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMax"))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveMin"))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fTractionCurveLateral"))
					print(GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult"))
					print('drift')
				

end

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end



--- Bu mod Fransua tarafından FivemTürk'e özel olarak paylaşılmıştır. Lütfen sağda solda benim diye dolaşmayın.
--- Bu mod Fransua tarafından FivemTürk'e özel olarak paylaşılmıştır. Lütfen sağda solda benim diye dolaşmayın.
--- Bu mod Fransua tarafından FivemTürk'e özel olarak paylaşılmıştır. Lütfen sağda solda benim diye dolaşmayın.