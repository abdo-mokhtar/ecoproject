import 'package:flutter/material.dart';

class MeetOurTeamPage extends StatelessWidget {
  final List<TeamMember> teamMembers = [
    TeamMember(
        name: "Abdelrahman Temraz", role: "TL & AI Specialist", imagePath: ""),
    TeamMember(
        name: "Abdelrahman Mokhtar",
        role: "UI/UX Designer & Flutter Developer",
        imagePath: ""),
    TeamMember(name: "Kholoud Ahmed", role: "Kotlin Developer", imagePath: ""),
    TeamMember(
        name: "Abdelrahman Temraz", role: "TL & AI Specialist", imagePath: ""),
    TeamMember(
        name: "Abdelrahman Mokhtar",
        role: "UI/UX Designer & Flutter Developer",
        imagePath: ""),
    TeamMember(name: "Kholoud Ahmed", role: "Kotlin Developer", imagePath: ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meet Our Team",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: teamMembers.length,
          itemBuilder: (context, index) {
            final member = teamMembers[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: member.imagePath.isNotEmpty
                      ? AssetImage(member.imagePath)
                      : null,
                  child: member.imagePath.isEmpty
                      ? const Icon(Icons.person, size: 40, color: Colors.grey)
                      : null,
                  backgroundColor: Colors.grey.shade300,
                ),
                title: Text(
                  member.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(member.role),
              ),
            );
          },
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
