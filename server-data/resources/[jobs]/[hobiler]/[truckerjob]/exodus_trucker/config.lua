Config = {
    JobCenter = vector3(-35.98, -2096.25, 15.94),
    ReAdd = 60, -- seconds after a job is finished until its shown again
    Job = {
        ['jobRequired'] = false, -- if true: only players with the specified job can work, false everyone can work
        ['jobName'] = 'trucker',
    },
    Jobs = {
        -- {title = 'title', payment = reward, vehicles = {'truck', 'trailer'}, start = {vector3(x, y, z), heading}, trailer = {vector3(x, y, z), heading}, arrive = vector3(x, y, z)}
        {title = 'IKEA (UZUN MENZIL)', payment = 30000, vehicles = {'daf', 'trailers'}, start = {vector3(-25.87, -2079.01, 15.7), 108.51}, trailer = {vector3(-72.21, -2095.72, 16.7), 108.89}, arrive = vector3(2671.0, 3530.35, 51.26)},
        {title = 'SUPERMARKET (KISA MENZIL)', payment = 3000, vehicles = {'daf', 'trailers2'}, start = {vector3(-24.97, -2082.83, 15.79), 109.24}, trailer = {vector3(-75.22, -2101.08, 16.7), 106.66}, arrive = vector3(103.57, -1819.37, 25.56)},
		{title = 'BENZİN TANKERI (UZUN MENZIL)', payment = 30000, vehicles = {'daf', 'tanker2'}, start = {vector3(-23.48, -2086.18, 15.79), 108.62}, trailer = {vector3(-124.14, -2113.7, 16.77), 108.61}, arrive = vector3(2655.59, 3264.27, 55.24)},
		{title = 'GALERİ ARAÇLARI (KISA MENZIL)', payment = 6200, vehicles = {'daf', 'tr4'}, start = {vector3(-22.5, -2089.98, 15.79), 102.22}, trailer = {vector3(-121.88, -2117.36, 16.77), 109.86}, arrive = vector3(-9.99, -1088.02, 26.75)},
		{title = 'DONMUŞ BALIK (ORTA MENZIL)', payment = 10000, vehicles = {'daf', 'trailers2'}, start = {vector3(-21.94, -2094.01, 15.79), 98.64}, trailer = {vector3(-43.04, -2107.23, 16.77), 110.15}, arrive = vector3(-1044.94, -1425.06, 5.43)},
		{title = 'KÜTÜK YIĞINI (ORTA MENZIL)', payment = 10000, vehicles = {'daf', 'trailerlogs'}, start = {vector3(-22.02, -2097.81, 15.79), 87.33}, trailer = {vector3(-43.67, -2112.37, 16.77), 109.13}, arrive = vector3(1388.48,-727.21, 67.27)},
		{title = 'YAT PARÇALARI KONTEYNER (KISA MENZIL)', payment = 7800, vehicles = {'daf', 'docktrailer'}, start = {vector3(-22.51, -2101.69, 15.79), 73.6}, trailer = {vector3(-72.0, -2118.37, 16.77), 109.46}, arrive = vector3(-708.78,-1283.47, 5.0)},
		{title = 'UÇAK TEKERLEKLERİ (UZUN MENZIL)', payment = 32000, vehicles = {'daf', 'trailers'}, start = {vector3(-23.78, -2105.35, 15.79), 60.08}, trailer = {vector3(-70.5, -2122.15, 16.77), 110.31}, arrive = vector3(1740.85,3288.53, 41.19)}
    },
}

Strings = {
    ['not_job'] = "Kamyoncu işine sahip değilsin!",
    ['somebody_doing'] = 'Biri zaten bu işi yapıyor, lütfen başka bir tane seçin!',
    ['menu_title'] = 'Tırcılık - iş seçin',
    ['e_browse_jobs'] = 'Mevcut işlere göz atmak için ~INPUT_CONTEXT~ Basın',
    ['start_job'] = 'Tırcılık Mesleği',
    ['truck'] = 'Kamyon',
    ['trailer'] = 'Dorse',
    ['get_to_truck'] = 'Binin ~y~Kamyon~w~!',
    ['get_to_trailer'] = 'Dorseye Gidin ~y~Dorse~w~ Takın!',
    ['destination'] = 'Hedef',
    ['get_out'] = 'İnin ~y~Kamyon~w~!',
    ['park'] = 'Park et ~y~Dorse~w~ hedefte.',
    ['park_truck'] = 'Hedefe Park Edin ~y~Kamyon~w~ .',
    ['drive_destination'] = 'Şuraya sürün ~b~hedef~w~.',
    ['reward'] = 'Aferin! Teslim Ettin ~g~$~w~%s',
    ['paid_damages'] = 'Bir dahaki sefere daha iyi sür! Ödedin ~r~$~w~%s neden olunan hasarlar için!',
    ['drive_back'] = ' ~y~Kamyonu ~w~aldığınız yere geri dönün.', 
    ['detach'] = 'Dorseyi Ayırın.'
}