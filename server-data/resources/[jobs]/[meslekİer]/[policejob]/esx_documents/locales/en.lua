Locales['en'] = {
    ['document_deleted'] = "Döküman silindi.",
    ['document_delete_failed'] = "Döküman silindi başarısız oldu.",
    ['copy_from_player'] = "Form kopyası aldınız",
    ['from_copied_player'] = "Form kopyalandı ",
    ['could_not_copy_form_player'] = "Form not copy form to player.",
    ['document_options'] = "Döküman Seçenekleri",
    ['public_documents'] = "Herkese Açık Belgeler",
    ['job_documents'] = "Is Belgeleri",
    ['saved_documents'] = "Kaydedilen Belgeler",
    ['close_bt'] = "Kapat",
    ['no_player_found'] = "Oyuncu bulunamadı",
    ['go_back'] = "Geri Dön",
    ['view_bt'] = "Görünüm",
    ['show_bt'] = "Göstermek",
    ['give_copy'] = "Kopyasını Ver",
    ['delete_bt'] = "Sil",
    ['yes_delete'] = "Evet Sil",
}

Config.Documents['en'] = {
      ["public"] = {
        {
          headerTitle = "ONAY FORMU",
          headerSubtitle = "Vatandaş Onay Formu",
          elements = {
            { label = "ONAY İÇERİĞİ", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "TANIK IFADESI",
          headerSubtitle = "Resmi Tanık",
          elements = {
            { label = "OLUŞMA TARİHİ", type = "input", value = "", can_be_emtpy = false },
            { label = "TANIKLIK İÇERİGİ", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "ARAC TASIMA BEYANI",
          headerSubtitle = "ARACI BASKA BIR SEHIRLIYE DEVRETME",
          elements = {
            { label = "Plaka Numarası", type = "input", value = "", can_be_emtpy = false },
            { label = "Vatandaş Adı Soyadı", type = "input", value = "", can_be_emtpy = false },
            { label = "Satılan Fiyat", type = "input", value = "", can_be_empty = false },
            { label = "Açıklamalar", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "VATANDASA KARSI BORC BEYANI",
          headerSubtitle = "Resmi Borç Beyanı",
          elements = {
            { label = "KREDİ ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "KREDİ VERENİN SOYADI", type = "input", value = "", can_be_emtpy = false },
            { label = "ALACAK MİKTARI", type = "input", value = "", can_be_empty = false },
            { label = "BİTİŞ TARİHİ", type = "input", value = "", can_be_empty = false },
            { label = "DİĞER BİLGİLER", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "BORC TEMIZLIK BEYANI",
          headerSubtitle = "Başka bir vatandaştan borç tasfiyesi beyanı.",
          elements = {
            { label = "Borçlunun Adı", type = "input", value = "", can_be_emtpy = false },
            { label = "Borçlunun Soyadı", type = "input", value = "", can_be_emtpy = false },
            { label = "BORÇ TUTARI", type = "input", value = "", can_be_empty = false },
            { label = "DİĞER BİLGİLER", type = "textarea", value = "SÖZ KONUSU VATANDAŞIN SÖZ KONUSU BORÇ MİKTARI İLE BİR ÖDEME YAPTIĞINI BEYAN EDERİM", can_be_emtpy = false, can_be_edited = false },
          }
        }
      },
      ["police"] = {
        {
          headerTitle = "PARK IZNI",
          headerSubtitle = "Özel sınırsız park izni",
          elements = {
            { label = "TUTUCU İLK ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "TUTUCU SON ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "GEÇERLİ TARİH", type = "input", value = "", can_be_empty = false },
            { label = "AÇIKLAMA", type = "textarea", value = "SÖZ KONUSU VATANDAŞLARA HER ŞEHİR BÖLGESİNDE SINIRSIZ PARK İZNİ VERİLMİŞTİR VE SÖZ KONUSU SONA ERME TARİHİNE KADAR GEÇERLİDİR.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "TABANCA IZNI",
          headerSubtitle = "Polis tarafından verilen özel silah izni",
          elements = {
            { label = "TUTUCU İLK ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "TUTUCU SON ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "GEÇERLİ TARİH", type = "input", value = "", can_be_empty = false },
            { label = "AÇIKLAMA", type = "textarea", value = "SÖZ KONUSU VATANDAŞ, SÖZ KONUSU SONA ERME TARİHİNE KADAR GEÇERLİ OLACAK BİR TABANCA İZNİNE İZİN VERİLMEKTEDİR.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "TEMIZ VATANDAS CEZA KAYDI",
          headerSubtitle = "Resmi temiz, genel amaçlı, vatandaş adli sicil kaydı.",
          elements = {
            { label = "VATANDAŞ ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "VATANDAŞ SOYADI", type = "input", value = "", can_be_emtpy = false },
            { label = "GEÇERLİ TARİH", type = "input", value = "", can_be_empty = false },
            { label = "KAYIT", type = "textarea", e = "POLİS BURADA SÖZ KONUSU VATANDAŞIN AÇIK BİR CEZA KAYDI OLDUĞUNU BEYAN EDER. BU SONUÇ, BELGE İMZA TARİHİNE GÖRE CEZA KAYDI SİSTEMİNE GÖNDERİLEN VERİLERDEN ÜRETİLMEKTEDİR.", can_be_emtpy = false, can_be_edited = false },
          }         }
      },
      ["justice"] = {
        {
          headerTitle = "KARARNAME",
          headerSubtitle = "Bir SAVCI tarafından sağlanan hukuk hizmetleri sözleşmesi.",
          elements = {
            { label = "VATANDAŞ ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "VATADANDAŞ SOYADI", type = "input", value = "", can_be_emtpy = false },
            { label = "GEÇERLİLİK", type = "input", value = "", can_be_empty = false },
            { label = "BİLGİ", type = "textarea", value = "Şanık belirlenen tarihe kadar hapse tutulmuştur.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "ARAMA EMRİ",
          headerSubtitle = "Bir savcı tarafından sağlanan arama emri",
          elements = {
            { label = "VATANDAŞ ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "VATADANDAŞ SOYADI", type = "input", value = "", can_be_emtpy = false },
            { label = "GEÇERLİLİK", type = "input", value = "", can_be_empty = false },
            { label = "BİLGİ", type = "textarea", value = "Bu belge bir yerin aranması için yeterli bir belgedir ve savcı tarafından imzalanmıştır", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "DAVA GÜNÜ ERTLEMESI",
          headerSubtitle = "Bir mahkeme sonucu ertelenme günü kararını açıklar",
          elements = {
            { label = "Vatandaş Adı", type = "input", value = "", can_be_emtpy = false },
            { label = "Vatandaş Soyadı", type = "input", value = "", can_be_emtpy = false },
            { label = "Ertelenme Günü", type = "input", value = "", can_be_empty = false },
            { label = "Bilgi", type = "textarea", value = "Bu ertelenme süreci adaletin doğruluğunu ve gerçekliğini temsil eder. Ertelenen tarihte sanıkların davaya gelmesi zorunludur", can_be_emtpy = false },
          }
        }
      },
      ["ambulance"] = {
        {
          headerTitle = "TIBBI RAPOR - PATOLOJI",
          headerSubtitle = "Bir patolog tarafından sağlanan resmi tıbbi rapor.",
          elements = {
            { label = "HASTA ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "HASTA SOYADI", type = "input", value = "", can_be_emtpy = false },
            { label = "GECERLI NOT", type = "input", value = "", can_be_empty = false },
            { label = "MEDIKAL NOTLARI", type = "textarea", value = "SÖZ KONUSU SİGORTALI VATANDAŞ, SAĞLIK HİZMETLERİ GÖREVLİLERİ TARAFINDAN TEST EDİLMİŞTİR VE SAĞLIKLI, UZUN SÜRELİ ŞARTLAR BELİRLENMİŞTİR. BU RAPOR SÖZ KONUSU SONA ERME TARİHİNE KADAR GEÇERLİDİR.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "TIP RAPORU - PSIKOLOJI",
          headerSubtitle = "Bir psikolog tarafından sağlanan resmi tıbbi rapor.",
          elements = {
            { label = "HASTA ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "HASTA SOYADI", type = "input", value = "", can_be_emtpy = false },
            { label = "GEÇERLİ TARİH", type = "input", value = "", can_be_empty = false },
            { label = "MEDİKAL NOTLAR", type = "textarea", value = "SÖZ KONUSU SİGORTALI VATANDAŞ, SAĞLIK HİZMETLERİ GÖREVLİLERİ TARAFINDAN TEST EDİLMİŞTİR VE EN DÜŞÜK ONAYLANAN PSİKOLOJİ STANDARTLARINA GÖRE ZİHİNSEL SAĞLIKLI BİR ŞEKİLDE BELİRLENMİŞTİR. BU RAPOR SÖZ KONUSU SONA ERME TARİHİNE KADAR GEÇERLİDİR.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "TIP RAPORU - GÖZ UZMANI",
          headerSubtitle = "Bir göz uzmanı tarafından sağlanan resmi tıbbi rapor.",
          elements = {
            { label = "HASTA ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "HASTA SOYADI", type = "input", value = "", can_be_emtpy = false },
            { label = "GEÇERLİ TARİH", type = "input", value = "", can_be_empty = false },
            { label = "MEDIKAL NOTLAR", type = "textarea", value = "SÖZ KONUSU SİGORTALI VATANDAŞ BİR SAĞLIK GÖREVLİ TARAFINDAN TEST EDİLMİŞ VE SAĞLIKLI VE DOĞRU BİR GÖZLE BELİRLENMİŞTİR. BU RAPOR SÖZ KONUSU SONA ERME TARİHİNE KADAR GEÇERLİDİR.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "MARIO KULLANIM IZNI",
          headerSubtitle = "Vatandaşlar için resmi tıbbi mario kullanım izni.",
          elements = {
            { label = "HASTA ADI", type = "input", value = "", can_be_emtpy = false },
            { label = "HASTA SOYADI", type = "input", value = "", can_be_emtpy = false },
            { label = "GECERLI MIKTAR", type = "input", value = "", can_be_empty = false },
            { label = "MEDIKAL NOTLAR", type = "textarea", value = "SÖZ KONUSU SİGORTALI VATANDAŞ, TIBBİ NEDENLERE DAYANARAK BİR SAĞLIK UZMANI MARIJUANA KULLANIM İZNİ TARAFINDAN TAMAMEN İNCELENMİŞTİR. BİR VATANDAŞIN ALABİLECEĞİ YASAL VE İZİN VERİLEN MİKTAR 10 gramdan FAZLA OLAMAZ.", can_be_emtpy = false, can_be_edited = false },
          }
        },
      }
    }
