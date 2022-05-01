class Languages {
  static Map<String, String> languages = {
    "tr": """{
        "sliver_app_bar": {
            "search_hint": "Nereye Gidiyorsun?",
            "button": "Tatil Planı Hazırla"
        },
        "list_views": {
            "label_1": "Popüler Konumlar",
            "label_2": "Popüler Turlar"
        },
        "profile_page": {
            "previousTrips": "Önceki Gezilerim",
            "favoritePlans": "Favori Planlarım",
            "paymentMethods":"Ödeme Yöntemlerim",
            "billInfo":"Fatura Bilgilerim",
            "changePassword":"Şifremi Değiştir",
            "communicationPref":"İletişim Tercihleri",
            "help":"Yardım",
            "exit":"Çıkış Yap",
            "language":"Dil",
            "version":"Versiyon"
        },
        "change_language":{
          "title":"Dil Değiştir"
        },
        "log_in":{
          "log_in":"Giriş Yap",
          "log_in_email":"E-Mail",
          "log_in_phone":"Cep Telefonu",
          "password":"Şifre",
          "reset_password":"Şifremi Unuttum",
          "sign_up":"Kayıt Ol"
        },
        "country_codes":{
          "codes":"Ülke Telefon Kodları"
        }


    }""",
    "en": """{
        "sliver_app_bar": {
            "search_hint": "Where are you going?",
            "button": "Get Trip Plan"
        },
        "list_views": {
            "label_1": "Popular Destinations",
            "label_2": "Popular Tours"
        },
        "profile_page": {
            "previousTrips": "My Previous Trips",
            "favoritePlans": "My Favorite Plans",
            "paymentMethods":"Payment Methods",
            "billInfo":"Bill Info",
            "changePassword":"Change Password",
            "communicationPref":"Communication Preferences",
            "help":"Help",
            "exit":"Exit",
            "language":"Language",
            "version":"Version"
        },
        "change_language":{
          "title":"Change Language"
        },
        "log_in":{
          "log_in":"Log In",
          "log_in_email":"E-Mail",
          "log_in_phone":"Mobile Phone",
          "password":"Password",
          "reset_password":"Forgot Password",
          "sign_up":"Sign Up"
        },
        "country_codes":{
          "codes":"Country Phone Codes"
        }
        

    }"""
  };

  static String getLangByCode(String code) {
    switch (code) {
      case 'tr':
        return 'Türkçe';
      case 'en':
        return 'English';
      default:
        return 'Null';
    }
  }
}
