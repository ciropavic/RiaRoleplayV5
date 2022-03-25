ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('SB:getNewsForPhone', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM phone_news',{},function(result)
		local haberler = {}
		for i=1, #result, 1 do
			table.insert(haberler, {id = result[i].id,haber=result[i].haber, baslik = result[i].baslik, resim = result[i].resim, video = result[i].video, zaman = result[i].zaman}) 
		end
		cb(haberler)
	end)
end)

ESX.RegisterServerCallback('SB:wanted', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM epc_bolos',{},function(result)
		local wanted = {}
		for i=1, #result, 1 do
			table.insert(wanted, {id = result[i].id,name=result[i].name, lastname = result[i].lastname, created_at = result[i].created_at}) 
		end
		cb(wanted)
	end)
end)



ESX.RegisterServerCallback('gcPhone:getCrypto', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return; end
	MySQL.Async.fetchAll("SELECT * FROM phone_settings WHERE `hex` = @cid",{
	    ["@cid"] = xPlayer.identifier,
		},function(result)

		cb(result[1].app)
	end)
end)

RegisterServerEvent("gcPhone:buyCrypto")
AddEventHandler("gcPhone:buyCrypto",function(a,b)
    local e=ESX.GetPlayerFromId(source)
    if not e then
         return 
        end;
         local g={}
         MySQL.Async.fetchAll("SELECT * FROM phone_settings WHERE hex = @identifier",{["@identifier"]=e.identifier},function(h)
			g=json.decode(h[1].app)
			if a==1 then 

				for k,v in pairs(g) do

					if v.name.routeName == b then
	
						v.name.active = false

					end
				end
                TriggerClientEvent("updateCrypto",e.source,b)
			elseif a==2 then 
				for k,v in pairs(g) do
					if v.name.routeName == b then

						v.name.active = true

					end
				end
                 TriggerClientEvent("updateCrypto",e.source,b)
            else print("phone coin error because SOB LilBecha"..e.identifier)
                return 
            end;
            MySQL.Async.fetchAll("UPDATE phone_settings SET app = @crypto WHERE hex = @identifier",{["@identifier"]=e.identifier,["@crypto"]=json.encode(g)})
        end)
	end)

	ESX.RegisterServerCallback('gcphone:blocknumber', function(source, cb)
		local e=ESX.GetPlayerFromId(source)
		MySQL.Async.fetchAll('SELECT * FROM phone_blockednumber WHERE identifier = @identifier',{["@identifier"]=e.identifier},function(result)
			local bnumber = {}
			for i=1, #result, 1 do
				table.insert(bnumber, {id = result[i].id, number = result[i].number}) 
			end
			cb(bnumber)
		end)
	end)
	

	ESX.RegisterServerCallback('gcphone:getphonegallery', function(source, cb)
		local e=ESX.GetPlayerFromId(source)
		MySQL.Async.fetchAll('SELECT * FROM phone_gallery WHERE hex = @identifier ORDER BY TIME DESC',{["@identifier"]=e.identifier},function(result)
			local gallery = {}
			for i=1, #result, 1 do
				table.insert(gallery, {id = result[i].id,	image=result[i].image}) 
			end
			cb(gallery)
		end)
	end)


RegisterServerEvent('gcPhone:gallerimage')
AddEventHandler('gcPhone:gallerimage', function(a)
	local src = source
	local e = ESX.GetPlayerFromId(src)
    if e then
        MySQL.Async.insert('INSERT INTO phone_gallery (`hex`, `image`) VALUES(@identifier, @image);', {
            ['@identifier'] = e.identifier,
			['@image'] = a
		}, function (result)
		
			TriggerClientEvent('updategallery', e.source,a)

		end)
    end
end)



ESX.RegisterServerCallback('gcphone:getgps', function(source, cb)
	local e=ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM phone_gps WHERE hex = @identifier ORDER BY id DESC',{["@identifier"]=e.identifier},function(result)
		local gps = {}
		for i=1, #result, 1 do
			table.insert(gps, {id = result[i].id,	nott=result[i].nott, gps=result[i].gps}) 
		end
		cb(gps)
	end)
end)


RegisterServerEvent('gcPhone:newwgps')
AddEventHandler('gcPhone:newwgps', function(a, b)

local src = source
local e = ESX.GetPlayerFromId(src)
if e then
	MySQL.Async.insert('INSERT INTO phone_gps (`hex`, `nott`, `gps`) VALUES(@identifier, @nott, @gps);', {
		['@identifier'] = e.identifier,
		['@nott'] = a,
		['@gps'] = b,
	}, function (result)
	
		TriggerClientEvent('updategps', e.source,a,b)

	end)
end
end)

RegisterServerEvent('gcPhone:deltblknumber')
AddEventHandler('gcPhone:deltblknumber', function(a, b)

local src = source
local e = ESX.GetPlayerFromId(src)
if e then
	MySQL.Async.insert('DELETE FROM phone_blockednumber WHERE id = @id AND number = @number', {
		['@number'] = b,
		['@id'] = a
	}, function (result)
	
		TriggerClientEvent('yenNumber', e.source,a)

	end)
end
end)

RegisterServerEvent('gcPhone:delettegps')
AddEventHandler('gcPhone:delettegps', function(a, b)

local src = source
local e = ESX.GetPlayerFromId(src)
if e then
	MySQL.Async.insert('DELETE FROM phone_gps WHERE id = @id AND hex = @identifier', {
		['@identifier'] = e.identifier,
		['@id'] = a
	}, function (result)
	
		TriggerClientEvent('updategps', e.source,a)

	end)
end
end)

RegisterServerEvent('gcPhone:imagedelete')
AddEventHandler('gcPhone:imagedelete', function(a, b)

local src = source
local e = ESX.GetPlayerFromId(src)
if e then
	MySQL.Async.insert('DELETE FROM phone_gallery WHERE id = @id AND hex = @identifier', {
		['@identifier'] = e.identifier,
		['@id'] = a
	}, function (result)
	
		TriggerClientEvent('updategallery', e.source,a)

	end)
end
end)








ESX.RegisterServerCallback("gcPhone:getsCrypto",function(a,b)
    local d=ESX.GetPlayerFromId(a)
    if not d then 
        return 
    end;
    MySQL.Async.fetchAll("SELECT crypto FROM phone_settings WHERE hex = @identifier",{["@identifier"]=d.identifier},function(e)
		b(json.decode(e[1].crypto))
    end)
end)



RegisterServerEvent("gcPhone:alCrypto")
AddEventHandler("gcPhone:alCrypto",function(a,b,c,d)
	local _source = source
	local e=ESX.GetPlayerFromId(source)
	local f=ESX.Math.Round(c)
    if not e then
         return 
        end
         local g={}
         MySQL.Async.fetchAll("SELECT * FROM phone_settings WHERE hex = @identifier",{["@identifier"]=e.identifier},function(h)
			if f<0 then f=f*-1 
            end;
			g=json.decode(h[1].crypto)
            if a==1 then 
                if e.getAccount("bank").money>=d*f then 
                    e.removeAccountMoney("bank",d*f)g[b]=g[b]+f;
                    TriggerClientEvent("yenCrypto",e.source,b)
                else 
					TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
                end 
            elseif a==2 then 
                if g[b]>=f then 
                    e.addAccountMoney("bank",d*f)g[b]=g[b]-f;
                    TriggerClientEvent("yenCrypto",e.source,b)
                else 
					TriggerClientEvent('esx:showNotification', _source, _U('not_enough_coin'))
                end 
            else print("phone coin error because SOB LilBecha"..e.identifier)
                return 
            end
           MySQL.Async.fetchAll("UPDATE phone_settings SET crypto = @crypto WHERE hex = @identifier",{["@identifier"]=e.identifier,["@crypto"]=json.encode(g)})

	end)
	end)






