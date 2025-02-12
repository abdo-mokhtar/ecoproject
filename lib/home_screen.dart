import 'package:ecosensetest/air_quality_widget.dart';
import 'package:ecosensetest/api_service.dart';
import 'package:ecosensetest/meet_our_team.dart';
import 'package:flutter/material.dart';
import 'package:ecosensetest/profile_widget.dart';
import 'package:ecosensetest/about_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
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
      body: SafeArea(
        child: Column(
          children: [
            if (_selectedIndex != 1)
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
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.menu, color: Colors.black),
                          offset: Offset(0, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          onSelected: (String value) {
                            if (value == 'login') {
                              print("Login Selected");
                            } else if (value == 'signin') {
                              print("Signin Selected");
                            } else if (value == 'team') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MeetOurTeamPage()),
                              );
                            } else if (value == 'about') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutPage()),
                              );
                            } else if (value == 'signout') {
                              print("SignOut Selected");
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'login',
                                child: Row(
                                  children: const [
                                    Icon(Icons.login, color: Colors.black),
                                    SizedBox(width: 10),
                                    Text("LogIn"),
                                  ],
                                ),
                              ),
                              const PopupMenuDivider(),
                              PopupMenuItem<String>(
                                value: 'signin',
                                child: Row(
                                  children: const [
                                    Icon(Icons.person_add, color: Colors.black),
                                    SizedBox(width: 10),
                                    Text("SignIn"),
                                  ],
                                ),
                              ),
                              const PopupMenuDivider(),
                              PopupMenuItem<String>(
                                value: 'team',
                                child: Row(
                                  children: const [
                                    Icon(Icons.group, color: Colors.black),
                                    SizedBox(width: 10),
                                    Text("Meet Our Team"),
                                  ],
                                ),
                              ),
                              const PopupMenuDivider(),
                              PopupMenuItem<String>(
                                value: 'about',
                                child: Row(
                                  children: const [
                                    Icon(Icons.info, color: Colors.black),
                                    SizedBox(width: 10),
                                    Text("About"),
                                  ],
                                ),
                              ),
                              const PopupMenuDivider(),
                              PopupMenuItem<String>(
                                value: 'signout',
                                child: Row(
                                  children: const [
                                    Icon(Icons.logout, color: Colors.red),
                                    SizedBox(width: 10),
                                    Text(
                                      "SignOut",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ];
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search for a City",
                          hintStyle: TextStyle(
                            color: Colors.green.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.green.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.green.shade50,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
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
      return const Center(child: Text("Alerts Page"));
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
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAirQualitySelected = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.blue.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
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
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          AirQualityWidget(),
                          Center(child: Text("Hardware Data\n(Sensors)")),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: Text("Weather Data\n(API Only)")),
        ),
      ],
    );
  }

  Widget _buildSettingsPage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
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
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
