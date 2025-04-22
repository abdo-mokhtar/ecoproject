import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecosensetest/screens/navigationdestination/settings_page.dart';
import 'package:ecosensetest/screens/weather_screen.dart';
import 'package:ecosensetest/widgets/air_quality_widget.dart';
import 'package:ecosensetest/widgets/popup_menu.dart';
import 'package:ecosensetest/screens/navigationdestination/profile_widget.dart';
import '../tips/regular_user_tips_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreenUser(),
    );
  }
}

class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({super.key});

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isAirQualitySelected = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    if (_selectedIndex == 1 || _selectedIndex == 2)
      return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/images/EcoSenseLogo.PNG', height: 30),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 1),
                child: ClipOval(
                  child: Image.asset(
                    'assets/gif/profile.gif',
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const PopupMenuButtonMenu(),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/gif/background2.gif',
              width: double.infinity,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _homeContent();
      case 1:
        return ProfileWidget();
      case 2:
        return const RegularUserTipsScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomNavBar() {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: Colors.green.shade100,
      buttonBackgroundColor: Colors.green,
      height: 60,
      animationDuration: const Duration(milliseconds: 300),
      index: _selectedIndex,
      items: const [
        Icon(Icons.home, size: 30, color: Colors.white),
        Icon(Icons.person, size: 30, color: Colors.white),
        Icon(Icons.tips_and_updates, size: 30, color: Colors.white),
        Icon(Icons.settings, size: 30, color: Colors.white),
      ],
      onTap: (index) {
        if (index == 3) {
          int currentIndex = _selectedIndex; // ← خزنه
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsPage(),
              fullscreenDialog: true,
            ),
          ).then((_) {
            // بعد ما نرجع من Settings، نرجع لنفس الصفحة
            setState(() => _selectedIndex = currentIndex);
          });
        } else {
          setState(() => _selectedIndex = index);
        }
      },
    );
  }

  Widget _homeContent() {
    return Column(
      children: [
        _buildToggleButtons(),
        const SizedBox(height: 10),
        Expanded(
          child: isAirQualitySelected
              ? Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.green,
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      tabs: const [
                        Tab(text: "Live Data"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          AirQualityWidget(),
                        ],
                      ),
                    ),
                  ],
                )
              : const WeatherScreen(),
        ),
      ],
    );
  }

  Widget _buildToggleButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildToggleButton("Air Quality", isAirQualitySelected, () {
            setState(() => isAirQualitySelected = true);
          }),
          const SizedBox(width: 10),
          _buildToggleButton("Weather", !isAirQualitySelected, () {
            setState(() => isAirQualitySelected = false);
          }),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: selected
                  ? label == "Weather"
                      ? [
                          Colors.blue.shade700,
                          Colors.blue.shade300
                        ] // لون Weather عند التحديد
                      : [
                          Colors.green.shade300,
                          Colors.blue.shade300
                        ] // لون Air Quality عند التحديد
                  : [
                      Colors.grey.shade400,
                      Colors.grey.shade300
                    ], // لون الأزرار غير المحددة
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
