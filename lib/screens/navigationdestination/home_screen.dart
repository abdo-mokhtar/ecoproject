// import 'package:ecosensetest/screens/tips/business_tips_screen.dart';
import 'package:ecosensetest/screens/tips/government_tips_screen.dart';
// import 'package:ecosensetest/screens/tips/regular_user_tips_screen.dart'
//     show RegularUserTipsScreen;
import 'package:ecosensetest/screens/navigationdestination/settings_page.dart'
    show SettingsPage;
import 'package:ecosensetest/screens/weather_screen.dart' show WeatherScreen;
import 'package:ecosensetest/widgets/air_quality_widget.dart'
    show AirQualityWidget;
import 'package:ecosensetest/widgets/popup_menu.dart' show PopupMenuButtonMenu;
import 'package:ecosensetest/screens/navigationdestination/profile_widget.dart'
    show ProfileWidget;
import 'package:flutter/material.dart';

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
                      height: MediaQuery.of(context).size.height * 0.08,
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
            });
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
            icon: Icon(Icons.tips_and_updates_outlined),
            selectedIcon: Icon(Icons.tips_and_updates, color: Colors.green),
            label: 'Tips',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings, color: Colors.green),
            label: 'Settings',
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
    switch (_selectedIndex) {
      case 0:
        return _homeContent();
      case 1:
        return ProfileWidget();
      case 2:
        return const GovernmentTipsScreen();
      default:
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
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
                          fontWeight: isAirQualitySelected
                              ? FontWeight.bold
                              : FontWeight.normal,
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
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.blue.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
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
                        children: const [
                          AirQualityWidget(),
                          Center(child: Text("Hardware Data\n(Sensors)")),
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
