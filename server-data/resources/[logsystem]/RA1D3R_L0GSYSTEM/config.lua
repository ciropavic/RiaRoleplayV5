-- Araç transfer işleminin çalışmasını istiyorsanız: https://github.com/D3uxx/ESX_GiveCarKeys kullanmak zorundasınız.
-- Motel envanter işleminin çalışmasını istiyorsanız: lsrp-motels veya esx_property kullanmak zorundasınız.
-- Hapishane işleminin çalışmasını istiyorsanız: https://github.com/esx-community/esx_jail kullanmak zorundasınız.
-- Telefon logları sadece GCPHONE ile uyumludur.

Config = {}
Config.BilgileriPaylas = true -- Her log mesajında oyuncunun bütün bilgilerini görmek istiyorsanız bunu bu şekilde bırakın aksi taktirde false yapın.
Config.WebhookURLs = {
	["Doktor Kaldırma"] = "https://discord.com/api/webhooks/813442290122883082/_j5sD6CZJrtxtP7SpFkRlFYhWIA9A_djOD1FVbsGIDfVRwbEIinN7HpsrJV3_GaRLE1x",
	["Item Transferi"] = "https://discord.com/api/webhooks/813442184355250216/VDjqet-7Ec_ir4nUGeo-euj53dbzfDh9x6az4MRRUXCJexnQag8LMzIUx59scDo01DXT",
	["Item Silme"] = "",
	["Fatura Verme"] = "https://discord.com/api/webhooks/813442005299888138/rP8V4RNGVmou9_-2x-7fBaQTFxPX4uHjmdYDRG8HsT0_Jz4AqFtYg09rH8ugogJitV8B",
	["Olum"] = "https://discord.com/api/webhooks/813432780197199903/gmo4J-ozBMKMYALR7URanW9b1E6TEHsOXYp43l__XQODymWaV1rs92mg6SDM6RW4ZQq3",
	["Polis El Koyma"] = "",
	["Motel Envanter İşlemi"] = "https://discord.com/api/webhooks/813444884961820733/U-dg3JkntDn-5iPuUY2Bvdt6enETtAHd8gslc3Ouf9eOmfagpzOe8Lw3YZOf_h6-99Kp",
	["Chat"] = "https://discord.com/api/webhooks/813447137928151101/siXsMbrFDiG3XFrYKC05FthNcDrVeRy-BLGF01ma9pSSEoFmEkUxvGSPIYp-BP7Y2e0X",
	["Bagaj Envanter İşlemi"] = "",
	["Topluluk Hizmeti İşlemi"] = "",
	["Giriş Yapma"] = "https://discord.com/api/webhooks/813436610812182561/fzhXln88v_hc1A_XKQVfuvL_6z2x2C36sttltPtM11fxTn7H5P7Xap32KG1DHHJFORF6",
	["Çıkış Yapma"] = "https://discord.com/api/webhooks/813436777150414909/AMshufh5m06pveWpo_EQvTf43kFnlNnpzZjIq_L8gxay9kjP-KjJ6t0dijRzUvLlpTg0",
	["Polis Kasası İşlemi"] = "",
	["Araç Transfer İşlemi"] = "",
	["Twitter"] = "https://discord.com/api/webhooks/813436959443255336/ki6yug2h2woVQld_mt1OHjpO0n8QPHKEpuuiJcoCC1QB1n3VGeT5fjEYY-gI2n4TGRtR",
	["Sarı Sayfalar"] = "https://discord.com/api/webhooks/813440071193591838/uIIz2t9fYfq49be-1z4NoZmM21Tjcg25jc3yNhWdw-E7fyQMcl4---i6Zj1m6wSkSP1s",
	["Telefon Araması"] = "https://discord.com/api/webhooks/813440145302487100/Hn_fykGGl27Y6QPN654FvviSawWXX0ksXQ3C116mM6Pm6D5gqhNgs8pk11nx6AkTVYv2",
	["Telefon Mesajı"] = "https://discord.com/api/webhooks/813441192020541460/hRwSjg-dXbgShqgkLWZ9NMpK6ECjh4EeqO10O5tS5-37fwmClYG-_AgUSmX1Ebc-UDMd",
	["Instagram"] = "https://discord.com/api/webhooks/813440258208301127/xEM0brq9Y6QT1bwM-PRFjQvlOiEDjtgIyUnFe0xo9jqqmLlRFzGXehy4SS9l58fzNlJh",
	["Üst Soyma"] = "",
	["Banka İşlemi"] = "https://discord.com/api/webhooks/813438808381063228/QYQhaoBz46wx-LTNLk9jocII-wtpzdjO901txnH7mM0VK8eTqyheCY7PkXaNTjlWAnL0",
	["Hapishane İşlemi"] = "https://discord.com/api/webhooks/813440414278615141/fsvO794w4BT07aGbGrbz9orCiFWRejq_KtBDaVVxd4WitJ5Ivb0E_cvx7P-FsD8z8zLy",
}