// ignore_for_file: library_private_types_in_public_api

import 'package:ecosensetest/air_quality_widget.dart';
import 'package:ecosensetest/notification_screen%20.dart';
import 'package:ecosensetest/popup_menu.dart';
import 'package:ecosensetest/search_text_field.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                        Image.asset('assets/images/EcoSenseLogo.PNG',
                            height: 30),
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
                    const SizedBox(height: 10),
                    const SearchTextField(),
                  ],
                ),
              ),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        height: 50,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (index == 3) {
            _showSettingsBottomSheet(context);
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Colors.green),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Colors.green),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications, color: Colors.green),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings, color: Colors.green),
            label: '',
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
        return _buildSettingsPage();
      },
    );
  }

  Widget _buildBody() {
    if (_selectedIndex == 0) {
      return _homeContent();
    } else if (_selectedIndex == 1) {
      return ProfileWidget();
    } else if (_selectedIndex == 2) {
      return NotificationsScreen();
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
              /// Air Quality button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAirQualitySelected = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade300, Colors.blue.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text("Air Quality",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              /// Weather button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAirQualitySelected = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
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
                              : FontWeight.normal),
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
                    /// Tab bar with two tabs: API Data and Hardware Data
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
                                  image:
                                      AssetImage('assets/images/premium.png'),
                                  height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// Tab bar view with two children: AirQualityWidget and a text
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          const AirQualityWidget(),
                          const Center(
                              child: const Text("Hardware Data\n(Sensors)")),
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

  Widget _buildSettingsPage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSwitchTile("Dark mode", isDarkMode, (value) {
            setState(() {
              isDarkMode = value;
            });
          }),
          const Divider(),
          _buildSwitchTile("Arabic Language", isArabic, (value) {
            setState(() {
              isArabic = value;
            });
          }),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
