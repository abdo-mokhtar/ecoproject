import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoosePlanScreen extends StatelessWidget {
  const ChoosePlanScreen({super.key});

  Future<void> _saveUserTypeAndNavigate(
      BuildContext context, String userType, String route) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', userType.toLowerCase());
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 👋 Welcome Header (Centered and Modern)
                const Center(
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Welcome to',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '🌿 EcoSense',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F7E6A),
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Your smart guide to a greener tomorrow.\nChoose a plan to get started.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),

                /// User Plan
                buildPlanCard(
                  context,
                  title: 'User',
                  icon: Icons.person,
                  color: const Color(0xFFD4F4E3),
                  features: [
                    'Air Quality Updates',
                    'Pollution Notifications',
                    'Eco Friendly Tips',
                    'Interactive Maps',
                  ],
                  onTap: () => _saveUserTypeAndNavigate(
                      context, 'user', '/user-onboarding'),
                ),
                const SizedBox(height: 24),

                /// Business Plan
                buildPlanCard(
                  context,
                  title: 'Business',
                  icon: Icons.business,
                  color: const Color(0xFFD4F4E3),
                  features: [
                    'Sustainable Practices',
                    'Sustainability Tools',
                    'Environmental Insights',
                    'Emission Reduction',
                  ],
                  onTap: () => _saveUserTypeAndNavigate(
                      context, 'business', '/business-onboarding'),
                ),
                const SizedBox(height: 24),

                /// Government Plan
                buildPlanCard(
                  context,
                  title: 'Government',
                  icon: Icons.account_balance,
                  color: const Color(0xFFD4F4E3),
                  features: [
                    'Comprehensive Analytics',
                    'AI-driven Pollution ID',
                    'Policy Suggestions',
                    'Monitoring Tools',
                  ],
                  onTap: () => _saveUserTypeAndNavigate(
                      context, 'government', '/government-onboarding'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPlanCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required List<String> features,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 24,
                child: Icon(icon, size: 28, color: const Color(0xFF2F7E6A)),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2F7E6A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: Color(0xFF4CAF50), size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.white),
              label: const Text('Start', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F7E6A),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
