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
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Preferences", Icons.tune),
                  const SizedBox(height: 10),
                  _buildDarkModeTile(),
                  const SizedBox(height: 12),
                  _buildLanguageTile(),
                  const SizedBox(height: 30),
                  _buildSectionTitle("App Info", Icons.info),
                  const SizedBox(height: 10),
                  _buildAboutTile(),
                  const SizedBox(height: 12),
                  _buildCloseTile(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// العنوان في المنتصف بالضبط
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.settings, color: Colors.green.shade700, size: 26),
                  const SizedBox(width: 8),
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            ),

            /// زر الرجوع على اليسار
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.green.shade200, Colors.green.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back,
                      color: Colors.green, size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade600, size: 22),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor ?? Colors.green.shade600),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade800,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDarkModeTile() {
    return _buildTile(
      icon: isDarkMode ? Icons.nights_stay_rounded : Icons.wb_sunny_rounded,
      title: "Dark Mode",
      iconColor:
          isDarkMode ? Colors.deepPurple.shade400 : Colors.orange.shade400,
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 55,
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [Colors.deepPurple.shade400, Colors.black87]
                  : [Colors.yellow.shade600, Colors.orange.shade400],
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.deepPurple.withOpacity(0.3)
                    : Colors.orange.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment:
                isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                  )
                ],
              ),
              child: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                size: 14,
                color: isDarkMode
                    ? Colors.deepPurple.shade700
                    : Colors.orange.shade600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageTile() {
    return _buildTile(
      icon: Icons.translate,
      title: "Language",
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedLanguage,
            borderRadius: BorderRadius.circular(16),
            icon: Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.green.shade600),
            style: TextStyle(
              fontSize: 14,
              color: Colors.green.shade800,
              fontWeight: FontWeight.w500,
            ),
            dropdownColor: Colors.white,
            items: ['English', 'Arabic'].map((String language) {
              return DropdownMenuItem<String>(
                value: language,
                child: Row(
                  children: [
                    Icon(
                      language == 'English'
                          ? Icons.language
                          : Icons.translate_rounded,
                      color: Colors.green.shade400,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(language),
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedLanguage = newValue;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAboutTile() {
    return _buildTile(
      icon: Icons.help_outline,
      title: "About App",
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Header مع أيقونة
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green.shade100, Colors.green.shade50],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.eco, size: 40, color: Colors.green),
                    ),
                    const SizedBox(height: 16),

                    /// اسم التطبيق والإصدار
                    Text(
                      "EcoSense",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Version 1.0.0",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const Divider(height: 32),

                    /// وصف التطبيق
                    Text(
                      "EcoSense is an environmental monitoring app designed to help you track real-time air quality and environmental data in your city.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade800,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// إشعار التطوير
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.favorite,
                            size: 16, color: Colors.green),
                        const SizedBox(width: 6),
                        Text(
                          "Developed with Flutter",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.green.shade700,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    /// زر الإغلاق
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade400,
                                Colors.green.shade600
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Icon(Icons.close, size: 20, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                "Close",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCloseTile() {
    return _buildTile(
      icon: Icons.exit_to_app,
      title: "Close Settings",
      iconColor: Colors.red.shade400,
      onTap: () => Navigator.pop(context),
    );
  }
}
