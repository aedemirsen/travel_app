import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:language_builder/language_builder.dart';
import 'package:travel_app/configuration/config.dart';
import 'package:travel_app/configuration/session.dart';
import 'package:travel_app/model/country.dart';

class CountryCodes extends StatefulWidget {
  @override
  State<CountryCodes> createState() => _CountryCodesState();
}

class _CountryCodesState extends State<CountryCodes> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _texts = LanguageBuilder.texts['country_codes'];
    List<Country> _countries = Session.countries;
    return Scaffold(
      appBar: AppBar(
        title: Text(_texts['codes']),
      ),
      body: ListView(
        children: _countries.map((e) {
          return Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, e);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      e.icon,
                      height: 25,
                      width: 25,
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      e.name,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        color: Colors.black,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      '(+' + e.phone.toString() + ')',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
