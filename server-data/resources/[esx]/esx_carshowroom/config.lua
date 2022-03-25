Config                            = {}

Config.DrawDistance               = 2.0

Config.MarkerColor                = { r = 255, g = 0, b = 0 }

--language currently available EN and SV

Config.Locale                     = 'en'

--this is how much the price shows from the purchase price

-- exapmle the cardealer boughts it for 2000 if 2 then it says 4000

Config.Price = 1.30 -- this is times how much it should show



Config.Zones = {



  ShopInside = {

    Pos     = { x = 228.26 , y = -986.57, z = -99.96 },

    Size    = { x = 1.5, y = 1.5, z = 1.0 },

    Heading = 177.28,

    Type    = -1,

  },



  Katalog = {

    Pos     = { x = 145.23 , y = -157.46, z = 54.00 },

    Size    = { x = 1.5, y = 1.5, z = 1.0 },

    Heading = 177.28,

    Type    = 36,

  },



  GoDownFrom = {

    Pos     = { x = 145.23 , y = -157.46, z = 54.80 },

    Size  = { x = 1.5, y = 1.5, z = 1.0 },

    Type  = 36,

  },



  GoUpFrom = {

    Pos   = { x = 240.98, y = -1004.85, z = -99.98 },

    Size  = { x = 1.5, y = 1.5, z = 1.0 },

    Type  = 1,

  },



}