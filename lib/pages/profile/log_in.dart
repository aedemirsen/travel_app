import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:language_builder/language_builder.dart';
import 'package:travel_app/configuration/config.dart';
import 'package:travel_app/configuration/session.dart';
import 'package:travel_app/model/user.dart';
import 'package:travel_app/operation/page_router.dart';
import 'package:travel_app/pages/main_page/home.dart';
import 'package:travel_app/pages/profile/country_codes.dart';

class LogIn extends StatefulWidget {
  static const ROUTE_NAME = "/sign_in";

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  //all texts using in this class
  Map<String, dynamic> _texts;
  bool _logInOption; //if true -- email , false -- phone

  TextEditingController _textControllerEmail,
      _textControllerPhone,
      _textControllerPassword;

  FocusNode _emailFocus, _phoneFocus;

  Color _emailIconColor, _passwordIconColor;

  @override
  void initState() {
    _texts = LanguageBuilder.texts['log_in'];
    _logInOption = true; //default is email
    //text field controllers initialization
    _textControllerEmail = TextEditingController();
    _textControllerPhone = TextEditingController();
    _textControllerPassword = TextEditingController();
    //focus Nodes
    _emailFocus = FocusNode();
    _phoneFocus = FocusNode();

    _emailIconColor = ProfilePageConf.editTextFieldsIconColorPassive;
    _passwordIconColor = ProfilePageConf.editTextFieldsIconColorPassive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 50, 0, 0),
                  child: Text(
                    _texts['log_in'],
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ),
            _buttons(),
            Padding(
              padding: const EdgeInsets.only(top: 30),
            ),
            _fields(_logInOption),
            Padding(
              padding: const EdgeInsets.only(top: 30),
            ),
            _logInButton(),
            _forgotPassword(),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _signUp(),
            ),
            //_signInTabBar(),
          ],
        ),
      ),
    );
  }

  _buttons() {
    return Row(
      children: [
        Padding(padding: EdgeInsets.only(left: 25)),
        GestureDetector(
          onTap: () {
            setState(() {
              _logInOption = true;
              //_emailFocus.requestFocus();
            });
          },
          child: Container(
            height: LogInConf.buttonHeight,
            width: LogInConf.buttonWidth,
            child: Center(child: Text(_texts['log_in_email'])),
            decoration: BoxDecoration(
              color: _logInOption ? Colors.blue : Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                width: 1.5,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(left: 25)),
        GestureDetector(
          onTap: () {
            setState(() {
              _logInOption = false;
              _emailIconColor = ProfilePageConf.editTextFieldsIconColorPassive;
              //_phoneFocus.requestFocus();
            });
          },
          child: Container(
            height: LogInConf.buttonHeight,
            width: LogInConf.buttonWidth,
            child: Center(child: Text(_texts['log_in_phone'])),
            decoration: BoxDecoration(
              color: !_logInOption ? Colors.blue[400] : Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                width: 1.5,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(right: 25)),
      ],
    );
  }

  _fields(logInOption) {
    return Column(
      children: [
        Builder(builder: (context) {
          if (_logInOption) {
            return Container(
              height: LogInConf.textFieldHeight,
              width: LogInConf.textFieldWidth,
              child: CupertinoTextField(
                focusNode: _emailFocus,
                placeholder: _texts['log_in_email'],
                onTap: () {
                  setState(() {
                    _emailIconColor =
                        ProfilePageConf.editTextFieldsIconColorActive;
                    _passwordIconColor =
                        ProfilePageConf.editTextFieldsIconColorPassive;
                  });
                },
                onSubmitted: (text) {
                  setState(() {
                    _emailIconColor =
                        ProfilePageConf.editTextFieldsIconColorPassive;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                ),
                prefix: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
                  child: Icon(
                    LogInConf.emailIcon,
                    color: _emailIconColor,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          } else {
            return Container(
              height: LogInConf.textFieldHeight,
              width: LogInConf.textFieldWidth,
              child: Row(
                children: [
                  //open country codes
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  CountryCodes(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = PageRouter.downToUp;
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(
                              begin: begin,
                              end: end,
                            ).chain(
                              CurveTween(curve: curve),
                            );
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                      setState(() {
                        if (result != null) Session.selectedCountry = result;
                      });
                    },
                    child: Container(
                      width: 100,
                      height: LogInConf.textFieldHeight,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 10)),
                          SvgPicture.asset(
                            Session.selectedCountry != null
                                ? Session.selectedCountry.icon
                                : Session.countries.first.icon,
                            height: 25,
                            width: 25,
                          ),
                          Padding(padding: EdgeInsets.only(left: 8)),
                          Text(
                            '(+' +
                                (Session.selectedCountry != null
                                    ? Session.selectedCountry.phone.toString()
                                    : Session.countries.first.phone
                                        .toString()) +
                                ')',
                            style: TextStyle(fontFamily: AppTheme.fontFamily),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 15)),
                  Flexible(
                    child: SizedBox(
                      height: LogInConf.textFieldHeight,
                      child: CupertinoTextField(
                        focusNode: _phoneFocus,
                        placeholder: _texts['log_in_phone'],
                        onTap: () {
                          setState(() {
                            _passwordIconColor =
                                ProfilePageConf.editTextFieldsIconColorPassive;
                          });
                        },
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                        ),
                        prefix: Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        Container(
          height: LogInConf.textFieldHeight,
          width: LogInConf.textFieldWidth,
          child: CupertinoTextField(
            placeholder: _texts['password'],
            obscureText: true,
            onTap: () {
              setState(() {
                _emailIconColor =
                    ProfilePageConf.editTextFieldsIconColorPassive;
                _passwordIconColor =
                    ProfilePageConf.editTextFieldsIconColorActive;
              });
            },
            onSubmitted: (text) {
              setState(() {
                _passwordIconColor =
                    ProfilePageConf.editTextFieldsIconColorPassive;
              });
            },
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
            ),
            prefix: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
              child: Icon(
                LogInConf.passwordIcon,
                color: _passwordIconColor,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  _forgotPassword() {
    return CupertinoButton(
      onPressed: () {},
      child: Text(
        _texts['reset_password'],
        style: TextStyle(
          color: LogInConf.buttonColor,
          fontSize: 14,
          fontFamily: AppTheme.fontFamily,
        ),
      ),
      color: Colors.transparent,
    );
  }

  _logInButton() {
    return Container(
      height: LogInConf.textFieldHeight,
      width: LogInConf.textFieldWidth,
      child: CupertinoButton(
        onPressed: () {
          Session.user = User();
          //Authentication

          //Navigate to parent
          PageRouter.changePageWithoutAnimation(context, MainPage(), data: 1);
        },
        child: Text(
          _texts['log_in'],
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 16,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        color: LogInConf.buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  _signUp() {
    return CupertinoButton(
      onPressed: () {},
      child: Container(
        height: LogInConf.textFieldHeight,
        width: LogInConf.textFieldWidth,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1.5,
            color: LogInConf.buttonColor,
          ),
        ),
        child: Center(
          child: Text(
            _texts['sign_up'],
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 16,
              color: LogInConf.buttonColor,
            ),
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
