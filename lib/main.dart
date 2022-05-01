import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language_builder/language_builder.dart';
import 'package:travel_app/configuration/config.dart';
import 'package:travel_app/language/languages.dart';
import 'package:travel_app/model/country.dart';
import 'package:travel_app/pages/main_page/home.dart';
import 'package:travel_app/widgets/loading.dart';
import 'configuration/session.dart';
import 'test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  //-----------------//

  //String lang = 'en'; //default

  // //get device's currently preffered language, then set it for app.
  // //if there is no config for that lang, the default is 'en'
  // List languages = [];
  // String lang;
  // try {
  //   languages = await Devicelocale.preferredLanguages;
  //   if (languages[0].toString().contains('-')) {
  //     //for iOS devices it is seperated by "-"
  //     lang = languages[0].toString().split('-')[0];
  //   } else if (languages[0].toString().contains('_')) {
  //     //for android devices it is seperated by "_"
  //     lang = languages[0].toString().split('_')[0];
  //   }
  // } on PlatformException {}

  //set session language
  //Session.setLang(lang);

  //-------------------//

  //set models -- experimental
  TEST.setSlides();

  InitializeApp.init();

  //Change afterwards
  //Session.session.user = new User();

  runApp(
    CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: TravelApp(),
    ),
  );
}

class TravelApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<TravelApp> createState() => _TravelAppState();
}

class _TravelAppState extends State<TravelApp> {
  @override
  Widget build(BuildContext context) {
    Screen.width = MediaQuery.of(context).size.width;
    Screen.height = MediaQuery.of(context).size.height;
    Session.session.sessionId = 5;
    Session.version = '1.0.0';
    return LanguageBuilder(
      useDeviceLanguage: false,
      defaultLanguage: 'en',
      languagesMap: Languages.languages,
      child: Loading(
        route: MainPage(),
      ),
    );
  }
}

//Run this class to initialize app
class InitializeApp {
  static void init() {
    Future<void> readJson() async {
      final String response =
          await rootBundle.loadString(AssetPath.countriesJsonPath);
      final data = await json.decode(response);
      Map<String, dynamic> countryMap = data;
      List<Country> _countries = [];
      for (var item in countryMap.entries) {
        Country c = Country(
          name: item.value['name'],
          nativeName: item.value['native'],
          code: item.key.toLowerCase(),
          phone: int.parse(item.value['phone']),
          icon: 'assets/countries/' + item.key.toLowerCase() + '.svg',
        );
        _countries.add(c);
      }
      Session.countries = _countries;
    }

    readJson();
  }
}
