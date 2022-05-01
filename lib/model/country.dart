import 'package:meta/meta.dart';

class Country {
  String name;
  String nativeName;
  String code;
  int phone;
  String icon;

  Country.c();
  Country(
      {@required this.name,
      @required this.nativeName,
      @required this.code,
      @required this.phone,
      @required this.icon});
}
