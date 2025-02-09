import 'package:ecosensetest/profile_widget.dart';
import 'package:flutter/material.dart';

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
            // Custom AppBar
            Container(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo
                      Image.asset('assets/images/EcoSenseLogo.PNG', height: 30),

                      const Spacer(), // Pushes the items apart

                      // Profile Image
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1; // Navigate to profile page
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

                      // Menu Icon
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Search Bar
                  // Search Bar
                  SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for a City",
                        hintStyle: TextStyle(
                          color: Colors.green.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.green.shade400),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.grey, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.green.shade50,
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            // Body Content
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 50,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
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

  Widget _buildBody() {
    if (_selectedIndex == 0) {
      return _homeContent();
    } else if (_selectedIndex == 1) {
      return ProfileWidget();
    } else if (_selectedIndex == 2) {
      return const Center(child: Text("Alerts Page"));
    } else {
      return const Center(child: Text("Settings Page"));
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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )),
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
                    child: Text("Weather",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: !isAirQualitySelected
                                ? FontWeight.bold
                                : FontWeight.normal)),
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
                      mainAxisSize: MainAxisSize.min, // Ensures the row takes only required space
                      children: [
                        Text("Hardware Data"),
                        SizedBox(width: 5), // Adds spacing between text and image
                        Image(
                          image: AssetImage('assets/images/premium.png'),
                          height: 20, // Adjust size as needed
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
                    Center(child: Text("Air Quality Data\n(API)")),
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
}
