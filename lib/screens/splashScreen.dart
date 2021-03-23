import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromRGBO(197, 202, 233, 0.5),
            Color.fromRGBO(63, 81, 181, 1),
            Color.fromRGBO(26, 35, 126, 1),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              /* borderRadius: BorderRadius.only(
                topLeft: Radius.circular(400),
                bottomRight: Radius.circular(400),
              ),*/
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.purple,
                    Colors.blueAccent,
                    Color(0xfdfbfb),
                  ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/logo3.png",
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "चलो भोजन बचाएँ",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Kalam',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
