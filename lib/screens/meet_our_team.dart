import 'package:flutter/material.dart';

class MeetOurTeamPage extends StatefulWidget {
  @override
  _MeetOurTeamPageState createState() => _MeetOurTeamPageState();
}

class _MeetOurTeamPageState extends State<MeetOurTeamPage> {
  final List<TeamMember> teamMembers = [
    TeamMember(
        name: "Abdelrahman Temraz",
        role: "Team Leader & AI Specialist",
        imagePath: "assets/images/Temraz.PNG"),
    TeamMember(
        name: "Abdelrahman Mokhtar",
        role: "Flutter Developer",
        imagePath: "assets/images/Mokhtar.jpg"),
    TeamMember(
        name: "Kholoud Ahmed",
        role: "Kotlin Developer",
        imagePath: "assets/images/Kholoud.jpg"),
    TeamMember(
        name: "Mariam Khamees",
        role: "Back-End Developer",
        imagePath: "assets/images/Mariam.jpg"),
    TeamMember(
        name: "Hamdy Sayed",
        role: "Frontend Developer",
        imagePath: "assets/images/Hamdy.jpg"),
    TeamMember(
        name: "Abdallah Salah",
        role: "Hardware Specialist",
        imagePath: "assets/images/Abdullah.jpg"),
  ];

  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Make content visible after a short delay for the animation effect
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const Text(
          "Meet Our Team",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: teamMembers.length,
            itemBuilder: (context, index) {
              final member = teamMembers[index];
              return AnimatedScale(
                scale: _isVisible ? 1.0 : 0.8,
                duration: const Duration(milliseconds: 800),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: member.imagePath.isNotEmpty
                          ? AssetImage(member.imagePath)
                          : null,
                      child: member.imagePath.isEmpty
                          ? const Icon(Icons.person,
                              size: 40, color: Colors.grey)
                          : null,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    title: Text(
                      member.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(member.role),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class TeamMember {
  final String name;
  final String role;
  final String imagePath;

  TeamMember({required this.name, required this.role, this.imagePath = ""});
}
