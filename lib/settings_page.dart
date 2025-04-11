import 'package:flutter/material.dart';
import 'package:ecosensetest/home_screen.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 140, 20, 20),
              children: [
                _buildSectionTitle("Preferences"),
                _buildDarkModeTile(),
                _buildLanguageTile(),
                const SizedBox(height: 30),
                _buildSectionTitle("App Info"),
                _buildTile(
                  icon: Icons.info_outline,
                  title: "About App",
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: "EcoSense",
                      applicationVersion: "v1.0.0",
                      applicationIcon: Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.eco,
                            size: 40, color: Colors.green),
                      ),
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          "EcoSense is an environmental monitoring app designed to help you track real-time air quality and environmental data in your city.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Developed with 💚 using Flutter.",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.green.shade700,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                _buildTile(
                  icon: Icons.close,
                  title: "Close Settings",
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          _buildAppBar(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.green, size: 30),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          const Spacer(),
          const Icon(Icons.settings, color: Colors.green),
          const SizedBox(width: 8),
          const Text(
            "Settings",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green.shade800,
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.green.shade800,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  Widget _buildDarkModeTile() {
    return _buildTile(
      icon: Icons.dark_mode,
      title: "Dark Mode",
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
        activeColor: Colors.green,
      ),
    );
  }

  Widget _buildLanguageTile() {
    return _buildTile(
      icon: Icons.language,
      title: "Language",
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.shade300),
        ),
        child: DropdownButton<String>(
          value: selectedLanguage,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.green),
          underline: const SizedBox(),
          items: ['English', 'Arabic'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child:
                  Text(value, style: TextStyle(color: Colors.green.shade800)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedLanguage = newValue!;
            });
          },
        ),
      ),
    );
  }
}
