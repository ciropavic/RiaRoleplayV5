fizzfau = {}

fizzfau = {
	Blip = {
		coords = { 
			{coord = vector3(2431.713, 4964.115, 42.347), sprite = 310, color = 1, radius = 100.0, rcolor = 49, ralpha = 75, scale = 0.7, name = "x"}
		}
	},
	DrawText = {
		coords = { 
			{ x = 2431.713, y = 4964.115, z = 42.347 }
		},
		scale = {
			x = 0.35, y = 0.35
		},
		Draw = 5.0,
		Type = 27
	},
	Rewards = {
		item = { name = "x", count = 25 },
		money = 50000 -- para vermesini istemiyorsanız 0 veya nil yazın
	},
	Clock = {
		Start = {
			hour = 0,
		},
		Finish = {
			hour = 24,
		},
	}	
}
