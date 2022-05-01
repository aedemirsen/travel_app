import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_builder/language_builder.dart';
import 'package:travel_app/configuration/config.dart';
import 'package:travel_app/language/languages.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangeLanguage();
}

class _ChangeLanguage extends State<ChangeLanguage> {
  //all texts using in this class
  final Map<String, dynamic> _texts = LanguageBuilder.texts['change_language'];

  //selected lang
  String _selectedLang;

  @override
  void initState() {
    _selectedLang = LanguageBuilder.getCurrentLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ChangeLanguageConf.appBarColor,
        title: Text(
          _texts['title'],
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: AppTheme.fontFamily,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Flex(
          direction: Axis.vertical,
          children: LanguageBuilder.getAvailableLanguages().map((e) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      if (e != LanguageBuilder.getCurrentLang()) {
                        LanguageBuilder.changeLanguage(e, context);
                      }
                    },
                    child: Builder(builder: (context) {
                      if (e == _selectedLang) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  Languages.getLangByCode(e),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: AppTheme.fontFamily,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(ChangeLanguageConf.checkIcon),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              Languages.getLangByCode(e),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: AppTheme.fontFamily,
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                ),
                Divider(
                  height: 0,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
