import 'package:aahaar/services/auth.dart';
import 'package:aahaar/subScreens/sideDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  AuthMethods authMethods = new AuthMethods();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime.shade50,
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "Home",
          style: GoogleFonts.actor(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[900], Colors.purple[900]],
            ),
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldkey.currentState.openDrawer();
            }),
      ),
      drawer: SideDrawer(),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 30, top: 10),
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width - 30,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/images/food1.png",
                      height: 100,
                      width: 100,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Donate Food", 
                          style: GoogleFonts.acme(
                            textStyle: TextStyle(
                              fontSize: MediaQuery.of(context).size.width/10,
                              color: Colors.black,
                              decoration: TextDecoration.underline
                        )),
                        ),
                        Text("Tap here to Donate Food..", style: GoogleFonts.acme(
                          textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width/20 
                            )
                        ),)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
