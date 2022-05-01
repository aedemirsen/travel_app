import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class Loading extends StatefulWidget {
  Widget route;
  Loading({this.route});
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  SpinKitSquareCircle spinkit;

  @override
  void initState() {
    super.initState();

    spinkit = SpinKitSquareCircle(
      color: Colors.black87,
      size: 50.0,
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      ),
    );

    Future.delayed(const Duration(seconds: 0), () async {
      //return widget.route;
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => widget.route));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/trip.gif',
        ),
      ),
    );
  }
}
