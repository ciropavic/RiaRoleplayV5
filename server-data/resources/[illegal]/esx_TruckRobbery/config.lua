--------------------------------
------- Created by Hamza -------
-------------------------------- 

Config = {}

-- Police Settings:
Config.RequiredPoliceOnline = 0			-- required police online for players to do missions
Config.PoliceDatabaseName = "police"	-- set the exact name from your jobs database for police
Config.PoliceNotfiyEnabled = true		-- police notification upon truck robbery enabled (true) or disabled (false)
Config.PoliceBlipShow = true			-- enable or disable blip on map on police notify
Config.PoliceBlipTime = 30				-- miliseconds that blip is active on map (this value is multiplied with 4 in the script)
Config.PoliceBlipRadius = 50.0			-- set radius of the police notify blip
Config.PoliceBlipAlpha = 250			-- set alpha of the blip
Config.PoliceBlipColor = 5				-- set blip color

-- Set cooldown timer, which player has to wait before being able to do a mission again, in minutes here:
Config.CooldownTimer = 120

-- Enable or disable player wearing a 'heist money bag' after the robbery:
Config.EnablePlayerMoneyBag = true

-- Hacking Settings:
Config.EnableAnimationB4Hacking = true			-- enable/disable hacking or typing animation
Config.HackingBlocks = 4						-- amount of blocks u have to match
Config.HackingSeconds = 40						-- seconds to hack

-- Mission Cost Settings:
Config.MissionCost = 100		-- taken from bank account // set to 0 to disable mission cost

-- Reward Settings:
Config.MinReward = 5000				-- set minimum reward amount
Config.MaxReward = 15000					-- set maximum reward amount
Config.RewardInDirtyMoney = false			-- reward as dirty money (true) or as normal cash (false)
Config.EnableItemReward = true 				-- requires to add your desired items into your items table in database
Config.ItemName1 = "id_card_f"				-- exact name of your item1
Config.ItemMinAmount1 = 50					-- set minimum reward amount of item1
Config.ItemMaxAmount1 = 300					-- set maximum reward amount of item1
Config.EnableRareItemReward = true		-- add another item as reward but this has only 25% chance 
Config.ItemName2 = "normal_c4"				-- exact name of your item2
Config.ItemMinAmount2 = 1					-- set minimum reward amount of item2
Config.ItemMaxAmount2 = 3					-- set maximum reward amount of item2
Config.RandomChance = 4				      -- Set chance, 1/2 is default, which is 50% chance. If u e.g. change value to 4, then 1/4 equals 25% chance.

-- Mission Blip Settings:
Config.EnableMapBlip = true							-- set between true/false
Config.BlipNameOnMap = "Zırhlı Araç"		-- set name of the blip
Config.BlipSprite = 67								-- set blip sprite, lists of sprite ids are here: https://docs.fivem.net/game-references/blips/
Config.BlipDisplay = 4								-- set blip display behaviour, find list of types here: https://runtime.fivem.net/doc/natives/#_0x9029B2F3DA924928
Config.BlipScale = 0.7								-- set blip scale/size on your map
Config.BlipColour = 5								-- set blip color, list of colors available in the bottom of this link: https://docs.fivem.net/game-references/blips/

-- Armored Truck Blip Settings:
Config.BlipNameForTruck = "Zırhlı Araç"			-- set name of the blip
Config.BlipSpriteTruck = 1							-- set blip sprite, lists of sprite ids are here: https://docs.fivem.net/game-references/blips/
Config.BlipColourTruck = 5							-- set blip color, list of colors available in the bottom of this link: https://docs.fivem.net/game-references/blips/
Config.BlipScaleTruck = 0.9							-- set blip scale/size on your map

-- Mission Start Location:
Config.MissionSpot = {
	{ ["x"] = 1275.55, ["y"] = -1710.4, ["z"] = 54.77, ["h"] = 0 },
}

-- Mission Marker Settings:
Config.MissionMarker = 27 												-- marker type
Config.MissionMarkerColor = { r = 240, g = 52, b = 52, a = 100 } 		-- rgba color of the marker
Config.MissionMarkerScale = { x = 1.25, y = 1.25, z = 1.25 }  			-- the scale for the marker on the x, y and z axis
Config.Draw3DText = "Sistemi hacklemek icin ~g~[E]~s~ tusuna basınız"					-- set your desired text here

-- Control Keys
Config.KeyToStartMission = 38	-- default: [E] // set key to start the mission
Config.KeyToOpenTruckDoor = 47
Config.KeyToRobFromTruck = 38										

-- ESX.ShowNotifications:
Config.NoMissionsAvailable = "Şu anda hiçbir görev yok, lütfen daha sonra tekrar deneyin!"
Config.HackingFailed = "Hack'lemede başarısız oldunuz "
Config.TruckMarkedOnMap = "Zırhlı arac sistemde isaretlendi"
Config.KillTheGuards = "Zırhlı arac gardiyanlarını öldür"
Config.MissionCompleted = "Başarıyla aracı soydun tam bir hırsızsın"
Config.BeginToRobTruck = "Zırhlı araca ulas ve soyguna basla"
Config.GuardsNotKilledYet = "Zırhlı Kamyonlardan sürücü ve / veya yolcuları çıkarın."
Config.TruckIsNotStopped = "Zırhlı Kamyonu soymadan önce durdurun!"
Config.NotEnoughMoney = "Görev almak icin banka hesabınızda ~g~$"..Config.MissionCost.."~s~ ihtiyacınız var"
Config.NotEnoughPolice = "Görev almak icin en az ~b~"..Config.RequiredPoliceOnline.. " polis olması gerekir"
Config.CooldownMessage = "Başka bir görev daha yapabilirsiniz: %s dakika"
Config.RewardMessage = "Zırhlı kamyondan %s $ aldınız"
Config.Item1Message = "Zırhlı kamyondan ~b~%sx~s~ altın saat aldınız"
Config.Item2Message = "Zırhlı kamyondan ~b~%sx~s~ altın külcesi aldınz"
Config.DispatchMessage = "^3 10-90 ^0 Zırhlı Kamyonda ^5%s^0"

-- ESX.ShowHelpNotifications:
Config.OpenTruckDoor = "Kapıyı patlatmak icin ~INPUT_DETONATE~ tusuna bas!"
Config.RobFromTruck = "Soygunu baslatmak icin ~INPUT_PICKUP~ tusuna bas!"

-- ProgressBars text
Config.Progress1 = "KAMYON BİLGİLERİNİ ALMA"
Config.Progress2 = "C4 KURULUYOR"
Config.Progress3 = "PATLAMAYA KADAR Kİ SÜRE"
Config.Progress4 = "ARAC SOYULUYOR"

-- ProgressBar Timers, in seconds:
Config.RetrieveMissionTimer = 7.5	-- time from pressed E to receving location on the truck
Config.DetonateTimer = 10			-- time until bomb is detonated
Config.RobTruckTimer = 10			-- time spent to rob the truck

-- Guards Weapons:
Config.DriverWeapon = "WEAPON_PUMPSHOTGUN"		-- weapon for driver
Config.PassengerWeapon = "WEAPON_SMG" 			-- weapon for passenger

-- Armored Truck Spawn Locations
Config.ArmoredTruck = 
{
	{ 
		Location = vector3(-1327.479736328,-86.045326232910,49.31), 
		InUse = false
	},
	{ 
		Location = vector3(-2075.888183593,-233.73908996580,21.10), 
		InUse = false
	},
	{ 
		Location = vector3(-972.1781616210,-1530.9045410150,4.890), 
		InUse = false
	},
	{ 
		Location = vector3(798.184265136720,-1799.8173828125,29.33), 
		InUse = false
	},
	{ 
		Location = vector3(1247.0718994141,-344.65634155273,69.08), 
		InUse = false
	}
}

