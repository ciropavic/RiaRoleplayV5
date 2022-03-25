-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

Lang = {
  -- Menu Text:
  ['button_yes']         	    = 'Evet',
  ['button_no']         	    = 'Hayır',
  ['button_return']         	= 'Dönüs',
  ['rename_company']          = 'Sirketi Yeniden Adlandır',
  ['sell_company']            = 'Sirket Sat',
  ['company_level']           = 'Sirket Seviyesi',
  ['company_level_value']     = 'Sirket Düzeyi: % s',
  ['certificate_state']       = 'Belgesi Var: %s',
  ['buy_certificate']         = 'Sertifika Satın Al',
  ['request_job']             = 'İs İste',
  ['select_job_value']        = 'İs Değerini Seçin',
  ['select_job_vehicle']      = 'İs Aracını Seçin',

  -- Draw 3D Texts:
  ['manage_company']          = '~r~[E]~s~ Sirketi Yönet',
  ['no_access_company']       = 'Erisim Yok',
  ['press_to_buy_firm']       = '~r~[E]~s~ Sirket Satın Alın',
  ['only_one_company']        = 'SADECE KENDİ 1 SİRKET',
  ['load_the_job_veh']        = '~r~[E]~s~ ARACI DOLDURUN',
  ['pick_up_parcel']          = '~r~[E]~w~ Parsel Al',
  ['put_parcel_in_veh']       = '~r~[E]~s~ Koliyi Araca Koy',
  ['take_parcel_from_veh']    = '~r~[E]~s~ Araçtan Koli Al',
  ['deliver_parcel']          = '~r~[G]~s~ Parsel Teslim Et',
  ['return_vehicle']          = '~r~[E]~s~ Dönüs Aracı | Maas Çeki Alın',
  ['fill_up_trailer']         = '~r~[E]~s~ Traileri Doldurun',
  ['put_pallet_in_trailer']   = '~r~[E]~s~ Paleti Römorka Koy',
  ['park_the_forklift']       = '~r~[G]~s~ Forklifti park et',
  ['take_the_forklift']       = '~r~[G]~s~ Forklifti Çıkarın',
  ['deliver_pallet']          = '~r~[E]~s~ Paleti teslim et',

  -- Draw Mission Texts:
  ['pick_up_pallet']          = '~r~Pallet~s~ i al',
  ['load_into_trailer']       = '~r~Pallet~s~ i ~b~Trailer~s~ a yükle',
  ['get_pallet_from_trailer'] = '~r~Paletleri~b~ trailerden alın',
  ['forklift_into_trailer']   = 'Forkliftleri Trailerlara sürün',
  ['pick_up_the_pallet']      = 'Paleti al',
  ['park_instrunctions']      = 'Römorkların arka uçlarını, İsaretçilerin üzerine park edin.',
  ['drop_off_the_pallet']     = 'Paleti Teslim Et',

  -- Notifications:
  ['not_enough_money']        = 'Yeterli paran yok.',
  ['company_bought']          = 'Bir sirket satın aldınız ve %s$ ödediniz',
  ['company_sold']            = 'Sirketinizi sattınız ve sirketinizden %s$ elde ettiniz',
  ['not_your_company']        = 'Bu sirketin sahibi değilsin',
  ['company_renamed']         = 'Sirketinizin adını su sekilde değistirdiniz: %s',
  ['alrdy_has_certificate']   = 'Sirketiniz zaten sertifikaya sahip',
  ['certificate_acquired']    = 'Sirketiniz artık bir sertifika aldı',
  ['job_level_mismatch']      = 'Mevcut seviyeniz is gereklilikleriyle eslesmiyor',
  ['job_needs_certificate']   = 'İs bir sertifika gerektiriyor',
  ['deposit_veh_paid']        = 'Araç için %s $ depozito ödediniz.',
  ['not_enough_to_deposit']   = 'Depozitoyu ödemek için yeterli paranız yok..',
  ['job_veh_spawned']         = 'Aracınız geldi ve bir çift anahtar aldınız. Günlük Çalışma limitiniz 5000$ fazlası zaman kaybı kolay gelsin!',
  ['sit_in_job_veh']          = 'Lütfen is aracınızı getirin!',
  ['job_veh_mismatch']        = 'Bu senin is aracın değil mi?',
  ['vehicle_filled_up']       = 'Aracı doldurdunuz. İçeri girin ve teslimatlara baslayın.',
  ['parcel_not_ind_hand']     = 'Araçtan bir paket alın.',
  ['set_delivery_route']      = 'Teslimata sonraki hedefele birlikte devam et ~',
  ['delivery_complete']       = 'Tüm paketleri teslim ettin. Aracıları iade edin ve maas çeklerini geri alın',
  ['parcel_damaged_transit']  = 'Bu paket nakliye sırasında hasar gördü, bu teslimat için ödeme yapılmadı',
  ['paycheck_add_amount']     = '+%s $ [maas çekine eklendi]',
  ['deposit_not_returned']    = 'Depozito iade edilmedi, araç çok fazla hasar gördü.',
  ['deposit_returned']        = '+%s $ [araç depozitosu iade edildi]',
  ['paycheck_received']       = '+%s $ [maas alındı]',
  ['delivery_pallets_done']   = 'Tüm paletleri teslim ettin. Ofise geri dön, maas çekini geri al.',
  ['pallet_damaged_transit']  = 'Bu palet nakliye sırasında hasar gördü, bu teslimat için ödeme yapılmadı',
  ['not_inside_forklift']     = 'Forklifti getirmen gerekiyor',
  ['forklift_mismatch']       = 'Bu doğru forklift değil mi?',
  ['trailer_filled_up']       = 'Trailerı doldurdunuz. Römorku kamyona takın ve teslimatları baslatın..',
  ['park_fork_in_trailer']    = 'Forkliftleri yeniden römorkun içine park edin.',
  ['place_pallet_on_ground']  = 'Paletleri yere park edin!',
  ['no_available_orders']     = 'Alınacak mevcut siparis yok.',

  -- Progress Bar Texts:
  ['delivering_load']         = 'YÜK TESLİMİ',

  -- Blip Texts:
  ['vacant_companies']        = 'Bos Sirketler',
  ['delivery_blip']           = 'Teslim Yeri',
  ['trucking_blip']           = 'Teslim Bırakma',
  ['return_blip']             = 'Maas Çeki Alın',
}
