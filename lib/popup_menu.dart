import 'package:ecosensetest/about_page.dart';
import 'package:ecosensetest/meet_our_team.dart';
import 'package:flutter/material.dart';

class PopupMenuButtonMenu extends StatelessWidget {
  const PopupMenuButtonMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: Colors.black),
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      onSelected: (String value) {
        if (value == 'login') {
          print("Login Selected");
        } else if (value == 'signin') {
          print("Signin Selected");
        } else if (value == 'team') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MeetOurTeamPage()),
          );
        } else if (value == 'about') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutPage()),
          );
        } else if (value == 'signout') {
          print("SignOut Selected");
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'login',
            child: Row(
              children: const [
                Icon(Icons.login, color: Colors.black),
                SizedBox(width: 10),
                Text("LogIn"),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'signin',
            child: Row(
              children: const [
                Icon(Icons.person_add, color: Colors.black),
                SizedBox(width: 10),
                Text("SignIn"),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'team',
            child: Row(
              children: const [
                Icon(Icons.group, color: Colors.black),
                SizedBox(width: 10),
                Text("Meet Our Team"),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'about',
            child: Row(
              children: const [
                Icon(Icons.info, color: Colors.black),
                SizedBox(width: 10),
                Text("About"),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'signout',
            child: Row(
              children: const [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 10),
                Text(
                  "SignOut",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
