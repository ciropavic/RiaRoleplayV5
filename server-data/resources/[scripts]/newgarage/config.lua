---------- EDITED BY MAKAVELI --------------
-------------Makavelİ#9414----------------- DISCORD

Config = {}

Config.VehicleMenu = true -- enable this if you wan't a vehicle menu.
Config.VehicleMenuButton = 344 -- change this to the key you want to open the menu with. buttons: https://docs.fivem.net/game-references/controls/
Config.RangeCheck = 25.0 -- this is the change you will be able to control the vehicle.

Config.Garages = {
    ["Jakepark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(211.8094329834, -934.98626708984, 24.28)
            },
            ["vehicle"] = {
                ["position"] = vector3(219.86030578613, -932.77551269531, 24.14), 
                ["heading"] = 140.0
            }
        },
        ["camera"] = {  -- camera is not needed just if you want cool effects.
            ["x"] = 224.94281005859, 
            ["y"] = -930.33062744141, 
            ["z"] = 26.571212768555, 
            ["rotationX"] = -31.401574149728, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -243.40157422423 
        }
    },

    ["SantiagoPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(273.67422485352, -344.15573120117, 44.90)
            },
            ["vehicle"] = {
                ["position"] = vector3(272.50082397461, -337.40579223633, 44.919834136963), 
                ["heading"] = 160.0
            }
        },
        ["camera"] = { 
            ["x"] = 283.28225708008, 
            ["y"] = -333.24017333984, 
            ["z"] = 50.004745483398, 
            ["rotationX"] = -21.637795701623, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 125.73228356242 
        }
    },

    ["Amypark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-1803.8967285156, -341.45928955078, 43.986347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-1810.7857666016, -337.13592529297, 43.552074432373), 
                ["heading"] = 320.0
            }
        },
        ["camera"] = { 
            ["x"] = -1813.5513916016, 
            ["y"] = -340.40087890625, 
            ["z"] = 46.962894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -42.110235854983 
        }
    },

    ["Gullpark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-1080.8967285156, -1257.45928955078, 5.526347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-1072.7857666016, -1249.13592529297, 5.552074432373), 
                ["heading"] = 211.0
            }
        },
        ["camera"] = { 
            ["x"] = -1074.5513916016, 
            ["y"] = -1270.40087890625, 
            ["z"] = 13.962894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -50.110235854983 
        }
    },

    ["Yakaripark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(471.8967285156, -1114.45928955078, 29.526347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(479.7857666016, -1120.13592529297, 29.312074432373), 
                ["heading"] = 182.0
            }
        },
        ["camera"] = { 
            ["x"] = 489.5513916016, 
            ["y"] = -1129.40087890625, 
            ["z"] = 34.712894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 30.110235854983 
        }
    },

    ["Holtpark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-66.8967285156, -1816.45928955078, 27.2106347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-67.7857666016, -1827.13592529297, 27.002074432373), 
                ["heading"] = 182.0
            }
        },
        ["camera"] = { 
            ["x"] = -60.5513916016, 
            ["y"] = -1836.40087890625, 
            ["z"] = 33.552894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },

    ["Makpark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-461.8967285156, -326.45928955078, 34.506347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-466.7857666016, -324.13592529297, 34.752074432373), 
                ["heading"] = 330.0
            }
        },
        ["camera"] = { 
            ["x"] = -458.5513916016, 
            ["y"] = -331.40087890625, 
            ["z"] = 37.552894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },

    ["Elevpark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-956.8967285156, -2580.45928955078, 13.97198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-955.7857666016, -2592.13592529297, 13.852074432373), 
                ["heading"] = 326.0
            }
        },
        ["camera"] = { 
            ["x"] = -946.5513916016, 
            ["y"] = -2597.40087890625, 
            ["z"] = 19.552894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },

    ["Charlespark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(1022.8967285156, -755.45928955078, 57.976347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(1019.7857666016, -765.13592529297, 57.922074432373), 
                ["heading"] = 308.0
            }
        },
        ["camera"] = { 
            ["x"] = 1025.5513916016, 
            ["y"] = -768.40087890625, 
            ["z"] = 61.552894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },

    ["Jupark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-549.8967285156, 309.45928955078, 83.1376347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-562.7857666016, 301.13592529297, 83.922074432373), 
                ["heading"] = 263.0
            }
        },
        ["camera"] = { 
            ["x"] = -558.5513916016, 
            ["y"] = 297.40087890625, 
            ["z"] = 87.552894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },

    ["Hopark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-3156.8967285156, 1125.45928955078, 20.756347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-3157.7857666016, 1128.13592529297, 21.47432373), 
                ["heading"] = 334.0
            }
        },
        ["camera"] = { 
            ["x"] = -3157.5513916016, 
            ["y"] = 1125.40087890625, 
            ["z"] = 24.372894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },

    ["Dragonpark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(106.8967285156, 6612.45928955078, 31.756347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(111.7857666016, 6613.13592529297, 31.842074432373), 
                ["heading"] = 225.0
            }
        },
        ["camera"] = { 
            ["x"] = 117.5513916016, 
            ["y"] = 6611.40087890625, 
            ["z"] = 39.372894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },

    ["WinFpark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-2190.8967285156, 3297.45928955078, 32.756347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-2194.7857666016, 3297.13592529297, 32.842074432373), 
                ["heading"] = 173.0
            }
        },
        ["camera"] = { 
            ["x"] = -2181.5513916016, 
            ["y"] = 3297.40087890625, 
            ["z"] = 38.872894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },

    ["Saintpark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(1736.8967285156, 3710.45928955078, 34.756347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(1728.7857666016, 3713.13592529297, 34.842074432373), 
                ["heading"] = 17.0
            }
        },
        ["camera"] = { 
            ["x"] = 1734.5513916016, 
            ["y"] = 3708.40087890625, 
            ["z"] = 37.662894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },

    ["MirPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-8.3667285156, -1095.45928955078, 26.706347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-15.7857666016, -1101.13592529297, 26.842074432373), 
                ["heading"] = 153.0
            }
        },
        ["camera"] = { 
            ["x"] = -11.2613916016, 
            ["y"] = -1110.40087890625, 
            ["z"] = 31.362894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },

    ["DesPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-88.507285156, 86.8428955078, 71.956347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-100.7857666016, 93.01592529297, 71.812074432373), 
                ["heading"] = 57.8
            }
        },
        ["camera"] = { 
            ["x"] = -89.2613916016, 
            ["y"] = 84.40087890625, 
            ["z"] = 75.452894439697, 
            ["rotationX"] = -39.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },
    ["BarneyPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-2601.507285156, 1931.8428955078, 167.256347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-2597.7857666016, 1929.01592529297, 167.312074432373), 
                ["heading"] = 265.8
            }
        },
        ["camera"] = { 
            ["x"] = -2587.2613916016, 
            ["y"] = 1927.40087890625, 
            ["z"] = 169.452894439697, 
            ["rotationX"] = -40.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },
    ["SessionPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-1923.507285156, 2061.8428955078, 140.856347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-1907.7857666016, 2061.01592529297, 140.312074432373), 
                ["heading"] = 140.8
            }
        },
        ["camera"] = { 
            ["x"] = -1899.2613916016, 
            ["y"] = 2048.40087890625, 
            ["z"] = 145.452894439697, 
            ["rotationX"] = -40.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },
    ["PlayboyPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(22.507285156, 543.8428955078, 176.05347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(14.7857666016, 549.01592529297, 176.312074432373), 
                ["heading"] = 117.8
            }
        },
        ["camera"] = { 
            ["x"] = 18.2613916016, 
            ["y"] = 546.40087890625, 
            ["z"] = 180.452894439697, 
            ["rotationX"] = -40.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },
    ["WalkerPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-371.507285156, -107.8428955078, 38.68347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-360.7857666016, -111.01592529297, 38.612074432373), 
                ["heading"] = 117.8
            }
        },
        ["camera"] = { 
            ["x"] = -353.2613916016, 
            ["y"] = -121.40087890625, 
            ["z"] = 46.452894439697, 
            ["rotationX"] = -40.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },
    ["USAPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-177.507285156, -1295.8428955078, 31.3347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-189.7857666016, -1284.01592529297, 31.412074432373), 
                ["heading"] = 268.92
            }
        },
        ["camera"] = { 
            ["x"] = -177.2613916016, 
            ["y"] = -1291.40087890625, 
            ["z"] = 36.452894439697, 
            ["rotationX"] = -40.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },
    ["DealerPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(155.507285156, -130.8428955078, 54.8347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-148.7857666016, -125.01592529297, 54.412074432373), 
                ["heading"] = 268.92
            }
        },
        ["camera"] = { 
            ["x"] = 156.2613916016, 
            ["y"] = -131.40087890625, 
            ["z"] = 60.452894439697, 
            ["rotationX"] = -40.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },
    ["GinaPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(938.507285156, -1503.8428955078, 30.4347198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(938.7857666016, -1496.01592529297, 30.32074432373), 
                ["heading"] = 251.49
            }
        },
        ["camera"] = { 
            ["x"] = 949.2613916016, 
            ["y"] = -1508.40087890625, 
            ["z"] = 38.452894439697, 
            ["rotationX"] = -40.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },
    ["NikolajPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-686.507285156, -974.8428955078, 20.3947198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-695.7857666016, -981.01592529297, 20.42074432373), 
                ["heading"] = 2.04
            }
        },
        ["camera"] = { 
            ["x"] = -686.2613916016, 
            ["y"] = -986.40087890625, 
            ["z"] = 26.452894439697, 
            ["rotationX"] = -40.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },
    ["FavorPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(241.507285156, -36.8428955078, 69.7647198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(234.7857666016, -35.01592529297, 69.82074432373), 
                ["heading"] = 165.04
            }
        },
        ["camera"] = { 
            ["x"] = 243.2613916016, 
            ["y"] = -45.40087890625, 
            ["z"] = 77.452894439697, 
            ["rotationX"] = -40.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },
    ["GalaxyPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-1636.507285156, -3009.8428955078, -78.1647198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-1639.7857666016, -3005.01592529297, -78.22074432373), 
                ["heading"] = 165.04
            }
        },
        ["camera"] = { 
            ["x"] = -1630.2613916016, 
            ["y"] = -3013.40087890625, 
            ["z"] = -74.452894439697, 
            ["rotationX"] = -40.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    },
     ["GunPark"] = {
        ["positions"] = {
            ["menu"] = {
                ["position"] = vector3(-1324.507285156, -396.8428955078, 36.407198486)
            },
            ["vehicle"] = {
                ["position"] = vector3(-1319.7857666016, -385.01592529297, 36.42074432373), 
                ["heading"] = 165.04
            }
        },
        ["camera"] = { 
            ["x"] = -1318.2613916016, 
            ["y"] = -392.40087890625, 
            ["z"] = 40.452894439697, 
            ["rotationX"] = -40.496062710881, 
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 40.110235854983 
        }
    }
}

Config.Labels = {
    ["menu"] = "Garajı açmak için ~INPUT_CONTEXT~ tuşuna basınız.",
    ["vehicle"] = "Aracı garaja koymak için ~INPUT_CONTEXT~ tuşuna basınız."
}

Config.Trim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

Config.AlignMenu = "top-left" -- this is where the menu is located [left, right, center, top-right, top-left etc.]