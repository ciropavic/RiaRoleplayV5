
radioActive = false
playerJob = {}
--[[
    THREADS
]]

Citizen.CreateThread(function()
    while playerJob.name == nil do
        TriggerServerEvent('frkn_radio:requestPData')
        Citizen.Wait(500)
    end
    generateFrequenceList()
    while true do
        Citizen.Wait(50)
        -- Init local vars
        local playerPed = PlayerPedId()
        local isBroadcasting = IsControlPressed(0, 137)
        local isPlayingBroadcastAnim = IsEntityPlayingAnim(playerPed, 'random@arrests', 'generic_radio_chatter', 3)

        if not Config.frequencies.playerAccess[Config.frequencies.current] and Config.frequencies.private[Config.frequencies.current] then
            setRadioFrequence(0)
            radioActive = false
            Config.frequencies.current = 0
        end

        if radioActive and isBroadcasting and not isPlayingBroadcastAnim then
            RequestAnimDict('random@arrests')

            while not HasAnimDictLoaded('random@arrests') do
                Citizen.Wait(150)
            end

            TaskPlayAnim(playerPed, 'random@arrests', 'generic_radio_chatter', 8.0, 0.0, -1, 49, 0, 0, 0, 0)
        elseif not isBroadcasting and isPlayingBroadcastAnim then
            StopAnimTask(playerPed, 'random@arrests', 'generic_radio_chatter', -4.0)
        end
    end
end)

--[[
    EVENTS
]]

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    playerJob = job

    if job.name == 'police' then
        giveAccess2PrivateFrequence(1, 2, 3, 4)
    elseif job.name == 'ambulance' then
        removeAccess2PrivateFrequence(1, 2, 3)
        giveAccess2PrivateFrequence(4, 5, 6)
    else
        removeAccess2PrivateFrequence(1, 2, 3, 4, 5, 6)
    end
end)

RegisterNetEvent('frkn_radio:loadPData')
AddEventHandler('frkn_radio:loadPData', function(job)
    playerJob = job

    if job.name == 'police' then
        giveAccess2PrivateFrequence(1, 2, 3, 6)
    elseif job.name == 'ambulance' then
        removeAccess2PrivateFrequence(1, 2, 3)
        giveAccess2PrivateFrequence(4, 5, 6)
    else
        removeAccess2PrivateFrequence(1, 2, 3, 4, 5, 6)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    playerJob = xPlayer.job

    if playerJob.name == 'police' then
        giveAccess2PrivateFrequence(1, 2, 3, 6)
    elseif playerJob.name == 'ambulance' then
        removeAccess2PrivateFrequence(1, 2, 3)
        giveAccess2PrivateFrequence(4, 5, 6)
    else
        removeAccess2PrivateFrequence(1, 2, 3, 4, 5, 6)
    end
end)

AddEventHandler("onClientResourceStart", function(resName)
    if GetCurrentResourceName() ~= resName and "mumble-voip" ~= resName then
        return
    end
    exports["mumble-voip"]:SetMumbleProperty("radioClickMaxChannel", Config.frequencies.max)
    exports["mumble-voip"]:SetMumbleProperty("radioEnabled", false)
end)

RegisterNetEvent('frkn_radio:openRadio')
AddEventHandler('frkn_radio:openRadio', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openUi',
        currentFrequence = Config.frequencies.current
    })
end)

--[[
    FUNCTIONS
]]

function setRadioFrequence(frq)
    exports['mumble-voip']:SetRadioChannel(frq)
end

function generateFrequenceList()
    Config.frequencies.list = {}

    for i = Config.frequencies.min, Config.frequencies.max do
        if not Config.frequencies.private[i] or Config.frequencies.playerAccess[i] then
            Config.frequencies.list[#Config.frequencies.list + 1] = i
        end
    end
end

function giveAccess2PrivateFrequence(...)
    local frequencies = { ... }
    local newFrequencies = {}

    for i = 1, #frequencies do
        local frequency = tonumber(frequencies[i])

        if frequency ~= nil then
            if Config.frequencies.private[frequency] then
                -- Check if frequency exists
                if not Config.frequencies.playerAccess[frequency] then
                    -- Only add new frequencies
                    newFrequencies[#newFrequencies + 1] = frequency
                end
            end
        end
    end

    if #newFrequencies > 0 then
        for i = 1, #newFrequencies do
            Config.frequencies.playerAccess[newFrequencies[i]] = true
        end

        generateFrequenceList()
    end
end

function removeAccess2PrivateFrequence(...)
    local frequencies = { ... }
    local removedFrequencies = {}

    for i = 1, #frequencies do
        local frequency = tonumber(frequencies[i])

        if frequency ~= nil then
            if Config.frequencies.playerAccess[frequency] then
                -- Check if player has access to frequency
                removedFrequencies[#removedFrequencies + 1] = frequency
            end
        end
    end

    if #removedFrequencies > 0 then
        for i = 1, #removedFrequencies do
            Config.frequencies.playerAccess[removedFrequencies[i]] = nil
        end

        generateFrequenceList()
    end
end

--[[
    NUI
]]

RegisterNUICallback('closeRadio', function(data, cb)
    SetNuiFocus(false, false)
    radioActive = false
    exports["mumble-voip"]:SetMumbleProperty("radioEnabled", false)
    setRadioFrequence(0)
    cb('ok')
end)

RegisterNUICallback('closeNui', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('updateFrequence', function(data, cb)
    local newFrequence = tonumber(data.frequence)
    if newFrequence ~= nil and newFrequence > 0 and newFrequence <= Config.frequencies.max then
        if newFrequence ~= Config.frequencies.current then
            exports["mumble-voip"]:SetMumbleProperty("radioEnabled", true)
            Config.frequencies.current = newFrequence
            setRadioFrequence(newFrequence)
            if radioActive ~= true then
                radioActive = true
            end
        end
    end
    cb('ok')
end)
