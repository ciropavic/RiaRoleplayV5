Config = {}

Config.Locale = 'en'
Config.OpenControl = 289
Config.TrunkOpenControl = 47
Config.DeleteDropsOnStart = false
Config.HotKeyCooldown = 1000
Config.CheckLicense = true



Config.Shops = {
    ['TwentyFourSeven'] = {
        coords = {
        },
        items = {
            { name = "bread", price = 20, count = 10 },
            { name = "water", price = 10, count = 10 },
        },
        markerType = 1,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Open Shop ~INPUT_CONTEXT~',
        enableBlip = false,
        job = 'all'
    },

    ['RobsLiquor'] = {
        coords = {
        },
        items = {
            { name = "bread", price = 20, count = 10 },
            { name = "water", price = 10, count = 10 }
        },
        markerType = 1,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Open Shop ~INPUT_CONTEXT~',
        enableBlip = false,
        job = 'all'
    },

    ['LTDgasoline'] = {
        coords = {
        },
        items = {
            { name = "bread", price = 20, count = 10 },
            { name = "water", price = 10, count = 10 },
        },
        markerType = 1,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Open Shop ~INPUT_CONTEXT~',
        enableBlip = false,
        job = 'all'
    },
    ['Diner'] = {
        coords = {
        },
        items = {
            { name = "bread", price = 20, count = 10 },
            { name = "water", price = 10, count = 10 },

        },
        markerType = 1,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Open Diner ~INPUT_CONTEXT~',
        enableBlip = false,
        job = 'all'
    },
    ['Weapon Shop - Police'] = {
        coords = {
            vector3(474.06, -997.55, 30.73),
        },
        items = {
            -- Ammo
            { name = "disc_ammo_pistol", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_pistol_large", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_rifle", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_rifle_large", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_shotgun", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_smg", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_snp", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_COMBATPISTOL", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_STUNGUN", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_NIGHTSTICK", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_FLASHLIGHT", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_FLARE", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_PUMPSHOTGUN", price = 1000, count = 1, grade = 2 },
            { name = "WEAPON_CARBINERIFLE", price = 1000, count = 1, grade = 3 },
            { name = "WEAPON_ASSAULTSMG", price = 1000, count = 1, grade = 1 },
            { name = "WEAPON_SMG", price = 1000, count = 1, grade = 1 },
            { name = "WEAPON_SAWNOFFSHOTGUN", price = 1000, count = 1, grade = 1 },
        },
        markerType = 2,
        markerColour = { r = 0, g = 0, b = 255 },
        msg = '[E] Polis Cephanelik',
        job = 'police'
    },
    ['Weapon Shop - Sheriff'] = {
        coords = {
            vector3(1856.06, 3700.55, 34.73),
        },
        items = {
            -- Ammo
            { name = "disc_ammo_pistol", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_pistol_large", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_rifle", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_rifle_large", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_shotgun", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_smg", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_snp", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_COMBATPISTOL", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_STUNGUN", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_NIGHTSTICK", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_FLASHLIGHT", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_FLARE", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_PUMPSHOTGUN", price = 1000, count = 1, grade = 2 },
            { name = "WEAPON_CARBINERIFLE", price = 1000, count = 1, grade = 3 },
            { name = "WEAPON_ASSAULTSMG", price = 1000, count = 1, grade = 1 },
            { name = "WEAPON_SMG", price = 1000, count = 1, grade = 1 },
            { name = "WEAPON_SAWNOFFSHOTGUN", price = 1000, count = 1, grade = 1 },
        },
        markerType = 2,
        markerColour = { r = 0, g = 0, b = 255 },
        msg = '[E] Polis Cephanelik',
        job = 'sheriff'
    },
    ['Weapon Shop - Justice'] = {
        coords = {
            vector3(247.06, -1098.55, 36.13),
        },
        items = {
            -- Ammo
            { name = "disc_ammo_pistol", price = 1000, count = 1, grade = 0 },
            { name = "disc_ammo_pistol_large", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_COMBATPISTOL", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_STUNGUN", price = 1000, count = 1, grade = 0 },
            { name = "WEAPON_NIGHTSTICK", price = 1000, count = 1, grade = 0 },
            
          },
        markerType = 2,
        markerColour = { r = 0, g = 0, b = 255 },
        msg = '[E] Adliye Cephanelik',
        job = 'justice'
    },
}


Config.Stash = {
    ['Police'] = {
        coords = vector3(447.76, -998.05, 30.69),
        size = vector3(1.0, 1.0, 1.0),
        job = 'police',
        markerType = 2,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Cephane deposunu açmak için ~INPUT_CONTEXT~ tuşuna basın'
    },
    ['Mc'] = {
        coords = vector3(462.76, -981.05, 30.69),
        size = vector3(1.0, 1.0, 1.0),
        job = 'police',
        markerType = 2,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Market deposunu açmak için ~INPUT_CONTEXT~ tuşuna basın'
    },
    ['Justice'] = {
        coords = vector3(247.76, -1096.05, 36.13),
        size = vector3(1.0, 1.0, 1.0),
        job = 'justice',
        markerType = 2,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Cephane deposunu açmak için ~INPUT_CONTEXT~ tuşuna basın'
    },
    ['Mc2'] = {
        coords = vector3(240.76, -1091.05, 29.29),
        size = vector3(1.0, 1.0, 1.0),
        job = 'justice',
        markerType = 2,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Market deposunu açmak için ~INPUT_CONTEXT~ tuşuna basın'
    }
}

Config.Steal = {
    black_money = true,
    cash = true
}

Config.Seize = {
    black_money = true,
    cash = true
}

Config.VehicleLimit = {
    ['Zentorno'] = 10,
    ['Panto'] = 1,
    ['Zion'] = 5
}

--Courtesy DoctorTwitch
Config.VehicleSlot = {
    [0] = 10, --Compact
    [1] = 15, --Sedan
    [2] = 20, --SUV
    [3] = 15, --Coupes
    [4] = 5, --Muscle
    [5] = 5, --Sports Classics
    [6] = 5, --Sports
    [7] = 0, --Super
    [8] = 5, --Motorcycles
    [9] = 10, --Off-road
    [10] = 20, --Industrial
    [11] = 20, --Utility
    [12] = 30, --Vans
    [13] = 0, --Cycles
    [14] = 0, --Boats
    [15] = 0, --Helicopters
    [16] = 0, --Planes
    [17] = 20, --Service
    [18] = 20, --Emergency
    [19] = 90, --Military
    [20] = 0, --Commercial
    [21] = 0 --Trains
}

Config.Throwables = {
    WEAPON_MOLOTOV = 615608432,
    WEAPON_GRENADE = -1813897027,
    WEAPON_STICKYBOMB = 741814745,
    WEAPON_PROXMINE = -1420407917,
    WEAPON_SMOKEGRENADE = -37975472,
    WEAPON_PIPEBOMB = -1169823560,
    WEAPON_SNOWBALL = 126349499
}

Config.FuelCan = 883325847
