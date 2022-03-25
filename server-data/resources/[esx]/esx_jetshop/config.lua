Config               = {}

Config.Locale = 'en'

Config.LicenseEnable = true -- enable jet license? Requires esx_license
Config.LicensePrice  = 15000

Config.MarkerType    = 1
Config.DrawDistance  = 100.0

Config.Marker = {
	r = 100, g = 204, b = 100, -- blue-ish color
	x = 1.5, y = 1.5, z = 1.0  -- standard size circle
}

Config.StoreMarker = {
	r = 255, g = 0, b = 0,     -- red color
	x = 5.0, y = 5.0, z = 1.0  -- big circle for storing jet
}

Config.Zones = {

	Garages = {
		{ -- Shank St, nearby campaign jet garage
			GaragePos  = vector3(1731.86, 3309.07, 40.22),
			SpawnPoint = vector4(1713.06, 3255.3, 41.0, 104.05),
			StorePos   = vector3(1720.46, 3241.0, 40.2),
			StoreTP    = vector4(1741.09, 3258.11, 41.35, 272.9)
		},




		{ -- Barbareno Rd
			GaragePos  = vector3(-1653.29, -3143.43, 13.2),
			SpawnPoint = vector4(-1596.0, -2993.76, 13.94, 235.64),
			StorePos   = vector3(-1654.41, -2954.07, 13.1),
			StoreTP    = vector4(-1646.5, -3123.37, 13.6, 328.38)
		}
	},

	jetShops = {
		{ -- Shank St, nearby campaign jet garage
			Outside = vector3(-1020.37, -2969.38, 13.05),
			Inside = vector4(-971.79, -2998.26, 13.05, 332.94)
		}
	}

}

Config.Vehicles = {
	{model = 'volatus', label = 'Volatus', price = 99999999},
	{model = 'swift2', label = 'Swift 2', price = 99999999},
	{model = 'supervolito2', label = 'Super Volito', price = 99999999},
	{model = 'frogger', label = 'Frogger', price = 99999999},
	{model = 'maverick', label = 'Maverick', price = 99999999}
}