import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  String selectedLanguage = 'English'; // اللغة الافتراضية هي الإنجليزية

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            bottomLeft: const Radius.circular(24),
            bottomRight: const Radius.circular(24),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("Preferences"),
          _buildDarkModeTile(),
          _buildLanguageTile(), // إضافة اختيار اللغة
          const SizedBox(height: 24),
          _buildSectionTitle("App Info"),
          _buildTile(
            icon: Icons.info_outline,
            title: "About App",
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "EcoSense",
                applicationVersion: "1.0.0",
                applicationIcon: const Icon(Icons.eco, size: 40),
                children: const [
                  Text("An app to track air quality and environmental data."),
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
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.green.shade700, // اللون الأخضر للنصوص
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: ListTile(
        leading: Icon(icon, color: Colors.green), // اللون الأخضر للأيقونات
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.green.shade800, // اللون الأخضر للنصوص
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  // تحسين شكل زر Dark Mode
  Widget _buildDarkModeTile() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: ListTile(
        leading: const Icon(Icons.dark_mode,
            color: Colors.green), // أيقونة Dark Mode
        title: Text(
          "Dark Mode",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.green.shade800, // النص بلون أخضر
          ),
        ),
        trailing: Transform.scale(
          scale: 1.2, // زيادة حجم الـ Switch قليلاً
          child: Switch(
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
                // يمكنك إضافة كود لتغيير الثيم هنا
              });
            },
            activeColor: Colors.green, // اللون الأخضر عند تفعيل الـ Switch
            activeTrackColor: Colors.green.shade200, // اللون الأخضر الفاتح
            inactiveThumbColor: Colors.grey, // اللون الرمادي عند إيقاف التفعيل
            inactiveTrackColor: Colors.grey.shade400, // اللون الرمادي الفاتح
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageTile() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      child: ListTile(
        leading: const Icon(Icons.language,
            color: Colors.green), // اللون الأخضر للأيقونة
        title: Text(
          "Language",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.green.shade800, // اللون الأخضر للنصوص
          ),
        ),
        trailing: Container(
          width: 130, // تم تقليص العرض
          padding: const EdgeInsets.symmetric(horizontal: 6), // تقليص الحواف
          decoration: BoxDecoration(
            color: Colors.green.shade50, // خلفية القائمة المنسدلة
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: Colors.green.shade300), // حدود بلون أخضر فاتح
            boxShadow: [
              BoxShadow(
                color: Colors.green.shade100,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButton<String>(
            value: selectedLanguage,
            iconEnabledColor: Colors.green, // اللون الأخضر لأيقونة السهم
            iconSize: 20, // حجم السهم المنسدلي أصغر
            isExpanded: true, // ملء العرض بالكامل
            dropdownColor: Colors.green.shade50, // خلفية القائمة المنسدلة
            style: TextStyle(
              fontSize: 14, // تقليص حجم النص
              color: Colors.green.shade800, // النص داخل القائمة
            ),
            underline: Container(), // إزالة الخط السفلي
            items: <String>['English', 'Arabic']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(value),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedLanguage = newValue!;
                // هنا يمكنك إضافة كود لتغيير اللغة
              });
            },
          ),
        ),
      ),
    );
  }
}
