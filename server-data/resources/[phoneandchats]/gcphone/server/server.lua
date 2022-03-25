
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

math.randomseed(os.time()) 

--- Phone Number Style Config.lua FourDigit = true then generate 4 number else generate ####### number
function getPhoneRandomNumber()
    if Config.FourDigit then
        local numBase = math.random(1000,9999)
        num = string.format("%04d", numBase )
    else
        local numBase = math.random(1000000,9999999)
        num = string.format("%07d", numBase)
    end
	return num
end

ESX.RegisterUsableItem('phone', function(source)
	
	TriggerClientEvent('gc:use', source)
end)

--====================================================================================
--  Utils
--====================================================================================
function getSourceFromIdentifier(identifier, cb)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if(xPlayer.identifier ~= nil and xPlayer.identifier == identifier) or (xPlayer.identifier == identifier) then
			cb(xPlayer.source)
			return
		end
	end
	cb(nil)
end

function getNumberPhone(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result ~= nil then
        return result[1].phone_number
    end
    return nil
end



function getAppsCntrl(identifier)
    local result = MySQL.Sync.fetchAll("SELECT phone_settings.hex FROM phone_settings WHERE phone_settings.hex = @hex", {
        ['@hex'] = identifier
    })
    if result[1] == nil then
        return nil
    else
        return 'var'
    end
end

function getIdentifierByPhoneNumber(phone_number) 
    local result = MySQL.Sync.fetchAll("SELECT users.identifier FROM users WHERE users.phone_number = @phone_number", {
        ['@phone_number'] = phone_number
    })
    if result[1] ~= nil then
        return result[1].identifier
    end
    return nil
end

function getBlockNumber(identifier, number)
    local result = MySQL.Sync.fetchAll("SELECT phone_blockednumber.hex FROM phone_blockednumber WHERE phone_blockednumber.identifier = @identifier AND phone_blockednumber.number = @number", {
        ['@identifier'] = identifier,
        ['@number'] = number
    })
    if result[1] == nil then
        return nil
    else
        return 'var'
    end
end

RegisterServerEvent("gcPhone:alNumber")
AddEventHandler("gcPhone:alNumber",function(a,b,c,d)
    local src = source
    local e = ESX.GetPlayerFromId(src)
    local ident = getIdentifierByPhoneNumber(a)
    if e then
        MySQL.Async.insert('INSERT INTO phone_blockednumber (`identifier`, `hex`, `number`) VALUES(@identifier, @hex, @number);', {
            ['@identifier'] = e.identifier,
            ['@hex'] = ident,
            ['@number'] = a,
        }, function (result)
        
            TriggerClientEvent('yenNumber', e.source,a,b)
    
        end)
    end
end)

function SimIdenfier(phone_number) 
    local result = MySQL.Sync.fetchAll("SELECT sim.identifier FROM sim WHERE sim.phone_number = @phone_number", {
        ['@phone_number'] = phone_number
    })
    if result[1] ~= nil then
        return result[1].identifier
    end
    return nil
end

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

function getOrGeneratePhoneNumber (identifier, cb)
    local identifier = identifier
    local myPhoneNumber = getNumberPhone(identifier)
   
    if myPhoneNumber == '0' or myPhoneNumber == nil then
        repeat
            myPhoneNumber = getPhoneRandomNumber()
            local id = getIdentifierByPhoneNumber(myPhoneNumber)
        until id == nil
        MySQL.Async.insert("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", { 
            ['@myPhoneNumber'] = myPhoneNumber,
            ['@identifier'] = identifier
        }, function ()
            cb(myPhoneNumber)
        end)
    else
        cb(myPhoneNumber)
    end
end

function getAppsControl (identifier)
    local identifier = identifier
    local myPhoneNumber = getAppsCntrl(identifier)
    if myPhoneNumber == '0' or myPhoneNumber == nil then
        MySQL.Async.insert("INSERT INTO phone_settings (`hex`, `app`,`crypto`) VALUES(@hex, @app, @crypto)", { 
            ['@crypto'] = Config.cryto,
            ['@app'] = Config.app,
            ['@hex'] = identifier
        }, function ()
        end)
    end
end
--====================================================================================
--  Contacts
--====================================================================================
function getContacts(identifier)
    local result = MySQL.Sync.fetchAll("SELECT phone_users_contacts.* FROM phone_users_contacts WHERE phone_users_contacts.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    return result
end

function addContact(source, identifier, number, display, avatar)
    local sourcePlayer = tonumber(source)
    MySQL.Async.insert("INSERT INTO phone_users_contacts (`identifier`, `number`,`display`,`avatar`) VALUES(@identifier, @number, @display, @avatar)", {
        ['@identifier'] = identifier,
        ['@number'] = number,
        ['@display'] = display,
		['@avatar'] = avatar,
    },function()
        notifyContactChange(sourcePlayer, identifier)
    end)
end

function updateContact(source, identifier, id, number, display, avatar)
    local sourcePlayer = tonumber(source)
    MySQL.Async.insert("UPDATE phone_users_contacts SET number = @number, display = @display, avatar = @avatar WHERE id = @id", { 
        ['@number'] = number,
        ['@display'] = display,
		['@avatar'] = avatar,
        ['@id'] = id,
    },function()
        notifyContactChange(sourcePlayer, identifier)
    end)
end

function ProfilChange(source, identifier, avatar_url)
    local sourcePlayer = tonumber(source)
    MySQL.Async.insert("UPDATE users SET avatar_url = @avatar_url WHERE identifier = @identifier", { 
        ['@avatar_url'] = avatar_url,
        ['@identifier'] = identifier
    },function()
    end)
end

ESX.RegisterServerCallback('gcPhone:getAvatar', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local myPhoneNumber = getNumberPhone(xPlayer.identifier)
	MySQL.Async.fetchAll('SELECT avatar_url FROM users WHERE `phone_number` = @myPhoneNumber',{["@myPhoneNumber"] = myPhoneNumber},function(result)
		local avatar = {}
		for i=1, #result, 1 do
			table.insert(avatar, {avatar_url = result[i].avatar_url}) 
		end
		cb(avatar)
	end)
end)


RegisterServerEvent('gcPhone:avatarChange')
AddEventHandler('gcPhone:avatarChange', function(avatar_url)
    local _source = source
    local sourcePlayer = tonumber(_source)
    xPlayer = ESX.GetPlayerFromId(_source)
    identifier = xPlayer.identifier
    ProfilChange(sourcePlayer, identifier, avatar_url)
end)

function deleteContact(source, identifier, id)
    local sourcePlayer = tonumber(source)
    MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id", {
        ['@identifier'] = identifier,
        ['@id'] = id,
    })
    notifyContactChange(sourcePlayer, identifier)
end

function deleteAllContact(identifier)
    MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier", {
        ['@identifier'] = identifier
    })
end

function notifyContactChange(source, identifier)
    local sourcePlayer = tonumber(source)
    local identifier = identifier
    if sourcePlayer ~= nil then 
        TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
    end
end

ESX.RegisterServerCallback('gcPhone:phone-check', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return; end
    for k, v in pairs(Config.Phones) do
        local items = xPlayer.getInventoryItem(v)
        if items.count > 0 then
            cb(v)
            return
        end
	end
    cb(nil)
end)

ESX.RegisterServerCallback('gcPhone:item-check', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return; end
    local items = xPlayer.getInventoryItem(data)
    cb(items.count)
end)

RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact', function(display, phoneNumber, avatar)
    local _source = source
    local sourcePlayer = tonumber(_source)
    xPlayer = ESX.GetPlayerFromId(_source)
    identifier = xPlayer.identifier
    addContact(sourcePlayer, identifier, phoneNumber, display, avatar)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact', function(id, display, phoneNumber, avatar)
    local _source = source
    local sourcePlayer = tonumber(_source)
    xPlayer = ESX.GetPlayerFromId(_source)
    identifier = xPlayer.identifier
    updateContact(sourcePlayer, identifier, id, phoneNumber, display, avatar)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact', function(id)
    local _source = source
    local sourcePlayer = tonumber(_source)
	xPlayer = ESX.GetPlayerFromId(_source)
    identifier = xPlayer.identifier
    deleteContact(sourcePlayer, identifier, id)
end)

--====================================================================================
--  Messages
--====================================================================================

function getMessages(identifier)
    local result = MySQL.Sync.fetchAll("SELECT phone_messages.*, users.phone_number FROM phone_messages LEFT JOIN users ON users.identifier = @identifier WHERE phone_messages.receiver = users.phone_number", {
         ['@identifier'] = identifier
    })
  --  print(json.encode(result))
    return result
end
--[[
function getMessages(num)
    local result = MySQL.Sync.fetchAll("SELECT * FROM phone_messages WHERE phone_messages.receiver = @num ORDER BY time DESC LIMIT 30", {
        ['@num'] = num
    })
    return result
end]]--

RegisterServerEvent('gcPhone:_internalAddMessage')
AddEventHandler('gcPhone:_internalAddMessage', function(transmitter, receiver, message, owner, cb)
    cb(_internalAddMessage(transmitter, receiver, message, owner))
end)

function _internalAddMessage(transmitter, receiver, message, owner)
    MySQL.Async.insert("INSERT INTO phone_messages (`transmitter`, `receiver`,`message`, `isRead`,`owner`) VALUES(@transmitter, @receiver, @message, @isRead, @owner)", {
        ['@transmitter'] = transmitter,
        ['@receiver'] = receiver,
        ['@message'] = message,
        ['@isRead'] = owner,
        ['@owner'] = owner
    })
    local data = {message = message, time = tonumber(os.time().."000.0"), receiver = receiver, transmitter = transmitter, owner = owner, isRead = owner}
    return data
end

function addMessage(source, identifier, phone_number, message)
    local sourcePlayer = tonumber(source)
    local otherIdentifier = SimIdenfier(phone_number)
    local myPhone = getNumberPhone(identifier)
    local BlckNumber = getBlockNumber(otherIdentifier, myPhone)
    if Config.BlockNumber then
        if BlckNumber == 'var' then
            TriggerClientEvent('esx:showNotification', sourcePlayer, _U('blcknumber_call'))
        else
            if otherIdentifier ~= nil then 
                local tomess = _internalAddMessage(myPhone, phone_number, message, 0)
                getSourceFromIdentifier(otherIdentifier, function (osou)
                    if tonumber(osou) ~= nil then 
                        TriggerClientEvent("gcPhone:receiveMessage", tonumber(osou), tomess)
                    end
                end) 
            end
            local memess = _internalAddMessage(phone_number, myPhone, message, 1)
            TriggerClientEvent("gcPhone:receiveMessage", sourcePlayer, memess)
        end
    else
        if otherIdentifier ~= nil then 
            local tomess = _internalAddMessage(myPhone, phone_number, message, 0)
            getSourceFromIdentifier(otherIdentifier, function (osou)
                if tonumber(osou) ~= nil then 
                    TriggerClientEvent("gcPhone:receiveMessage", tonumber(osou), tomess)
                end
            end) 
        end
        local memess = _internalAddMessage(phone_number, myPhone, message, 1)
        TriggerClientEvent("gcPhone:receiveMessage", sourcePlayer, memess)
    end


end

function setReadMessageNumber(identifier, num)
    local mePhoneNumber = getNumberPhone(identifier)
    MySQL.Async.execute("UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter", { 
        ['@receiver'] = mePhoneNumber,
        ['@transmitter'] = num
    })
end

function deleteMessage(msgId)
    MySQL.Async.execute("DELETE FROM phone_messages WHERE `id` = @id", {
        ['@id'] = msgId
    })
end

function deleteAllMessageFromPhoneNumber(source, identifier, phone_number)
    local source = source
    local identifier = identifier
    local mePhoneNumber = getNumberPhone(identifier)
    MySQL.Async.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number", {
        ['@mePhoneNumber'] = mePhoneNumber,['@phone_number'] = phone_number
    })
end

function deleteAllMessage(identifier)
    local mePhoneNumber = getNumberPhone(identifier)
    MySQL.Async.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber", {
        ['@mePhoneNumber'] = mePhoneNumber
    })
end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(phoneNumber, message)
    local _source = source
    local sourcePlayer = tonumber(_source)
	xPlayer = ESX.GetPlayerFromId(_source)
    identifier = xPlayer.identifier
    addMessage(sourcePlayer, identifier, phoneNumber, message)
end)

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage', function(msgId)
    deleteMessage(msgId)
end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber', function(number)
    local _source = source
    local sourcePlayer = tonumber(_source)
    xPlayer = ESX.GetPlayerFromId(_source)
    identifier = xPlayer.identifier
    deleteAllMessageFromPhoneNumber(sourcePlayer,identifier, number)
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage', function()
    local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
    identifier = xPlayer.identifier
    deleteAllMessage(identifier)
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber', function(num)
    local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
    identifier = xPlayer.identifier
    setReadMessageNumber(identifier, num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL', function()
    local _source = source
    local sourcePlayer = tonumber(_source)
	xPlayer = ESX.GetPlayerFromId(_source)
    identifier = xPlayer.identifier
    deleteAllMessage(identifier)
    deleteAllContact(identifier)
    appelsDeleteAllHistorique(identifier)
    TriggerClientEvent("gcPhone:contactList", sourcePlayer, {})
    TriggerClientEvent("gcPhone:allMessage", sourcePlayer, {})
    TriggerClientEvent("appelsDeleteAllHistorique", sourcePlayer, {})
end)

--====================================================================================
--  Gestion des appels
--====================================================================================
local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

function getHistoriqueCall(num)
    local result = MySQL.Sync.fetchAll("SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 30", {
        ['@num'] = num
    })
    return result
end

function sendHistoriqueCall(src, num) 
    local histo = getHistoriqueCall(num)
    TriggerClientEvent('gcPhone:historiqueCall', src, histo)
end

function saveAppels (appelInfo)
    if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
        MySQL.Async.insert("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.transmitter_num,
            ['@num'] = appelInfo.receiver_num,
            ['@incoming'] = 1,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            notifyNewAppelsHisto(appelInfo.transmitter_src, appelInfo.transmitter_num)
        end)
    end
    if appelInfo.is_valid == true then
        local num = appelInfo.transmitter_num
        if appelInfo.hidden == true then
            mun = "#######"
        end
        MySQL.Async.insert("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.receiver_num,
            ['@num'] = num,
            ['@incoming'] = 0,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            if appelInfo.receiver_src ~= nil then
                notifyNewAppelsHisto(appelInfo.receiver_src, appelInfo.receiver_num)
            end
        end)
    end
end

function notifyNewAppelsHisto (src, num) 
    sendHistoriqueCall(src, num)
end

RegisterServerEvent('gcPhone:getHistoriqueCall')
AddEventHandler('gcPhone:getHistoriqueCall', function()
    local _source = source
    local sourcePlayer = tonumber(_source)
	xPlayer = ESX.GetPlayerFromId(_source)
    identifier = xPlayer.identifier
    local srcPhone = getNumberPhone(srcIdentifier)
    sendHistoriqueCall(sourcePlayer, num)
end)

RegisterServerEvent('gcPhone:internal_startCall')
AddEventHandler('gcPhone:internal_startCall', function(source, phone_number, rtcOffer, extraData)

    
    local rtcOffer = rtcOffer
    if phone_number == nil or phone_number == '' then 
        print('BAD CALL NUMBER IS NIL')
        return
    end

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end

    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local sourcePlayer = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local srcIdentifier = xPlayer.identifier

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(srcIdentifier)
    end
    local destPlayer = getIdentifierByPhoneNumber(phone_number)
    local BlckNumber = getBlockNumber(destPlayer, srcPhone)
    local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = destPlayer ~= nil,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
    }
if Config.CallPhone then
    local xPlayer = ESX.GetPlayerFromIdentifier(destPlayer)
    
    if not xPlayer then 
        TriggerClientEvent('esx:showNotification', sourcePlayer, _U('offline_call'))
    return
    end
    local i1 = xPlayer.getInventoryItem('phone')
    if i1.count >= 1 then   
       if Config.BlockNumber then   
   
        if BlckNumber == 'var' then   
            TriggerClientEvent('esx:showNotification', sourcePlayer, _U('blcknumber_call'))
            else
                if is_valid == true then
                    getSourceFromIdentifier(destPlayer, function (srcTo)
                        if srcTo ~= nil then
                            AppelsEnCours[indexCall].receiver_src = srcTo
                            TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                            TriggerClientEvent('gcPhone:waitingCall', srcTo, AppelsEnCours[indexCall], false) -- karşı oyuncuyu arama
                            TriggerClientEvent('gcPhone:TgiannSes', -1, srcTo)
                        else
                            TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                        end
                    end)
                    else
                        TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                    end
            end
        else
            if is_valid == true then
                getSourceFromIdentifier(destPlayer, function (srcTo)
                    if srcTo ~= nil then
                        AppelsEnCours[indexCall].receiver_src = srcTo
                        TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                        TriggerClientEvent('gcPhone:waitingCall', srcTo, AppelsEnCours[indexCall], false) -- karşı oyuncuyu arama
                        TriggerClientEvent('gcPhone:TgiannSes', -1, srcTo)
                    else
                        TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                    end
                end)
                else
                    TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
            end
        end
    else 
        TriggerClientEvent('esx:showNotification', sourcePlayer, _U('nophone_call'))
    
    end

else

    if Config.BlockNumber then
        if BlckNumber == 'var' then
            TriggerClientEvent('esx:showNotification', sourcePlayer, _U('blcknumber_call'))
        else
            if is_valid == true then
                getSourceFromIdentifier(destPlayer, function (srcTo)
                    if srcTo ~= nil then
                        AppelsEnCours[indexCall].receiver_src = srcTo
                        TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                        TriggerClientEvent('gcPhone:waitingCall', srcTo, AppelsEnCours[indexCall], false) -- karşı oyuncuyu arama
                        TriggerClientEvent('gcPhone:TgiannSes', -1, srcTo)
                    else
                        TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                    end
                end)
            else
                TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
            end
        end
    else
        if is_valid == true then
            getSourceFromIdentifier(destPlayer, function (srcTo)
                if srcTo ~= nil then
                    AppelsEnCours[indexCall].receiver_src = srcTo
                    TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                    TriggerClientEvent('gcPhone:waitingCall', srcTo, AppelsEnCours[indexCall], false) -- karşı oyuncuyu arama
                    TriggerClientEvent('gcPhone:TgiannSes', -1, srcTo)
                else
                    TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                end
            end)
        else
            TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
        end
    end
end
end)

RegisterServerEvent('gcPhone:startCall')
AddEventHandler('gcPhone:startCall', function(phone_number, rtcOffer, extraData)
    TriggerEvent('gcPhone:internal_startCall', source, phone_number, rtcOffer, extraData)
end)

RegisterServerEvent('gcPhone:candidates')
AddEventHandler('gcPhone:candidates', function (callId, candidates)
    if AppelsEnCours[callId] ~= nil then
        local source = source
        local to = AppelsEnCours[callId].transmitter_src
        if source == to then 
            to = AppelsEnCours[callId].receiver_src
        end
        TriggerClientEvent('gcPhone:candidates', to, candidates)
    end
end)

RegisterServerEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall', function(infoCall, rtcAnswer)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onAcceptFixePhone(source, infoCall, rtcAnswer)
            return
        end
        AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
        if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src ~= nil then
            AppelsEnCours[id].is_accepts = true
            AppelsEnCours[id].rtcAnswer = rtcAnswer
            TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
            SetTimeout(1000, function()
                if AppelsEnCours[id].receiver_src ~= nil and AppelsEnCours[id] ~= nil then
                    TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
                end
            end)
            TriggerClientEvent("gcPhone:stop-call-sound", -1, AppelsEnCours[id].receiver_src)
            saveAppels(AppelsEnCours[id])

            if Config.SaltyChat then
                exports['saltychat']:EstablishCall(AppelsEnCours[id].receiver_src, AppelsEnCours[id].transmitter_src)
                exports['saltychat']:EstablishCall(AppelsEnCours[id].transmitter_src, AppelsEnCours[id].receiver_src)
            end
        end
    end
end)

RegisterServerEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall', function (infoCall)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onRejectFixePhone(source, infoCall)
            return
        end
        if AppelsEnCours[id].transmitter_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
            if Config.SaltyChat then
                exports['saltychat']:EndCall(AppelsEnCours[id].receiver_src, AppelsEnCours[id].transmitter_src)
                exports['saltychat']:EndCall(AppelsEnCours[id].transmitter_src, AppelsEnCours[id].receiver_src)
            end
        end
        if AppelsEnCours[id].receiver_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].receiver_src)
            if Config.SaltyChat then
                exports['saltychat']:EndCall(AppelsEnCours[id].receiver_src, AppelsEnCours[id].transmitter_src)
                exports['saltychat']:EndCall(AppelsEnCours[id].transmitter_src, AppelsEnCours[id].receiver_src)
            end
        end

        if AppelsEnCours[id].is_accepts == false then 
            saveAppels(AppelsEnCours[id])
        end
        TriggerClientEvent("gcPhone:stop-call-sound", -1, AppelsEnCours[id].receiver_src)
        TriggerEvent('gcPhone:removeCall', AppelsEnCours)
        AppelsEnCours[id] = nil
    end
end)

RegisterServerEvent('gcPhone:appelsDeleteHistorique')
AddEventHandler('gcPhone:appelsDeleteHistorique', function (numero)
    local _source = source
    local sourcePlayer = tonumber(_source)
	local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    local srcPhone = getNumberPhone(identifier)
    MySQL.Async.execute("DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num", {
        ['@owner'] = srcPhone,
        ['@num'] = numero
    })
end)

function appelsDeleteAllHistorique(srcIdentifier)
    local srcPhone = getNumberPhone(srcIdentifier)
    MySQL.Async.execute("DELETE FROM phone_calls WHERE `owner` = @owner", {
        ['@owner'] = srcPhone
    })
end

RegisterServerEvent('gcPhone:appelsDeleteAllHistorique')
AddEventHandler('gcPhone:appelsDeleteAllHistorique', function ()
    local _source = source
    local sourcePlayer = tonumber(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    appelsDeleteAllHistorique(srcIdentifier)
end)

--====================================================================================
--  OnLoad
--====================================================================================

RegisterCommand('telfix', function(source)
    TriggerEvent('gcPhon:onPlayerLoaded', source)
end)

function onCallFixePhone (source, phone_number, rtcOffer, extraData)
    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end
    local sourcePlayer = tonumber(source)
	xPlayer = ESX.GetPlayerFromId(_source)
    srcIdentifier = xPlayer.identifier

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(srcIdentifier)
    end

    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = false,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData,
        coords = FixePhone[phone_number].coords
    }
    
    PhoneFixeInfo[indexCall] = AppelsEnCours[indexCall]

    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
end

function onAcceptFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    
    AppelsEnCours[id].receiver_src = source
    if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
        AppelsEnCours[id].is_accepts = true
        AppelsEnCours[id].forceSaveAfter = true
        AppelsEnCours[id].rtcAnswer = rtcAnswer
        PhoneFixeInfo[id] = nil
        TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
        TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
	SetTimeout(1000, function() -- change to +1000, if necessary.
       		TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
	end)
        saveAppels(AppelsEnCours[id])
    end
end

function onRejectFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    PhoneFixeInfo[id] = nil
    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
    if AppelsEnCours[id].is_accepts == false then
        saveAppels(AppelsEnCours[id])
    end
    AppelsEnCours[id] = nil
    
end

AddEventHandler('esx:playerLoaded',function(playerId, xPlayer)
    local sourcePlayer = playerId
    local identifier = xPlayer.identifier
    local num = getNumberPhone(identifier)
	getOrGeneratePhoneNumber(identifier, function (myPhoneNumber)
        TriggerClientEvent('gcPhone:myPhoneNumber', sourcePlayer, myPhoneNumber)
        TriggerClientEvent('gcPhone:contactList', sourcePlayer, getContacts(identifier))
        TriggerClientEvent('gcPhone:allMessage', sourcePlayer, getMessages(identifier))
        sendHistoriqueCall(sourcePlayer, num)
    end)
    getAppsControl(identifier)
    TriggerEvent('gcPhon:onPlayerLoaded', source)
end)

RegisterServerEvent('gcPhon:onPlayerLoaded')
AddEventHandler('gcPhon:onPlayerLoaded',function(source)
    local _source = source
    local sourcePlayer = tonumber(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    while xPlayer == nil do
        xPlayer = ESX.GetPlayerFromId(_source)
        Citizen.Wait(10000)
    end
    local identifier = xPlayer.identifier
    local num = getNumberPhone(identifier)
	local fst = getFirstname(identifier)
    local lst = getLastname(identifier)
	TriggerClientEvent("gcPhone:firstname", sourcePlayer, fst)
	TriggerClientEvent("gcPhone:lastname", sourcePlayer, lst)
    TriggerEvent("Server_gcPhone:getlicense", sourcePlayer)
    TriggerClientEvent('gcPhone:allMessage', sourcePlayer, getMessages(identifier))
    TriggerClientEvent("gcPhon:updatePhone", sourcePlayer, num, getContacts(identifier), getMessages(identifier))
	sendHistoriqueCall(sourcePlayer, num)
end)



