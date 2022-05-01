import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssetPath {
  static String countriesJsonPath = 'assets/country_codes.json';
}

class AppTheme {
  static String fontFamily = "Arial";
}

class Screen {
  static double width, height;
}

class MainPageConf {
  //Search box
  static double searchBarWidth = Screen.width - 80;
  static double searchBarHeight = 50;
  static double searchBarTopInset = 80;
  static double searchBarLeftInset = (Screen.width - searchBarWidth) / 2;
  static double searchBarVisibilityReference =
      searchBarTopInset + searchBarHeight;

  //drop down
  static double dropDownTopInset = searchBarTopInset + searchBarHeight + 20;
  static double dropDownLeftInset = searchBarLeftInset;
  static double dropDownWidth = searchBarWidth;
  static double dropDownHeight = expandedSliverBarHeight - dropDownTopInset;

  //menu bar
  static double menuBarHeight = 60;
  static double globeRadius = 90;

  //button
  static double buttonInset = 20;
  static double buttonHeight = 50;
  static double buttonWidth = 200;

  //sliver bar
  static double expandedSliverBarHeight = Screen.height / 7 * 4;
  static double collapsedSliverBarHeight = 100;
  static double maxDelegatedHeightForSliverBar = Screen.height / 7 * 5;
  static double buttonVisibilityReference = Screen.height / 7 * 2;

  //Popular Destinations
  static double popularDestCardWidth = Screen.width / 5 * 3;
  static double popularDestCardHeight = Screen.width / 5 * 2;

  //Popular Tours
  static double popularTourCardWidth = Screen.width - 20;
  static double popularTourCardHeight = Screen.width / 5 * 2;

  //Colors
  static Color sliverAppBarBackground = Colors.black38.withOpacity(0.8);
  static Color menuBarColor = Colors.white;
  static Color globeButtonColor = Colors.white;
  static Color homeButtonActive = Colors.blue;
  static Color homeButtonDeactive = Colors.grey;
  static Color profileButtonActive = Colors.blue;
  static Color profileButtonDeactive = Colors.grey;

  //Icons
  static IconData homeIcon = CupertinoIcons.house_fill;

  static IconData profileIcon = CupertinoIcons.person_fill;

  static Icon exploreIcon = Icon(
    CupertinoIcons.globe,
    color: Colors.black,
    size: 60,
  );
}

class ProfilePageConf {
  //image view
  static double imageViewHeight = 200;
  static double imageViewBottomPadding = 40;

  //name - email
  static double nameFieldTopInset = 50;
  static double nameFieldLeftInset = 40;
  static double nameFieldHeight = 100;
  static double nameFieldWidth = Screen.width - 80;
  static Color nameFieldColor = Colors.white.withOpacity(0.6);
  static double nameFieldIconSizeBefore = 60;
  static double nameFieldIconSizeAfter = 80;
  static IconData nameFieldIcon = CupertinoIcons.profile_circled;
  static double editButtonHeight = 40;
  static double editButtonWidth = 40;
  static Color editButtonBorderColor = Colors.black;
  static IconData editButtonIcon = Icons.edit;
  static IconData editCompleteButtonIcon = Icons.check_rounded;
  static Color editIconColor = Colors.black;

  //edit profile info
  static double editProfileHeight = nameFieldHeight * 3;
  static double editProfileWidth = nameFieldWidth;
  static double editProfileTopInset = nameFieldTopInset + nameFieldHeight;
  static double editProfileLeftInset = nameFieldLeftInset;
  static Color editProfileColor = Colors.white.withOpacity(0.6);
  static double editFieldsHeight = 38;
  static IconData nameIcon = CupertinoIcons.person_solid;
  static IconData emailIcon = CupertinoIcons.mail_solid;
  static IconData mobilePhoneIcon = Icons.phone_android;
  static Color editTextFieldsIconColorPassive = Colors.grey;
  static Color editTextFieldsIconColorActive = Colors.blue;

  //preferences Icons
  static IconData previousTrips = CupertinoIcons.airplane;
  static IconData favoritePlans = Icons.edit_road;
  static IconData paymentMethods = CupertinoIcons.creditcard_fill;
  static IconData billInfo = Icons.note;
  static IconData changePassword = CupertinoIcons.lock_fill;
  static IconData communicationPreferences = CupertinoIcons.bell_solid;
  static IconData help = CupertinoIcons.question_circle_fill;
  static IconData exit = Icons.exit_to_app_rounded;
  static Color preferencesIconColor = Colors.grey;
}

class ChangeLanguageConf {
  static Color appBarColor = Colors.orange;
  static IconData checkIcon = CupertinoIcons.checkmark_alt;
}

class LogInConf {
  static double buttonHeight = 50;
  static double buttonWidth = (textFieldWidth - 30) / 2;
  static double textFieldHeight = 45;
  static double textFieldWidth = Screen.width - 50;
  static IconData emailIcon = CupertinoIcons.mail_solid;
  static IconData mobilePhoneIcon = Icons.phone_android;
  static IconData passwordIcon = Icons.vpn_key_rounded;
  static Color buttonColor = Colors.blue;
}

class LanguageCodes {
  static Map<String, String> codes = {
    "tr": "Türkçe",
    "en": "English",
  };
}
