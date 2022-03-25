ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local serverNotes = {}

RegisterServerEvent("server:destroyNote")
AddEventHandler("server:destroyNote", function(closestNoteId)
    table.remove(serverNotes,closestNoteId)
    TriggerClientEvent('client:updateNotesRemove', -1, closestNoteId)
end)

RegisterServerEvent("server:newNote")
AddEventHandler("server:newNote", function(text,x,y,z)
    serverNotes[#serverNotes+1] = { text = text, x = x, y = y, z = z }
    TriggerClientEvent('client:updateNotesAdd', -1, { text = text, x = x, y = y, z = z })
end)

RegisterServerEvent("server:requestNotes")
AddEventHandler("server:requestNotes", function()
    local src = source
    TriggerClientEvent('client:updateNotes', src, serverNotes)
end)


RegisterCommand('notdefteri', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem("notepade").count > 0 then
        TriggerClientEvent('Notepad:open', source)
        xPlayer.removeInventoryItem('notepade', 1)
    else
     TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Not defterin yok marketten alabilirsin',  length = 3000})    
    end
end)