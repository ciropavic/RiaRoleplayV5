Config = {}

Config.Healing = 3 -- // If this is 0, then its disabled.. Default: 3.. That means, if a person lies in a bed, then he will get 1 health every 3 seconds.

Config.objects = {
	ButtonToSitOnChair = 58, -- // Default: G -- // https://docs.fivem.net/game-references/controls/
	ButtonToLayOnBed = 38, -- // Default: E -- // https://docs.fivem.net/game-references/controls/
	ButtonToStandUp = 23, -- // Default: F -- // https://docs.fivem.net/game-references/controls/
	SitAnimation = {anim='PROP_HUMAN_SEAT_CHAIR_MP_PLAYER'},
	BedBackAnimation = {dict='anim@gangops@morgue@table@', anim='ko_front'},
	BedStomachAnimation = {anim='WORLD_HUMAN_SUNBATHE'},
	BedSitAnimation = {anim='WORLD_HUMAN_PICNIC'},
	locations = {

		{object="v_serv_ct_chair02", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.0, direction=168.0, bed=false},
		{object="bkr_prop_biker_boardchair01", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.1, direction=168.0, bed=false},
		{object="apa_mp_h_stn_chairarm_03", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.3, direction=168.0, bed=false},
		{object="ex_mp_h_stn_chairstrip_01", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.1, direction=168.0, bed=false},
		{object="prop_off_chair_04", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_off_chair_03", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_off_chair_05", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_club_officechair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_ilev_leath_chr", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_corp_offchair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="Prop_Off_Chair_01", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object="v_med_p_deskchair", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object="prop_bench_01a", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object="prop_table_03_chr", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object="prop_patio_lounger1", verticalOffsetX=-0.2, verticalOffsetY=0.0, verticalOffsetZ=-1.3, direction=180.0, bed=true},
		{object="prop_table_01_chr_a", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.0, direction=180.0, bed=false},
		{object="prop_patio_lounger_3", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.3, direction=180.0, bed=true},
		{object="prop_bench_09", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.3, direction=180.0, bed=false},
		{object="prop_bench_08", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.5, direction=180.0, bed=false}
		
		
	}
}

-- // YOU WILL FIND ALL BUTTONS HERE FOR CODE BELOW;P
-- [[ https://docs.fivem.net/game-references/controls/ ]]

Config.Text = {
	SitOnChair = 'Oturmak için G tusuna bas',
	SitOnBed = '~r~E~w~ oturmak için',
	LieOnBed = '~r~E~w~ uzanmak için',
	SwitchBetween = 'Yatıs pozisyonunu degistirmek için basınız ~r~Sag Ok~w~ ve ~r~Sol Ok~w~',
	Standup = 'Kalmak için F tusuna bas!',
}