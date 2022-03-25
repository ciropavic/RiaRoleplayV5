local blips = {
  
}
	
Citizen.CreateThread(function()

  for _, info in pairs(blips) do
	info.blip = AddBlipForCoord(info.x, info.y, info.z)
	SetBlipSprite(info.blip, info.id)
	SetBlipDisplay(info.blip, 0.7)
	SetBlipScale(info.blip, 0.7)
	SetBlipColour(info.blip, info.colour)
	SetBlipAsShortRange(info.blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(info.title)
	EndTextCommandSetBlipName(info.blip)
  end
end)




function CreateBlipCircle(coords, text,scale, radius, color, sprite )
  local blip = AddBlipForRadius(coords, radius)

  SetBlipHighDetail(blip, true)
  SetBlipColour(blip, 1)
  SetBlipAlpha (blip, 128)

  blip = AddBlipForCoord(coords)

  SetBlipHighDetail(blip, true)
  SetBlipSprite (blip, sprite)
  SetBlipScale  (blip, scale)
  SetBlipPriority (blip,255)
  SetBlipColour (blip, color)
  SetBlipAsShortRange(blip, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
  for k,zone in pairs(CircleZones) do
	  CreateBlipCircle(zone.coords, zone.name,zone.scale ,zone.radius, zone.color, zone.sprite)
  end
end)

CircleZones = {  -- Kırmızı Bölgeler || Etrafında çember çıkmasın istiyorsan radius'u 0.0 yap
  --Ornek = {coords = vector3(x,y,z), name = 'Ornek',scale= 0.8, color = 27, sprite = 310, radius = 125.0},
  Grove = {coords = vector3(-136.4,-1589.5,34.8 ), name = 'Grove',scale= 0.7, color = 25, sprite = 310, radius = 120.0},
  Ballas = {coords = vector3(102.86,-1942.96,20.28), name = 'Ballas',scale= 0.7, color = 27, sprite = 310, radius = 120.0},
  Vagos = {coords = vector3(342.35,-2043.95,4.219999313354), name ='Vagos', scale= 0.7,color = 5, sprite = 310, radius = 120.0},
  Aztecas = {coords = vector3(1436.406,-1489.753,65.668), name = 'Aztecas',scale= 0.7, color = 38, sprite = 310, radius = 120.0},	
  LostMC = {coords = vector3(972.951,-98.021,65.668), name = 'LostMc',scale= 0.7, color =  1, sprite = 310, radius = 120.0},	
  BALIK = {coords = vector3(1338,4235,31), name = 'Balık Tutma Alanı', scale= 0.8, color =  26, sprite = 68, radius = 0.0},
  BALIKres = {coords = vector3(-1038,-1395,31), name = 'Balık Restaurant', scale= 0.8, color =  26, sprite = 68, radius = 0.0},
  Ria = {coords = vector3(234,221,31), name = 'Ria V Merkez Bankası', scale= 0.7, color =  30, sprite =  78, radius = 0.0},
}


function CreateBlipCircle2(coords, text, radius, color, sprite)
  local blip = AddBlipForRadius(coords, radius)

  SetBlipHighDetail(blip, true)
  SetBlipColour(blip, 2)
  SetBlipAlpha (blip, 128)

  blip = AddBlipForCoord(coords)

  SetBlipHighDetail(blip, true)
  SetBlipSprite (blip, sprite)
  SetBlipPriority (blip,100)
  SetBlipScale  (blip, 0.8)
  SetBlipColour (blip, color)
  SetBlipAsShortRange(blip, true)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(text)
  EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
  for k,zone in pairs(CircleZones2) do
	  CreateBlipCircle2(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
  end
end)

CircleZones2 = {  -- Yeşil Bölgeler
  --Dovizci = {coords = vector3(-118.11,-607.11,36.28), name = 'Medellin Emlak',scale= 1.0, color = 49, sprite = 357 , radius = 0.0}
  Ria = {coords = vector3(435,-219,31), name = 'Ria V Sunfield Park', scale= 0.7, color =  30, sprite =  475, radius = 0.0},
}
