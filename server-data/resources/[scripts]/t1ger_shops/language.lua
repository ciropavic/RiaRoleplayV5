-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

Lang = {
	-- ## MENU STRINGS ## --
	['button_yes']         	    = 'Evet',
	['button_no']         	    = 'Hayır',
	['button_return']         	= 'Geri',
	-- shop [menu]: 
	['shop_payment_type']       = 'Ödeme Türünü Seçin',
	['shop_confirm_item']       = 'Satın alıcak mısın %sx %s fiyatı: $%s?',
	['button_cash']         	= 'Nakit ile Öde',
	['button_card']         	= 'Kart ile Öde',
	['confirm_basket']			= 'Sepeti Onaylayın',
	['shop_add_to_basket']      = 'Sepete %sx %s fiyatı : $%s olan malzeme koyulsun mu?',
	['empty_basket']      		= 'Bos Sepet',
	['confirm_empty_basket']    = 'Sepeti Bosaltmayı Onaylayın',
	['basket_remove_item']    	= 'Item Kaldır',
	['sell_shop']         		= 'Marketi Sat',
	['order_stock']        		= 'Stok Siparis Et',
	-- employees [menu]:
	['employees_action']        = 'Calısanlar',
	['hire_employee']           = 'Calısanları İse almak',
	['employee_list']           = 'İsçi listesi',
	['fire_employee']           = 'Yangın Çalısanı',
	['employee_job_grade']      = 'İs Derecesi Yönetme',
	-- accounts [menu]:
	['accounts_action']         = 'Hesaplar',
	['account_withdraw']        = 'Para Çekmek',
	['account_deposit']         = 'Depozito',

	-- ## NOTIFICATIONS ## --
	['not_enough_money']        = 'Yeterli paran yok.',
	['invalid_amount']          = 'Geçersiz Tutar',
	['invalid_string']          = 'Geçersiz Dize',
	['item_limit_exceed']       = '~y~%s~s~ sınırı ~r~ asıldı~s~, maksimum ~g~%s~s~ tasıyabilirsiniz.',
	-- weapon [notifications]:
	['hold_wep_in_hands']       = 'Bunu yapmak için silahı elinizde tutmalısınız ',
	['ammo_incompatible']       = 'Seçilen cephane, seçilen silahla uyumsuzdur.',
	['ammo_unavailable']       	= 'Seçili silah için cephane mevcut değil.',
	['ammo_limit_exceed']       = 'Cephane sınırı asıldı, seçilen silahta maksimum 250 cephane.',
	['wep_restock_amount']      = 'Silah stok miktarı 1 adetten fazla olamaz..',
	['ammo_restock_amount']     = 'Cephane stoklama miktarı, teçhizat cephane sayısına kıyasla yetersiz.',
	['wep_already_in_loadout']  = 'Zaten o silahı teçhizatında tutuyorsun.',
	-- shop [notifications]:
	['shop_purchased']        	= 'Bir ~b~shop~s~ satın aldınız ve ~g~$%s~s~ ödediniz',
	['shop_sold']          		= '~b~Dükkanınızı~s~ sattınız ve ~g~$%s~s~ aldınız',
	['item_purchased']			= 'Satın Aldın ~b~%sx~s~ ~y~%s~s~ Fiyatı: ~g~$%s~s~.',
	['basket_is_empty']			= 'Senin sepetin bos.',
	['basket_paid']				= 'Sepetteki ürünler için ~g~$%s~s~ ödediniz.',
	['basket_emptied']			= 'Sepet bosaltıldı. Dükkandan ayrıldın.',
	['you_emptied_basket']		= 'Sepetini bosalttın',
	['basket_item_removed']		= 'Sepetinden ~b~%sx~s~  ~y~"%s"~s~ kaldırıldı',
	['basket_item_added']		= 'Sepetine: ~b~%sx~s~ ~y~%s~s~ koydun. Fiyat: ~g~$%s~s~.',
	['item_not_available']		= 'Maalesef seçili öğe mevcut değil.',
	['no_shelves']				= 'Raf yok.',
	-- employee [notifications]:
	['no_employees_hired']      = 'Mağazanızda çalısan yok',
	['shop_employee_fired']     = 'Dükkandan kovuldun',
	['target_alrdy_has_job_g']  = '%s zaten o is notuna sahip.s',
	['your_job_grade_updated']  = 'İs notunuz olarak güncellendi: %s.',
	['you_updat_job_grade_for'] = 'Sunun için is notunu güncellediniz: %s to: %s.',
	['mix_max_job_grade']       = 'Min İs Notu: 0 | Maksimum İs Sınıfı: %s.',
	['already_hired']           = 'Oyuncu zaten ise alındı.',
	['you_recruited_x']         = 'Terfi Aldınız: %s.',
	['you_have_been_recruited'] = 'Dükkana üye oldunuz.',
	-- stock [notifications]:
	['no_stock_in_shelf']		= 'Bu rafta ürün stoğu yok.',
	['shelf_item_deposit']    	= 'Yeniden stokladınız ~y~%sx~s~ ~b~%s~s~',
	['item_exists_shelf']    	= 'Bu öğeyi baska bir rafta tutuyorsunuz, lütfen orada yeniden doldurun.',
	['not_enough_items']        = 'Para yatırmak için yeterli öğe yok.',
	['stock_inv_empty']       	= 'Raf Stoku Bos.',
	['shelf_item_withdraw']     = 'Raftan ~y~%sx~s~ ~b~%s~s~ aldınız.',
	['shelf_item_price_change'] = '~y~%s~s~ fiyatını ~g~$%s~s~ dan~g~$%s~s~ a/e güncellendi.',
	['stock_order_placed']     	= 'Mağazaya ~g~%s~s~ karşılığında ~b~%x~s~ ~y~%s~s~ siparişi verdiniz.',
	['stock_order_updated']     = 'Mevcut bir siparişe ~b~%sx~s~ ~y~%s~s~ eklediniz ~g~$%s~s~. Ödediniz.',

	-- ## DRAW 3D STRINGS ## --
	['press_to_buy_shop']       = '~r~[E]~s~ Market Satın Al [~g~$%s~s~]',
	['boss_menu_access']        = '~r~[E]~s~ Yönetim',
	['cashier_draw']        	= 'Kasiyer',
	['manage_stock']        	= 'Stok Yönet',

	-- ## BLIP STRINGS ## --
	['player_shop_blip']    	= 'Sahip Olduğun Marketin',
	['shop_blip']    			= 'Market',
}

