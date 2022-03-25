Config = {}
Config.Locale = 'en'

Config.RequiredCopsRob = 6
Config.RequiredCopsSell = 6
Config.MinJewels = 1
Config.MaxJewels = 10
Config.MaxWindows = 20
Config.SecBetwNextRob = 24*60*60*1000 --1 saat default baştaki 1 i 2,3 olarak değiştirirseniz 2 saat 3 saat şeklinde değişir
Config.MaxJewelsSell = 20
Config.PriceForOneJewel = 2500
Config.EnableMarker = true
Config.NeedBag = true
Config.Block = 3 -- hack işemindeki zorluk
Config.Time = 25 -- hack işlemi için verilen süre
Config.HackPrice = 100000 --
Config.PoliceNotify = 100 -- hack minigameinde başarılı olsa bile gitme ihtimali (başarısız olunca hep gidiyor) 

Config.Borsoni = {40, 41, 44, 45}

Stores = {
	["jewelry"] = {
		position = { x = -629.233, y = -235.920, z = 38.057 },       
		nameofstore = "Mücevher",
		lastrobbed = 0
	}
}