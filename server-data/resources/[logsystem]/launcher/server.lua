-----------------Kürşat Canciğer-----------------

local serveradi= 'aspendosrp'

local function OnPlayerConnecting(name, setKickReason, deferrals)
    deferrals.defer()
    deferrals.update(string.format("Merhaba %s. Launcher kontrolü sağlanıyor...", name))
	identifiers = GetPlayerIdentifiers(source)
	local hex = identifiers[1]

	if hex ~= nil then
	PerformHttpRequest('https://madsword.online/api/launcher/server/Kontrol.php?server='..serveradi..'&steam_hex='..hex..'', function(err, text, headers)
	local sonuc = text
	if sonuc == "yetkili" then
		deferrals.done()
	elseif sonuc == "yasakli" then
		deferrals.done('Bu sunucuda yasaklısın.')
	elseif sonuc == "var" then
		PerformHttpRequest('https://madsword.online/api/launcher/server/Kaydet.php', function(err, text2, headers)
		end, 'POST', json.encode({steam_hex = hex, server = serveradi}), { ['User-Agent'] = 'Luncher' })
		deferrals.done()
	elseif sonuc == "yok" then
		deferrals.done('Launcher kullanmıyorsun.')
	else
		deferrals.done('Launcher kullanmıyorsun.')
	end
	end, 'GET', "", { ['User-Agent'] = 'Luncher' })
	end
  
end

AddEventHandler("playerConnecting", OnPlayerConnecting)