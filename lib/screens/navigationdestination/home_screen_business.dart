import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecosensetest/screens/tips/business_tips_screen.dart';
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
      home: HomeScreenBusiness(),
    );
  }
}

class HomeScreenBusiness extends StatefulWidget {
  const HomeScreenBusiness({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenBusiness>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isAirQualitySelected = true;
  int _selectedIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

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
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _selectedIndex,
        height: 55,
        items: const [
          Icon(Icons.home_outlined, size: 30),
          Icon(Icons.person_outline, size: 30),
          Icon(Icons.tips_and_updates_outlined, size: 30),
          Icon(Icons.settings_outlined, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.green,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          if (index == 3) {
            _showSettingsBottomSheet(context);
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
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
        return const BusinessTipsScreen();
      default:
        return Container();
    }
  }

  Widget _homeContent() {
    return Column(
      children: [
        const SizedBox(height: 16),
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
                      tabs: const [
                        Tab(text: "Live Data"),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Sensor Data"),
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

  Widget _buildToggleButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildToggleButton(
            "Air Quality",
            isAirQualitySelected,
            () => setState(() => isAirQualitySelected = true),
            selectedColors: [Colors.green.shade300, Colors.blue.shade300],
          ),
          const SizedBox(width: 10),
          _buildToggleButton(
            "Weather",
            !isAirQualitySelected,
            () => setState(() => isAirQualitySelected = false),
            selectedColors: [Colors.blue.shade700, Colors.blue.shade300],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(
    String label,
    bool selected,
    VoidCallback onTap, {
    required List<Color> selectedColors,
    List<Color> unselectedColors = const [
      const Color(0xFFBDBDBD), // بدل Colors.grey.shade400
      const Color(0xFFE0E0E0), // بدل Colors.grey.shade300
    ],
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: selected ? selectedColors : unselectedColors,
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
