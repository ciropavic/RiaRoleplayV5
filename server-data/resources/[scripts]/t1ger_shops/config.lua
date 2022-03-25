-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 
Config 						= {}

-- General Settings:
Config.ESXSHAREDOBJECT 		= "esx:getSharedObject"	-- Change your getshared object event here, in case you are using anti-cheat.
Config.HasItemLabel			= true					-- set to true if your ESX doesn't support item labels.
Config.T1GER_DeliveryJob 	= true					-- set to true if u don't own this script. 

-- Settings:
Config.BuyShopWithCash 	 	= true		-- Set to true to purchase shops with bank.money.
Config.SellPercent		 	= 0.75		-- Means player gets 75% in return from original paid price.
Config.AccountsInCash		= true		-- Set to true to deposit/withdraw money into and from shop account with bank-money instead of cash money.
Config.ItemCompatibility	= true		-- If disabled, it doesnt check for type compatibility in Config.Items, meaning weapon shop owner could add bread, redgull etc.
Config.OrderItemPercent		= 25		-- Set percent between 1 and 100 of how much of the default item price is reduced, when ordering stock.
Config.BasketCommand		= 'basket'	-- Default command to open/view basket.
Config.InteractionMenuKey	= 167		-- Default [F6]-

Config.ItemWeightSystem		= true		-- Set this to true if you are using weight instead of limit.
Config.WeaponLoadout		= true		-- Set this to true if you are using weapons as items.

-- Shops:
Config.Shops = {
	[1] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {-44.14,-1749.44,29.42}, cashier = {-47.29,-1756.7,29.42}, delivery = {-40.67,-1751.6,29.42}},
	[2] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {28.84,-1339.35,29.5}, cashier = {25.81,-1345.25,29.5}, delivery = {24.67,-1339.09,29.5}},
	[3] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {-709.68,905.4,19.22}, cashier = {-707.32,-912.9,19.22}, delivery = {-705.08,-904.4,19.22}},
	[4] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {1159.77,-315.23,69.21}, cashier = {1163.39,-322.21,69.21}, delivery = {1163.9,-313.6,69.21}},
	[5] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {378.8,333.1,103.57}, cashier = {373.59,325.52,103.57}, delivery = {374.88,334.51,103.57}},
	[6] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {-1828.29,797.87,138.19}, cashier = {-1821.45,793.84,138.11}, delivery = {-1825.97,801.41,138.11}},
	[7] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {-3048.0,586.32,7.91}, cashier = {-3038.78,585.85,7.91}, delivery = {-3047.06,582.23,7.91}},
	[8] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {-3249.82,1005.02,12.83}, cashier = {-3241.54,1001.14,12.83}, delivery = {-3250.63,1000.98,12.83}},
	[9] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {545.77,2662.87,42.16}, cashier = {547.77,2671.75,42.16}, delivery = {549.89,2662.95,42.16}},
	[10] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {2673.21,3287.1,55.24}, cashier = {2679.15,3280.13,55.24}, delivery = {2670.82,3283.75,55.24}},
	[11] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {1959.9,3749.09,32.34}, cashier = {1961.42,3740.09,32.34}, delivery = {1956.12,3747.44,32.34}},
	[12] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {1706.87,4921.07,42.06}, cashier = {1699.27,4923.54,42.06}, delivery = {1705.28,4917.2,42.07}},
	[13] = {owned = true, type = "normal", price = 70000, buyable = true, b_menu = {1735.31,6420.41,35.04}, cashier = {1728.69,6414.18,35.04}, delivery = {1731.85,6422.65,35.04}},
	[14] = {owned = true, type = "normal", price = 100000, buyable = true, b_menu = {188.84,-887.62,30.71}, cashier = {189.94,-889.8,30.71}, delivery = {195.08,-890.22,30.71}},
}

Config.MarkerSettings = { -- Marker Settings:
	['boss'] = { enable = true, drawDist = 10.0, type = 20, scale = {x = 0.35, y = 0.35, z = 0.35}, color = {r = 240, g = 52, b = 52, a = 100} },
	['shelves'] = { enable = true, drawDist = 10.0, type = 20, scale = {x = 0.30, y = 0.30, z = 0.30}, color = {r = 240, g = 52, b = 52, a = 100} },
	['cashier'] = { enable = true, drawDist = 10.0, type = 20, scale = {x = 0.30, y = 0.30, z = 0.30}, color = {r = 0, g = 200, b = 70, a = 100} }
}
-- Blip Settings:
Config.BlipSettings = { -- Blip Settings:
	['normal'] = { enable = true, sprite = 52, display = 4, scale = 0.45, color = 2, name = "Market" },
	['weapon'] = { enable = false, sprite = 110, display = 4, scale = 0.45, color = 6, name = "Weapon Shop" },
	['pawnshop'] = { enable = false, sprite = 59, display = 4, scale = 0.45, color = 5, name = "Pawn Shop" },
	['police'] = { enable = false, sprite = 120, display = 4, scale = 0.45, color = 5, name = "Politi butik" }
}

-- Shop Items:
Config.Items = {
	{label = "Çanta", item = "bag", type = {"normal"}, price = 500},
	{label = "Bandaj", item = "bandage", type = {"normal"}, price = 250},
	{label = "Ekmek", item = "bread", type = {"normal"}, price = 10},
	{label = "Burger", item = "burger", type = {"normal"}, price = 20},
	{label = "Şampanya", item = "champagne", type = {"normal"}, price = 150},
	{label = "Cheese Burger", item = "cheeseburger", type = {"normal"}, price = 25},
	{label = "Çikolata", item = "chocolate", type = {"normal"}, price = 5},
	{label = "Sigara", item = "cigarett", type = {"normal"}, price = 30},
	{label = "Kola", item = "cola", type = {"normal"}, price = 6},
	{label = "Kurabiye", item = "cookie", type = {"normal"}, price = 7},
	{label = "Soğuk Limonata", item = "coollime", type = {"normal"}, price = 5},
	{label = "Hayvan Maması", item = "croquettes", type = {"normal"}, price = 50},
	{label = "İp", item = "cuffs", type = {"normal"}, price = 150},
	{label = "Makas", item = "cuff_keys", type = {"normal"}, price = 150},
	{label = "Donut", item = "donut", type = {"normal"}, price = 12},
	{label = "Dr Pepper", item = "drpepper", type = {"normal"}, price = 15},
	{label = "Elmalı Kek", item = "elmalikek", type = {"normal"}, price = 15},
	{label = "Enerji İçeceği", item = "powerade", type = {"normal"}, price = 30},
	{label = "Fanta", item = "fanta", type = {"normal"}, price = 7},
	{label = "Filtre Kahve", item = "filtrekahve", type = {"normal"}, price = 15},
	{label = "Balık Yemi", item = "james_fishingbait", type = {"normal"}, price = 10},
	{label = "Balık Oltası", item = "james_fishingrod", type = {"normal"}, price = 200},
	{label = "Golem İçki", item = "golem", type = {"normal"}, price = 80},
	{label = "Üzüm", item = "grapperaisin", type = {"normal"}, price = 40},
	{label = "Hennesy", item = "hennesy", type = {"normal"}, price = 350},
	{label = "Sıcak Çikolata", item = "hotchocolate", type = {"normal"}, price = 10},
	{label = "Jager", item = "jager", type = {"normal"}, price = 250},
	{label = "Kremalı Frappucino", item = "javachipcreamfrappucino", type = {"normal"}, price = 25},
	{label = "Meyve Suyu", item = "jusfruit", type = {"normal"}, price = 10},
	{label = "Karısık Pizza", item = "karisikpizza", type = {"normal"}, price = 60},
	{label = "Çakmak", item = "lighter", type = {"normal"}, price = 5},
	{label = "Limonata", item = "limonade", type = {"normal"}, price = 18},
	{label = "Likör", item = "liquor", type = {"normal"}, price = 100},
	{label = "Şarap", item = "wine", type = {"normal"}, price = 120},
	{label = "Su", item = "water", type = {"normal"}, price = 6},
	{label = "Vodka", item = "vodka", type = {"normal"}, price = 120},
	{label = "Vişneli Kek", item = "veryberrymuffin", type = {"normal"}, price = 12},
	{label = "Semsiye", item = "umbrella", type = {"normal"}, price = 50},
	{label = "Piknik Sepeti", item = "picnic", type = {"normal"}, price = 500},
	{label = "Sandiwich", item = "sandwich", type = {"normal"}, price = 20},
	{label = "Gül", item = "rose", type = {"normal"}, price = 40},
	{label = "RedBull", item = "redgull", type = {"normal"}, price = 20},
}

Config.AmmoTypes = {
}

