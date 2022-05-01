import 'package:travel_app/model/country.dart';
import 'package:travel_app/model/user.dart';

class Session {
  int _sessionId;

  static String version;

  static User user;

  static Country selectedCountry;

  //country info
  //Map<String, dynamic> countriesMap;
  static List<Country> countries;

  static Session session = Session();

  Session();

  int get sessionId {
    return this._sessionId;
  }

  set sessionId(int sessionId) {
    this._sessionId = sessionId;
  }

  // User get user {
  //   return this._user;
  // }

  // set user(user) {
  //   this._user = user;
  // }
}
