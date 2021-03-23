import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideDrawer extends StatelessWidget {
   Widget returnDrawerList() {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      FirebaseAuth.instance.currentUser.displayName,
                      style: GoogleFonts.actor(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser.photoURL,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    FirebaseAuth.instance.currentUser.email,
                    style: GoogleFonts.actor(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[900], Colors.purple[900]],
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Your Proflie',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            'Your Donations',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            'Settings',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: Drawer(
        child: returnDrawerList(),
      ),
    );
  }
}
