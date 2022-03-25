Config = {}

Config.Items = {
    {Label = 'Yüzük', Name = 'ring'},
    {Label = 'Poker Fişi', Name = 'zetony'},
    {Label = 'Bankacı Kimlik Kartı', Name = 'id_card_f'},
    {Label = 'Rolex', Name = 'rolex'},
    {Label = 'iMac', Name = 'laptop_h'},
    {Label = 'Güvenlik Kartı', Name = 'secure_card'},
    {Label = 'USB', Name = 'busb'},
    {Label = 'Dürbün', Name = 'jumelles'},
    {Label = 'Radio', Name = 'highradio'},

} 

Config.GhettoPeds = { -- https://wiki.gt-mp.net/index.php/Peds
    588969535,
    -198252413,
    -1492432238,
    599294057
}

Config.GhettoWeapons = { -- vapen som npcer kan få
    "WEAPON_MICROSMG" 
}

Config.WeaponChance = 50 -- % att npcen får ett vapen 

Config.Burglary = {
    [1] = {
        Door = {Object = "v_ilev_fa_frontdoor", Coords = vector3(-14.36, -1441.58, 30.22), Frozen = true, Heading = 180.0, Health = 1000},
        Type = 'ghetto',
        Cops = 0,
        Peds = {
            vector3(-3.33, -1476.56, 29.66),
            vector3(-5.42,  -1480.09, 29.52),
            vector3(-41.93, -1450.68, 31.14)
        },
        MultipleSearch = {
            {Items = 5, Position = vector3(-17.85, -1432.38, 30.22), Heading = 331.55, Text = 'Kutuyu ara', Name = 'Dolap'},
            {Items = 2, Position = vector3(-14.87, -1440.19, 30.22), Heading = 93.55, Text = 'Kaldırarak ara', Name = 'Kabin'},
            {Items = 5, Position = vector3(-12.29, -1434.98, 30.22), Heading = 87.47, Text = 'Bölüm ara', Name = 'Övgü'},
            {Items = 2, Position = vector3(-9.36, -1434.79, 30.22), Heading = 215.48, Text = 'Bölüm ara', Name = 'Dolap'},
            {Items = 1, Position = vector3(-18.4, -1440.59, 30.22), Heading = 100.32, Text = 'Kutuyu ara', Name = 'Komidin'},
        },
    },

    [2] = {
        Door = {Object = "v_ilev_mm_doorw", Coords = vector3(-809.2809,177.8554,76.89033), Frozen = true, Heading = 200.0, Health = 1000},
        Type = 'ghetto',
        Cops = 0,
        Peds = {
            vector3(-812.33, 180.56, 72.16),
            vector3(-806.42, 183.09, 75.00),
            vector3(-822.93, 177.68, 71.36)
        },
        MultipleSearch = {
            {Items = 5, Position = vector3(-811.85, 181.38, 76.22), Heading = 331.55, Text = 'Kutuyu ara', Name = 'Dolap'},
            {Items = 2, Position = vector3(-813.87, 182.19, 76.22), Heading = 93.55, Text = 'Kaldırarak ara', Name = 'Kabin'},
            {Items = 5, Position = vector3(-815.29, 180.98, 76.22), Heading = 87.47, Text = 'Bölüm ara', Name = 'Övgü'},
            {Items = 2, Position = vector3(-811.36, 175.79, 76.20), Heading = 215.48, Text = 'Bölüm ara', Name = 'Dolap'},
            {Items = 1, Position = vector3(-812.4, 177.59, 76.22), Heading = 100.32, Text = 'Kutuyu ara', Name = 'Komidin'},
        },
    },

        [3] = {
            Door = {Object = "v_ilev_trev_door", Coords = vector3(-1150.2809,-1515.8554,10.89033), Frozen = true, Heading = 300.0, Health = 1000},
            Type = 'ghetto',
            Cops = 0,
            Peds = {
                vector3(-1148.33, -1522.56, 10.63),
                vector3(-1143.42,  -1519.09, 7.55),
                vector3(-1146.52, -1520.6, 6.61)
            },
            MultipleSearch = {
                {Items = 5, Position = vector3(-1147.85, -1510.38, 10.63), Heading = 331.55, Text = 'Kutuyu ara', Name = 'Dolap'},
                {Items = 2, Position = vector3(-1147.87, -1513.19, 10.63), Heading = 93.55, Text = 'Kaldırarak ara', Name = 'Kabin'},
                {Items = 5, Position = vector3(-1150.29, -1512.98, 10.63), Heading = 87.47, Text = 'Bölüm ara', Name = 'Övgü'},
                {Items = 2, Position = vector3(-1150.29, -1514.79, 10.63), Heading = 215.48, Text = 'Bölüm ara', Name = 'Dolap'},
                {Items = 1, Position = vector3(-1145.4, -1514.59, 10.63), Heading = 100.32, Text = 'Kutuyu ara', Name = 'Komidin'},
            },
    },

    [4] = {
        Door = {Object = "v_ilev_trevtraildr", Coords = vector3(1972.769,3815.366,33.66326), Frozen = true, Heading = 30.0, Health = 1000},
        Type = 'ghetto',
        Cops = 0,
        Peds = {
            vector3(1983.33, 3808.56, 32.30),
            vector3(1988.42,  3815.09, 32.35),
            vector3(1978.52, 3800.6, 32.30)
        },
        MultipleSearch = {
            {Items = 5, Position = vector3(1969.85, 3814.38, 33.43), Heading = 331.55, Text = 'Kutuyu ara', Name = 'Dolap'},
            {Items = 2, Position = vector3(1969.87, 3817.19, 33.43), Heading = 93.55, Text = 'Kaldırarak ara', Name = 'Kabin'},
            {Items = 5, Position = vector3(1978.29, 3820.98, 33.43), Heading = 87.47, Text = 'Bölüm ara', Name = 'Övgü'},
            {Items = 2, Position = vector3(1973.29, 3819.79, 33.63), Heading = 215.48, Text = 'Bölüm ara', Name = 'Dolap'},
            {Items = 1, Position = vector3(1971.4, 3819.79, 33.63), Heading = 100.32, Text = 'Kutuyu ara', Name = 'Komidin'},
        },
  },
}