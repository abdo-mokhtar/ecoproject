import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart'
    show SettingsList, SettingsSection, SettingsTile;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool isArabic = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: SettingsList(
        sections: [
          SettingsSection(
            title: Text("Preferences"),
            tiles: [
              SettingsTile.switchTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text("Dark Mode"),
                initialValue: isDarkMode,
                onToggle: (bool value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              SettingsTile.switchTile(
                leading: const Icon(Icons.language),
                title: const Text("Arabic Language"),
                initialValue: isArabic,
                onToggle: (bool value) {
                  setState(() {
                    isArabic = value;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            tiles: [
              SettingsTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("About App"),
                onPressed: (context) {
                  showAboutDialog(
                    context: context,
                    applicationName: "EcoSense",
                    applicationVersion: "1.0.0",
                    applicationIcon: Icon(Icons.eco, size: 40),
                    children: [
                      const Text(
                          "An app to track air quality and environmental data."),
                    ],
                  );
                },
              ),
              SettingsTile(
                leading: const Icon(Icons.close),
                title: const Text("Close Settings"),
                onPressed: (context) {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
