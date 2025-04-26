import 'package:ecosensetest/screens/about_page.dart' show AboutPage;
import 'package:ecosensetest/screens/meet_our_team.dart' show MeetOurTeamPage;
import 'package:flutter/material.dart';

class PopupMenuButtonMenu extends StatelessWidget {
  const PopupMenuButtonMenu({super.key});

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
          _buildAnimatedMenuItem('login', Icons.login, "LogIn", Colors.black),
          const PopupMenuDivider(),
          _buildAnimatedMenuItem(
              'signin', Icons.person_add, "SignIn", Colors.black),
          const PopupMenuDivider(),
          _buildAnimatedMenuItem(
              'team', Icons.group, "Meet Our Team", Colors.black),
          const PopupMenuDivider(),
          _buildAnimatedMenuItem('about', Icons.info, "About", Colors.black),
          const PopupMenuDivider(),
          _buildAnimatedMenuItem(
              'signout', Icons.logout, "SignOut", Colors.red),
        ];
      },
    );
  }

  PopupMenuItem<String> _buildAnimatedMenuItem(
      String value, IconData icon, String text, Color iconColor) {
    return PopupMenuItem<String>(
      value: value,
      child: AnimatedOpacity(
        opacity: 1.0, // Always visible
        duration: const Duration(milliseconds: 300),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}
