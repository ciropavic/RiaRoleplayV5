Config = {}

Config.Locale = 'tr'
Config.UseGcphone = false -- use it false otherwise it writes error blah blah to console it will be added soon
Config.Marker = {type = 20, draw = 15.0, r = 255, g = 0, b = 0, x = 1.0, y = 1.0, z = 0.5}
Config.Reward = 2500

Config.Notify = {job="police", job2 = "sheriff", chance = 100, remove = 2} -- remove is notify blip's remove delay (minutes) / remove dakika cinsinden işaretlenen blipin silinme süresidir

Config.Blip = {use = true, sprite = 120, scale = 0.8, colour = 72} -- set use = false to remove siemon's blip / blip kullanmamak için false yapın

Config.Speech = {speech = "Generic_Thanks", param = "Speech_Params_Force_Shouted_Critical"}  -- siemon ped doesnt talk i dont understand but other peds can talk

Config.Limit = {use=true, max = 3 }  -- max is the maximumtaking mission count per day
Config.Cars = {
    "tailgater", 
    "kuruma", 
    "sentinel", 
    "kuruma",
    "nightblade",
    "reaper",
    "infernus",
    "sultanrs",
    "cheetah",
    "buccaneer",
    "dominator",
    "cognoscenti",
    "zombieb",
    "hakuchou",
    "blista"
}

Config.Simeon = {x=696.69, y=-1013.14, z=21.79, h=85.78}

Config.PedHash = -1064078846 
Config.PedHash2 = `s_m_y_xmech_02`

Config.Locations = {  -- delivery locations
   -- {x = -1169.17, y=-1999.46, z=12.20, h = 50.0}, --
    {x= -1182.8, y = -1773.5, z = 3.91, h=307.0}  
}