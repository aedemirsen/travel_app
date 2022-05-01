import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_builder/language_builder.dart';
import 'package:travel_app/configuration/config.dart';
import 'package:travel_app/configuration/session.dart';
import 'package:travel_app/operation/page_router.dart';
import 'package:travel_app/pages/main_page/home.dart';
import 'package:travel_app/pages/profile/change_language.dart';
import 'package:travel_app/test.dart';

class Profile extends StatefulWidget {
  static const ROUTE_NAME = "/profile";
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _profileIconRelocation;
  double _nameFieldIconSize;
  double _nameFieldIconTopInset;
  bool _editOpen, _textFieldVisibility, _editOpenComplete;
  int _editButtonIndex;
  int _textFieldsAnimationDuration;

  //all texts using in this class
  Map<String, dynamic> _texts;

  //Text field controllers
  TextEditingController _textControllerName,
      _textControllerEmail,
      _textControllerPhone;
  //Focus nodes for text fields
  FocusNode _nameFocus;
  // FocusNode _emailFocus;
  // FocusNode _phoneFocus;
  //edit icons colors
  Color _nameIconColor, _emailIconColor, _phoneIconColor;

  bool _onEndControl;

  Map<IconData, String> _preferenceMap;

  AnimationController controller;
  Animation<Offset> offset;

  bool _sign_in;
  //check if user has opened account
  _account(bool open) {
    setState(() {
      _sign_in = open;
      if (open) {
      } else {}
    });
  }

  @override
  void initState() {
    _texts = LanguageBuilder.texts['profile_page'];

    _profileIconRelocation = false;
    _nameFieldIconSize = ProfilePageConf.nameFieldIconSizeBefore;
    _nameFieldIconTopInset = (ProfilePageConf.nameFieldHeight -
            ProfilePageConf.nameFieldIconSizeBefore) /
        2;
    _editOpen = true;
    _textFieldVisibility = true;
    _editOpenComplete = false;
    _editButtonIndex = 0;
    _textFieldsAnimationDuration = 300;

    _onEndControl = true;

    //text field controllers initialization
    _textControllerName = TextEditingController(text: TEST.userName);
    _textControllerEmail = TextEditingController(text: TEST.email);
    _textControllerPhone = TextEditingController(text: TEST.phoneNumber);

    //focus
    _nameFocus = FocusNode();
    // _emailFocus = FocusNode();
    // _phoneFocus = FocusNode();

    //edit icons colors
    _nameIconColor = ProfilePageConf.editTextFieldsIconColorActive;
    _emailIconColor = ProfilePageConf.editTextFieldsIconColorPassive;
    _phoneIconColor = ProfilePageConf.editTextFieldsIconColorPassive;

    //preference map
    _preferenceMap = {
      //0
      ProfilePageConf.previousTrips: _texts['previousTrips'],
      //1
      ProfilePageConf.favoritePlans: _texts['favoritePlans'],
      //2
      ProfilePageConf.paymentMethods: _texts['paymentMethods'],
      //3
      ProfilePageConf.billInfo: _texts['billInfo'],
      //4
      ProfilePageConf.changePassword: _texts['changePassword'],
      //5
      ProfilePageConf.communicationPreferences: _texts['communicationPref'],
      //6
      ProfilePageConf.help: _texts['help'],
      //7
      ProfilePageConf.exit: _texts['exit'],
    };

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //top image view
          Container(
            color: Colors.blueGrey.withOpacity(0.9),
            height: ProfilePageConf.imageViewHeight,
            width: Screen.width,
            // child: Opacity(
            //   opacity: 0.6,
            //   child: Image.asset(
            //     TEST.vacation.first,
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
          //Preferences
          Padding(
            padding: EdgeInsets.only(
              top: ProfilePageConf.imageViewHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: ProfilePageConf.imageViewBottomPadding,
                    color: Colors.grey[200],
                  ),
                  _preferences(),
                  Container(
                    height: ProfilePageConf.imageViewBottomPadding,
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _texts["language"],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                            fontFamily: AppTheme.fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _languageSetting(),
                  Container(
                    height: ProfilePageConf.imageViewBottomPadding,
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _texts["version"],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                            fontFamily: AppTheme.fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _versionInfo(),
                  Container(
                    height: ProfilePageConf.imageViewBottomPadding,
                    color: Colors.grey[200],
                  ),
                ],
              ),
            ),
          ),
          //background opacity after edit section is opened
          Visibility(
            visible: !_editOpen,
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          //profile info
          Positioned(
            top: ProfilePageConf.nameFieldTopInset,
            left: ProfilePageConf.nameFieldLeftInset,
            child: _profileInfo(),
          ),
          //edit profile
          Visibility(
            visible: !_editOpen,
            child: Positioned(
              top: ProfilePageConf.nameFieldTopInset +
                  ProfilePageConf.nameFieldHeight,
              left: ProfilePageConf.nameFieldLeftInset,
              child: AnimatedOpacity(
                opacity: _editOpenComplete ? 1 : 0,
                duration: Duration(milliseconds: _textFieldsAnimationDuration),
                child: _editProfileInfo(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _preferences() {
    return Flex(
      direction: Axis.vertical,
      children: _preferenceMap.entries.map((e) {
        return Column(
          children: [
            SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () {
                  //if exit
                  if (e.value == _preferenceMap.entries.elementAt(7).value) {
                    Session.user = null;
                    //Navigate to parent
                    PageRouter.changePageWithoutAnimation(context, MainPage(),
                        data: 1);
                  }
                },
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        e.key,
                        color: ProfilePageConf.preferencesIconColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        e.value,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: AppTheme.fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Builder(builder: (context) {
              if (_preferenceMap.entries.last.key != e.key) {
                return Divider(
                  height: 0,
                );
              }
              return SizedBox.shrink();
            }),
          ],
        );
      }).toList(),
    );
  }

  Widget _languageSetting() {
    return SizedBox(
      height: 50,
      child: TextButton(
        onPressed: () {
          PageRouter.changePageWithAnimation(
              context, ChangeLanguage(), PageRouter.downToUp);
        },
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                LanguageCodes.codes[LanguageBuilder.getCurrentLang()],
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: AppTheme.fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _versionInfo() {
    return SizedBox(
      height: 50,
      child: TextButton(
        onPressed: () {},
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                Session.version,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: AppTheme.fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileInfo() {
    return AnimatedContainer(
      onEnd: () {
        setState(() {
          if (_onEndControl) {
            _textFieldsAnimationDuration = 300;
            _editOpenComplete = !_editOpenComplete;
          }
        });
        _onEndControl = true;
      },
      height: _editOpen
          ? ProfilePageConf.nameFieldHeight
          : ProfilePageConf.editProfileHeight,
      width: ProfilePageConf.nameFieldWidth,
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _editOpen
            ? Colors.white.withOpacity(0.6)
            : Colors.white.withOpacity(0.9),
      ),
      child: Stack(
        children: [
          //name - email
          Positioned(
            top: 30,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _textFieldVisibility ? 1 : 0,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 15.0,
                  left: 20 + ProfilePageConf.nameFieldIconSizeBefore,
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "null",
                          //Session.session.user.fullName,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppTheme.fontFamily,
                          ),
                        ),
                        Text(
                          "null",
                          //Session.session.user.email,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppTheme.fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Profile Icon
          AnimatedPositioned(
            height: ProfilePageConf.nameFieldIconSizeAfter,
            width: ProfilePageConf.nameFieldIconSizeAfter,
            top: _nameFieldIconTopInset / 2,
            left: _profileIconRelocation
                ? (ProfilePageConf.nameFieldWidth / 2 -
                    ProfilePageConf.nameFieldIconSizeAfter / 2)
                : 0,
            duration: Duration(milliseconds: 500),
            child: Icon(
              ProfilePageConf.nameFieldIcon,
              color: Colors.black,
              size: _nameFieldIconSize,
            ),
          ),
          //Edit-EditComplete buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0, right: 8.0),
            child: IndexedStack(
              index: _editButtonIndex,
              children: [
                //edit button
                AnimatedOpacity(
                  opacity: _editOpen ? 1 : 0,
                  duration: Duration(milliseconds: 250),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: ProfilePageConf.editButtonWidth,
                      height: ProfilePageConf.editButtonHeight,
                      child: IconButton(
                        splashRadius: 25,
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          ProfilePageConf.editButtonIcon,
                          color: ProfilePageConf.editIconColor,
                          size: 25,
                        ),
                        onPressed: () {
                          setState(() {
                            _textFieldVisibility = false;
                            _editOpen = !_editOpen;
                            _editButtonIndex = 1;
                            if (_profileIconRelocation) {
                              _profileIconRelocation = false;
                              _nameFieldIconSize =
                                  ProfilePageConf.nameFieldIconSizeBefore;
                            } else {
                              _profileIconRelocation = true;
                              _nameFieldIconSize =
                                  ProfilePageConf.nameFieldIconSizeAfter;
                            }
                            //name textfield set focused
                            _nameFocus.requestFocus();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                //edit complete button
                AnimatedOpacity(
                  opacity: _editOpen ? 0 : 1,
                  duration: Duration(milliseconds: 250),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: ProfilePageConf.editButtonWidth,
                      height: ProfilePageConf.editButtonHeight,
                      child: IconButton(
                        splashRadius: 25,
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          ProfilePageConf.editCompleteButtonIcon,
                          color: ProfilePageConf.editIconColor,
                          size: 25,
                        ),
                        onPressed: () {
                          setState(() {
                            _onEndControl = false;
                            _editOpenComplete = false;
                            _textFieldsAnimationDuration = 10;
                            _textFieldVisibility = true;
                            _editButtonIndex = 0;
                            _editOpen = !_editOpen;
                            if (_profileIconRelocation) {
                              _profileIconRelocation = false;
                              _nameFieldIconSize =
                                  ProfilePageConf.nameFieldIconSizeBefore;
                            } else {
                              _profileIconRelocation = true;
                              _nameFieldIconSize =
                                  ProfilePageConf.nameFieldIconSizeAfter;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _editProfileInfo() {
    return Container(
      height: ProfilePageConf.editProfileHeight -
          ProfilePageConf.nameFieldHeight -
          ProfilePageConf.editButtonHeight,
      width: ProfilePageConf.editProfileWidth,
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: SizedBox(
              height: ProfilePageConf.editFieldsHeight,
              child: CupertinoTextField(
                onTap: () {
                  setState(() {
                    _nameIconColor =
                        ProfilePageConf.editTextFieldsIconColorActive;
                    _emailIconColor =
                        ProfilePageConf.editTextFieldsIconColorPassive;
                    _phoneIconColor =
                        ProfilePageConf.editTextFieldsIconColorPassive;
                  });
                },
                keyboardType: TextInputType.name,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                ),
                controller: _textControllerName,
                focusNode: _nameFocus,
                prefix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    ProfilePageConf.nameIcon,
                    color: _nameIconColor,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: SizedBox(
              height: ProfilePageConf.editFieldsHeight,
              child: CupertinoTextField(
                onTap: () {
                  setState(() {
                    _nameIconColor =
                        ProfilePageConf.editTextFieldsIconColorPassive;
                    _emailIconColor =
                        ProfilePageConf.editTextFieldsIconColorActive;
                    _phoneIconColor =
                        ProfilePageConf.editTextFieldsIconColorPassive;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                ),
                controller: _textControllerEmail,
                //focusNode: _emailFocus,
                prefix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    ProfilePageConf.emailIcon,
                    color: _emailIconColor,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: SizedBox(
              height: ProfilePageConf.editFieldsHeight,
              child: CupertinoTextField(
                onTap: () {
                  setState(() {
                    _nameIconColor =
                        ProfilePageConf.editTextFieldsIconColorPassive;
                    _emailIconColor =
                        ProfilePageConf.editTextFieldsIconColorPassive;
                    _phoneIconColor =
                        ProfilePageConf.editTextFieldsIconColorActive;
                  });
                },
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                ),
                controller: _textControllerPhone,
                //focusNode: _phoneFocus,
                prefix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    ProfilePageConf.mobilePhoneIcon,
                    color: _phoneIconColor,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
