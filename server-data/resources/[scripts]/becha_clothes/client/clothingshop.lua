clothingShops = {
	{1696.45667, 4829.17725, 41.1631294,600},
	{-1177.865234375,-1780.5612792969,2.9084651470184,600},
	{198.4602355957,-1646.7690429688,28.803218841553,600},
	{339.29, -592.45, 42.29} ,
	{-704.215881,-152.352982, 36.4151268,600},
	{-1192.94495,-772.688965, 16.3255997,1500},
	--{458.75, -992.05, 29.69 ,600},
	{429.236,-800.008,28.491 ,600},
	{-167.658,-299.397,38.733 ,600},
	{72.950,-1398.891,28.376 ,600},
	{-830.194,-1073.134,10.328 ,600},
	{-1446.711,-242.83,48.809 ,600},
	{11.254,6514.813,30.877 ,600},
	{617.180,2765.933,41.088 ,600},
	{1190.785,2713.558,37.222,600},
	{-3175.453,1042.857,19.863,600},
	{-1107.959,2709.211,18.107,600},
	{-1207.6564941406,-1456.8890380859,3.3784737586975,600},
	{121.76,-224.6,53.56,600},
	{1102.76,197.6,-50.50,600},
}

local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},

     {title="Kıyafet Magazası", colour=31, id=73, x = 1693.45667, y =  4823.17725, z = 42.1631294,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = -1177.865234375, y = -1780.5612792969, z = 2.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = 198.865234375, y = -1646.5612792969, z = 29.803218841553,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = -712.865234375, y = -301.5612792969, z = 54.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = -1192.865234375, y = -772.5612792969, z = 17.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = 429.865234375, y = -800.5612792969, z = 28.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = -162.865234375, y = -303.5612792969, z = 38.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = 75.865234375, y = -1392.5612792969, z = 28.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = -822.865234375, y = -1074.5612792969, z = 10.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = -1450.865234375, y = -236.5612792969, z = 48.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = 4.865234375, y = 6512.5612792969, z = 30.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = 615.865234375, y = 2762.5612792969, z = 2.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = 1196.865234375, y = 2709.5612792969, z = 2.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = -3171.865234375, y = 1043.5612792969, z = 2.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = -1100.865234375, y = 2710.5612792969, z = 2.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = -1207.865234375, y = -1456.5612792969, z = 2.9084651470184,600},
	 {title="Kıyafet Magazası", colour=31, id=73, x = 121.865234375, y = -224.5612792969, z = 6.9084651470184,600}


  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.5)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)