import 'dart:math';

import 'package:ecosensetest/air_quality_widget.dart';
import 'package:ecosensetest/government_tips_screen.dart'
    show GovernmentTipsScreen;
import 'package:ecosensetest/regular_user_tips_screen.dart'
    show RegularUserTipsScreen;
import 'package:ecosensetest/tips_screen%20.dart';
import 'package:ecosensetest/popup_menu.dart';
import 'package:ecosensetest/settings_page.dart' show SettingsPage;
import 'package:flutter/material.dart';
import 'package:ecosensetest/profile_widget.dart';
import 'package:ecosensetest/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isAirQualitySelected = true;

  int _selectedIndex = 0;
  bool isDarkMode = false;
  bool isArabic = false;

  final List<String> _allTips = List.generate(
      300,
      (index) =>
          "Tip ${index + 1}: Help improve air quality and weather awareness.");
  List<String> _shuffledTips = [];
  int _tipIndex = 0;

  String? get _currentTip =>
      _shuffledTips.isNotEmpty ? _shuffledTips[_tipIndex] : null;

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _shuffledTips = List.from(_allTips)..shuffle(Random());

    // Show initial tip
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_currentTip != null) {
        _showFloatingTip(_currentTip!);
      }
    });
  }

  void _showFloatingTip(String message) {
    if (_overlayEntry != null) return; // Only show if not already showing

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 80,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade600.withOpacity(0.95),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    // Remove after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            if (_selectedIndex != 1 && _selectedIndex != 2)
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/EcoSenseLogo.PNG',
                            height: 30,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 1;
                            });
                          },
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/gif/profile.gif',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const PopupMenuButtonMenu(),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/gif/background2.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        height: 55,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (index == 3) {
            _showSettingsBottomSheet(context);
          } else {
            setState(() {
              _selectedIndex = index;
              if (_shuffledTips.isNotEmpty) {
                _tipIndex = (_tipIndex + 1) % _shuffledTips.length;
              }
            });
            if (_currentTip != null) {
              _showFloatingTip(_currentTip!);
            }
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Colors.green),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Colors.green),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.tips_and_updates),
            selectedIcon: Icon(Icons.tips_and_updates, color: Colors.green),
            label: 'Tips',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings, color: Colors.green),
            label: 'Setting',
          ),
        ],
      ),
    );
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SettingsPage();
      },
    );
  }

  Widget _buildBody() {
    if (_selectedIndex == 0) {
      return _homeContent();
    } else if (_selectedIndex == 1) {
      return ProfileWidget();
    } else if (_selectedIndex == 2) {
      return const GovernmentTipsScreen();
    } else {
      return Container();
    }
  }

  Widget _homeContent() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAirQualitySelected = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade300, Colors.blue.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Air Quality",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: !isAirQualitySelected
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAirQualitySelected = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.blue.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Weather",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: !isAirQualitySelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
                      tabs: const [
                        Tab(text: "API Data"),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Hardware Data"),
                              SizedBox(width: 5),
                              Image(
                                image: AssetImage('assets/images/premium.png'),
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          const AirQualityWidget(),
                          const Center(child: Text("Hardware Data\n(Sensors)")),
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
}
