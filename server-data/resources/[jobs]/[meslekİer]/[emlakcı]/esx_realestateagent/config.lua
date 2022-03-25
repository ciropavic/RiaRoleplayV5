Config              = {}
Config.DrawDistance = 100.0
Config.MarkerColor  = { r = 255, g = 0, b = 0 }
Config.Locale       = 'en'

Config.Zones = {
	OfficeEnter = {
		Pos   = { x = -79.151, y = -837.000, z = 39.50 },
		Size  = { x = 1.5, y = 1.5, z = 1.5 },
		Type  = 1
	},

	OfficeExit = {
		Pos   = { x = -78.25, y = -833.166, z = 242.50 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 1
	},

	OfficeInside = {
		Pos   = { x = -77.969, y = -830.785, z = 243.50 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	OfficeOutside = {
		Pos   = { x = -84.238, y = -835.193, z = 39.50 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	OfficeActions = {
		Pos   = { x = -80.786, y = -802.486, z = 242.500 },
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Type  = -1
	}
}
