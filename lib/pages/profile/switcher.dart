import 'package:flutter/material.dart';
import 'package:travel_app/configuration/session.dart';
import 'package:travel_app/pages/profile/profile.dart';
import 'package:travel_app/pages/profile/log_in.dart';

class Switcher extends StatelessWidget {
  Switcher();

  @override
  Widget build(BuildContext context) {
    if (Session.user == null) {
      return LogIn();
    } else {
      return Profile();
    }
  }
}
