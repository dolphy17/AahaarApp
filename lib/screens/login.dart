import 'package:aahaar/screens/homeScreen.dart';
import 'package:aahaar/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = new GlobalKey<FormState>();
  final signInformkey = new GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController useremailController = new TextEditingController();
  TextEditingController userpasswordController = new TextEditingController();
  TextEditingController usermobileController = new TextEditingController();

  bool wantToSignIn = false;
  signupme() {
    if (formkey.currentState.validate()) {
      try {
        authMethods
            .signUpwithEmail(
                useremailController.text, userpasswordController.text)
            .then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen())));
      } on PlatformException catch (e) {
        print(e.toString());
      }
    }
  }

  signinme() {
    if (formkey.currentState.validate()) {
      try {
        authMethods
            .signInwithEmail(
                email: useremailController.text,
                password: userpasswordController.text)
            .then((value) => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen())));
      } catch (e) {
        print(e.toString());
      }
    }
  }

  resetPass() {
    if (useremailController.text != null) {
      try {
        authMethods.resetPassword(email: useremailController.text);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  googlesigninme() {
    try {
      authMethods.signInwithGoogle(context);
    } catch (e) {
      print(e.toString());
    }
  }

  Widget returnSignInForm() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              "Sign In",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 10),
                  child: TextFormField(
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)
                          ? null
                          : "Provide a valid email";
                    },
                    controller: useremailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.red),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 10),
                  child: TextFormField(
                    //obscureText: true,
                    validator: (val) {
                      return val.length > 6
                          ? null
                          : "Provide password more than Length 6";
                    },
                    controller: userpasswordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.red),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: signinme,
            child: Container(
              margin: EdgeInsets.only(bottom: 20, top: 10),
              width: MediaQuery.of(context).size.width / 1.7,
              height: MediaQuery.of(context).size.height / 15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue[900], Colors.purple[900]])),
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Sign In",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: resetPass,
              child: Container(
                child: Text("Forgot Password? Reset Pasword"),
              )),
          GestureDetector(
            onTap: googlesigninme,
            child: Container(
              child: Image.asset(
                "assets/images/googlesignin.png",
                scale: 1.2,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a Registered User? ",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    wantToSignIn = false;
                  });
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decorationStyle: TextDecorationStyle.solid,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget returnSignUpForm() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              "Sign Up",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 10),
                  child: TextFormField(
                    validator: (val) {
                      return val.isEmpty || val.length < 2
                          ? "Invalid Username"
                          : null;
                    },
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.red),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 10),
                  child: TextFormField(
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)
                          ? null
                          : "Provide a valid email";
                    },
                    controller: useremailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.red),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 10),
                  child: TextFormField(
                    //obscureText: true,
                    validator: (val) {
                      return val.length > 6
                          ? null
                          : "Provide password more than Length 6";
                    },
                    controller: userpasswordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.red),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 10),
                  child: TextFormField(
                    validator: (val) {
                      return val.length != 10 ? "Invalid" : null;
                    },
                    controller: usermobileController,
                    decoration: InputDecoration(
                      hintText: "Phone",
                      hintStyle: TextStyle(color: Colors.red),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: signupme,
            child: Container(
              margin: EdgeInsets.only(bottom: 20, top: 10),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue[900], Colors.purple[900]])),
              child: Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have an Account? ",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      wantToSignIn = true;
                    });
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decorationStyle: TextDecorationStyle.solid,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[900], Colors.purple[900]],
            ),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 1.5),
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  child: wantToSignIn ? returnSignInForm() : returnSignUpForm(),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 6,
                  left: MediaQuery.of(context).size.width / 2 - 130,
                  child: Image.asset("assets/images/logo4.png",
                      height: MediaQuery.of(context).size.height / 9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
