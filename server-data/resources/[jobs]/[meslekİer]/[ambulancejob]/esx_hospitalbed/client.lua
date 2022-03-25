local Cinema, receptionPeds = false, {}

Citizen.CreateThread(function()
    while true do
        Wait(250)
        if Cinema then
            local hasActivated = false
            local waitedMS = 0.00
            DisplayRadar(false)
            while not hasActivated do
                Wait(5)
                waitedMS = waitedMS + 0.001
                DrawRect(0.5, -0.08+waitedMS, 1.0, 0.15, 0, 0, 0, 255)
                DrawRect(0.5, 1.08-waitedMS, 1.0, 0.15, 0, 0, 0, 255)
                if waitedMS > 0.105 then
                    hasActivated = true
                end
            end
            while Cinema do
                Wait(1)
                DrawRect(0.5, 0.025, 1.0, 0.15, 0, 0, 0, 255)
                DrawRect(0.5, 0.975, 1.0, 0.15, 0, 0, 0, 255)
            end
            while hasActivated do
                Wait(5)
                waitedMS = waitedMS - 0.001
                DrawRect(0.5, -0.08+waitedMS, 1.0, 0.15, 0, 0, 0, 255)
                DrawRect(0.5, 1.08-waitedMS, 1.0, 0.15, 0, 0, 0, 255)
                if waitedMS < 0 then
                    hasActivated = false
                end
            end
            DisplayRadar(true)
        end
    end
end)

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    for k, v in pairs(Config.Hospitals) do
        receptionPeds[k] = createPed(v.Peds.pedHash, v.Peds.reception.coords, v.Peds.reception.heading, false)  
        FreezeEntityPosition(receptionPeds[k], true) 
    end
    while true do
        local sleep = 250
        local me = PlayerPedId()
        if IsPedDeadOrDying(me) then
            sleep = 0
            for k, v in pairs(receptionPeds) do
                if DoesEntityExist(v) then
                    if GetDistanceBetweenCoords(GetEntityCoords(me), GetOffsetFromEntityInWorldCoords(v, 0.0, 2.0, 0.0), true) <= 5.5 then 
                        drawTxt((Strings['get_help']):format('~b~~h~[E]~h~~w~', Config.Price))
                        if IsControlJustReleased(0, 38) or IsDisabledControlJustReleased(0, 38) then
                            TriggerServerEvent('esx_beds:gethelp', k)
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end) 

RegisterNetEvent('esx_beds:revive')
AddEventHandler('esx_beds:revive', function(hospital)
    Cinema = true
    TriggerEvent('esx_ambulancejob:revive')
    TaskStartScenarioInPlace(receptionPeds[hospital], 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, false)
    local cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
    SetCamCoord(cam, GetOffsetFromEntityInWorldCoords(receptionPeds[hospital], 0.0, 1.5, 0.75))
    RenderScriptCams(1, 0, 0, 1, 1)
    PointCamAtEntity(cam, receptionPeds[hospital], 0.0, 0.0, 0.0, true)
    local timer = GetGameTimer() + 7500
    while timer >= GetGameTimer() do for i = 0, 31 do DisableAllControlActions(i) end Wait(0) end
    ClearPedTasks(receptionPeds[hospital])

    local ped, me = receptionPeds[hospital], PlayerPedId()
    while IsPedDeadOrDying(me) do Wait(0) end
    Wait(250)
    if DoesEntityExist(ped) then
        DoScreenFadeOut(750)
        while not IsScreenFadedOut() do Wait(0) end
        local doctor = createPed(Config.Hospitals[hospital].Peds.pedHash, Config.Hospitals[hospital].Peds.doctor.coords, Config.Hospitals[hospital].Peds.doctor.heading, true)
        FreezeEntityPosition(doctor, true)
        cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
        SetCamCoord(cam, GetOffsetFromEntityInWorldCoords(doctor, 0.0, -1.5, 0.5))
        RenderScriptCams(1, 0, 0, 1, 1)
        local dict = requestDict('anim@gangops@morgue@table@')
        DoScreenFadeIn(7500)
        local doctorDict = requestDict('mini@repair')
        timer = GetGameTimer() + Config.ReviveTime * 1000
        while timer >= GetGameTimer() do 
            if not IsEntityPlayingAnim(me, dict, 'ko_front', 3) then
                SetEntityCoords(me, Config.Hospitals[hospital].Bed.coords)
                SetEntityHeading(me, Config.Hospitals[hospital].Bed.heading)
                dict = requestDict('anim@gangops@morgue@table@')
                TaskPlayAnim(me, dict, 'ko_front', 8.0, -8.0, -1, 1, 0, false, false, false)
            end
            if not IsEntityPlayingAnim(doctor, doctorDict, 'fixing_a_ped', 3) then
                doctorDict = requestDict('mini@repair')
                TaskPlayAnim(doctor, doctorDict, 'fixing_a_ped', 8.0, -8.0, -1, 1, 0, false, false, false)
            end
            PointCamAtEntity(cam, me, 0.0, 0.0, 0.0, true)
            for i = 0, 31 do DisableAllControlActions(i) end
            local timeLeft = math.floor((timer-GetGameTimer())/1000)
            drawTxt((Strings['getting_help']):format(timeLeft))
            Wait(0) 
        end
        DoScreenFadeOut(750)
        while not IsScreenFadedOut() do Wait(0) end
        Cinema = false
        DeletePed(doctor)
        ClearPedTasks(me)
        RenderScriptCams(false, false, 0, true, false)
        DestroyCam(cam)
        SetEntityCoords(me, GetOffsetFromEntityInWorldCoords(receptionPeds[hospital], 0.0, 2.0, 0.0))
        DoScreenFadeIn(1500)
    end
end)

RegisterNetEvent('esx_beds:notify')
AddEventHandler('esx_beds:notify', function(txt)
    local timer = GetGameTimer() + 7000
    while timer >= GetGameTimer() do
        drawTxt(txt)
        Wait(0)
    end
end)

requestDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

drawTxt = function(text)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.95)
end

createPed = function(hash, coords, heading, networked)
    while not HasModelLoaded(hash) do Wait(0) RequestModel(hash) end
    local ped = CreatePed(4, hash, coords, heading, networked, false)
    SetEntityAsMissionEntity(ped, true, true)
    SetEntityInvincible(ped, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    return ped
end
