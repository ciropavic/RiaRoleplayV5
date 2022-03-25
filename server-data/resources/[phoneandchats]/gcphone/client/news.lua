RegisterNUICallback('getNewsForPhone', function(data, cb)
  ESX.TriggerServerCallback('SB:getNewsForPhone', function(news)
    SendNUIMessage({event = 'news_updateNews', news = news})
  end)
end)


RegisterNUICallback('getWanted', function(data, cb)
  ESX.TriggerServerCallback('SB:wanted', function(wanted)
    SendNUIMessage({event = 'updateWanted', wanted = wanted})
  end)
end)


function setBlockNumber(bnumber)
  SendNUIMessage({event = 'bnumber_app', bnumber = bnumber})
end

RegisterNUICallback('GetBlockNumber', function(data, cb)
  ESX.TriggerServerCallback('gcphone:blocknumber', function(bnumber)
    setBlockNumber(bnumber)
  end)
end)


RegisterNUICallback('getAppGallery', function(data, cb)
  ESX.TriggerServerCallback('gcphone:getphonegallery', function(gallery)
    GalleryImage(gallery)
  end)
end)

RegisterNetEvent('updategallery')
AddEventHandler('updategallery', function(gallery)
    ESX.TriggerServerCallback('gcphone:getphonegallery', function(data)
      GalleryImage(data)
    end, gallery)
end)

function GalleryImage(gallery)
  SendNUIMessage({event = 'gallery_app', gallery = gallery})
end


RegisterNUICallback('getApps', function(data)
  ESX.TriggerServerCallback('gcPhone:getCrypto', function(data)
    setCrypto(data)
  end)
end)


function setCrypto(Kellos)
  Appsler = json.decode(Kellos)
  SendNUIMessage({event = 'cigetApps', Appsler = Appsler})
end



RegisterNetEvent('updateCrypto')
AddEventHandler('updateCrypto', function(coin)
    ESX.TriggerServerCallback('gcPhone:getCrypto', function(data)
        setCrypto(data)
    end, coin)
end)



RegisterNUICallback('getAppGPS', function(data, cb)
  ESX.TriggerServerCallback('gcphone:getgps', function(gps)
    GetGPS(gps)
  end)
end)

RegisterNUICallback('newgps', function(data)
  if data.gps == '%pos%' then
    local myPos = GetEntityCoords(PlayerPedId())
    data.gps = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('gcPhone:newwgps', data.nott, data.gps)
end)

RegisterNetEvent('updategps')
AddEventHandler('updategps', function(gps)
    ESX.TriggerServerCallback('gcphone:getgps', function(data)
      GetGPS(data)
    end)
end)


function GetGPS(gps)
  SendNUIMessage({event = 'gps_app', gps = gps})
end


function setkCrypto(mevcut)
  SendNUIMessage({event = 'yenCrypto', mevcut = mevcut})
end



RegisterNUICallback('getccCrypto', function(data)
  ESX.TriggerServerCallback('gcPhone:getsCrypto', function(data)
    setkCrypto(data)
  end)
end)


RegisterNetEvent('yenCrypto')
AddEventHandler('yenCrypto', function(coin)
  ESX.TriggerServerCallback('gcPhone:getsCrypto', function(data)
    setkCrypto(data)
  end, coin)
end)



RegisterNUICallback('GalleryFoto', function(data)
  TriggerServerEvent('gcPhone:gallerimage', data.image)
end)


RegisterNUICallback('GalleryDelete', function(data)
  TriggerServerEvent('gcPhone:imagedelete', data.id)
end)

RegisterNUICallback('Appindir', function(data)
  TriggerServerEvent('gcPhone:buyCrypto', data.test.islem, data.test.name)
end)

RegisterNUICallback('deletegps', function(data)
  TriggerServerEvent('gcPhone:delettegps', data.id)
end)


RegisterNUICallback('alCrypto', function(data)
TriggerServerEvent('gcPhone:alCrypto', data.islem, data.id, data.adet, data.fiyat)
end)

local useMilitaryTime = false

RegisterNUICallback('saat', function(data)
  hour = GetClockHours()
	minute = GetClockMinutes()

	if useMilitaryTime == false then
		if hour == 0 or hour == 24 then
			hour = 12
		elseif hour >= 13 then
			hour = hour - 12
		end
	end

	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
  timeText = hour ..':' ..minute;
  SendNUIMessage({event = 'emuncuk', timeText = timeText})
end)

RegisterNUICallback('deleteNumber', function(data)
  TriggerServerEvent('gcPhone:deltblknumber', data.id, data.number)
end)

RegisterNUICallback('alNumber', function(data)
  TriggerServerEvent('gcPhone:alNumber', data.number)
end)

RegisterNetEvent('yenNumber')
AddEventHandler('yenNumber', function()
  ESX.TriggerServerCallback('gcphone:blocknumber', function(data)
    setBlockNumber(data)
  end)
end)

