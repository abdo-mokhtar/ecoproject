/*import 'package:flutter/material.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Schedule the navigation after 14 seconds
    Timer(const Duration(seconds: 14), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/gif/ecosenselogo2.gif',
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
        // Center content (logo and text)
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Image.asset(
              'assets/images/EcoSenseLogo.PNG',
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.3,
          ),
          const Text(
            'Are You ready to be Eco-Friendly!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inria Serif',
              color: Color(0xFF90C5AE), // Optional: Custom color
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),

          // Bottom-right arrow
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(30.0), // Padding to adjust distance from edges
              child: GestureDetector(
                onTap: () {
                  // Navigate to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChoosePlanScreen()), // your target screen
                  );
                },
                child: const Icon(
                  Icons.arrow_forward,
                  size: 40, // Size of the arrow
                  color: Color(0xFF48A47C), // Color of the arrow
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for the ChoosePlanScreen
class ChoosePlanScreen extends StatelessWidget {
  const ChoosePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                const SizedBox(height: 20),
                const Text(
                  'Welcome to EcoSense\nChoose your plan!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Inria Serif',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF48A47C),
                  ),
                ),
                const SizedBox(height: 20),

                // User Plan
                buildPlanCard(
                  context,
                  title: 'User',
                  features: [
                    '- Air Quality Updates',
                    '- Pollution Notification',
                    '- Eco Friendly Tips',
                    '- Interactive Maps',
                  ],
                ),
                const SizedBox(height: 2),

                // Business Plan
                buildPlanCard(
                  context,
                  title: 'Business',
                  features: [
                    '- Sustainable Practices Resource',
                    '- Sustainability Goal Tools',
                    '- Environmental Impact Insights',
                    '- Emission Reduction Recommendations',
                  ],
                ),
                const SizedBox(height: 2),

                // Government Plan
                buildPlanCard(
                  context,
                  title: 'Government',
                  features: [
                    '- Comprehensive Analytics',
                    '- AI-driven Pollution Identification',
                    '- Policy Suggestions',
                    '- Monitoring Tools',
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPlanCard(BuildContext context,
      {required String title, required List<String> features}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xD8C6E0E2),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontFamily: 'Inika',
                fontWeight: FontWeight.bold,
                color: Color(0xFF48A47C),
              ),
            ),
            const SizedBox(height: 10),
            // Features
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features
                  .map((feature) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      feature,
                      style: const TextStyle(fontSize: 15,fontFamily: 'JejuGothic', color: Color(0xFF535353)),
                    ),
                  ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            // Start Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle button click
                  if(title=='User'){
                    Navigator.push(
                        context,
                      MaterialPageRoute(builder: (context) =>  UserOnboardingScreen()),
                    );
                  } else if(title == 'Business'){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  BusinessOnboardingScreen()),
                    );
                  } else if(title == 'Government'){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  GovernmentOnboardingScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color(0xFF48A47C)
                ),
                child: const Text('Start', style: TextStyle(fontSize: 14, color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//user onboarding screen
class UserOnboardingScreen extends StatelessWidget {
  final controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pageContent = [
      {
        'title': 'Air Quality Updates',
        'description': 'Daily tips on how to reduce their environmental impact and adopt more sustainable habits',
        'json': 'assets/json/Animation - 1732729633428.json',
      },
      {
        'title': 'Pollution Notification',
        'description': 'This feature alerts users with timely notifications about rising pollution levels in their area such as PM2.5, CO2, NO2',
        'json': 'assets/json/Notification Animation.json',
      },
      {
        'title': 'Eco-Friendly Tips',
        'description': 'Daily tips on how to reduce their environmental impact and adopt more sustainable habits',
        'json': 'assets/json/Tips animation.json',
      },
      {
        'title': 'Interactive Maps',
        'description': 'Real-time maps that display the levels of air pollution across different regions',
        'json': 'assets/json/Interactive Map Animation.json',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 1),
              SizedBox(
                height: 630,
                child: PageView.builder(
                  controller: controller,
                  itemCount: pageContent.length,
                  itemBuilder: (_, index) {
                    final content = pageContent[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        //color: Colors.white,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (content.containsKey('json'))
                              Lottie.asset(
                                content['json']!,
                                height: 300,
                              )
                            else if (content.containsKey('image'))
                              Image.asset(
                                content['image']!,
                                height: 300,
                              ),
                            SizedBox(height: 20),
                            Text(
                              content['title']!,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF48A47C),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              content['description']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              SmoothPageIndicator(
                controller: controller,
                count: pageContent.length,
                effect: const WormEffect(
                  dotColor: Color(0x88CDEFE0),
                  activeDotColor: Color(0xFF48A47C),
                  dotHeight: 15,
                  dotWidth: 15,
                  type: WormType.thinUnderground,
                ),
              ),
              SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  // Navigate to the next screen
                  Navigator.pushReplacementNamed(context, '/home'); // Update the route as needed
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: BorderSide(color: Color(0xFF48A47C), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16, color: Color(0xFF48A47C),fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Business onboarding screen
class BusinessOnboardingScreen extends StatelessWidget {
  final controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pageContent = [
      {
        'title': 'Sustainable Practice Resource',
        'description': ' Provide guidelines to encourage responsible consumption, and green business operations.',
        'json': 'assets/json/Sustainable Practice Resource animation.json',
      },
      {
        'title': 'Sustainability Goal Tools',
        'description': 'Tools help stakeholders make informed decisions to drive positive environmental and social impact',
        'json': 'assets/json/Sustainability Goal Tools Animation.json',
      },
      {
        'title': 'Environmental Impact Insights',
        'description': ' help organizations, policymakers, and individuals assess factors like carbon emissions, resource consumption, waste generation, and ecosystem disruption.',
        'json': 'assets/json/Environmental Impact Insights Animation.json',
      },
      {
        'title': ' Emission Reduction Recommendations',
        'description': 'Strategies aimed at minimizing the release of greenhouse gases (GHGs) and other pollutants into the atmosphere.',
        'json': 'assets/json/Emission Reduction Recommendations Animation.json',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 1),
              SizedBox(
                height: 640,
                child: PageView.builder(
                  controller: controller,
                  itemCount: pageContent.length,
                  itemBuilder: (_, index) {
                    final content = pageContent[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        //color: Colors.white,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (content.containsKey('json'))
                              Lottie.asset(
                                content['json']!,
                                height: 300,
                              )
                            else if (content.containsKey('image'))
                              Image.asset(
                                content['image']!,
                                height: 300,
                              ),
                            SizedBox(height: 20),
                            Text(
                              content['title']!,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF48A47C),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              content['description']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              SmoothPageIndicator(
                controller: controller,
                count: pageContent.length,
                effect: const WormEffect(
                  dotColor: Color(0x88CDEFE0),
                  activeDotColor: Color(0xFF48A47C),
                  dotHeight: 15,
                  dotWidth: 15,
                  type: WormType.thinUnderground,
                ),
              ),
              SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  // Navigate to the next screen
                  Navigator.pushReplacementNamed(context, '/home'); // Update the route as needed
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: BorderSide(color: Color(0xFF48A47C), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16, color: Color(0xFF48A47C),fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//Government onboarding screen
class GovernmentOnboardingScreen extends StatelessWidget {
  final controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pageContent = [
      {
        'title': 'Comprehensive Analytics',
        'description': 'This approach helps identify patterns, predict outcomes, and provide actionable recommendations',
        'json': 'assets/json/Comprehensive Analytics Animation.json',
      },
      {
        'title': 'AI-driven pollution Idenification',
        'description': 'use of artificial intelligence to detect, analyze, and monitor pollution levels.',
        'json': 'assets/json/AI Driven Pollution Identification Animation.json',
      },
      {
        'title': 'Environmental Impact Insights',
        'description': ' help organizations, policymakers, and individuals assess factors like carbon emissions, resource consumption, waste generation, and ecosystem disruption.',
        'json': 'assets/json/Environmental Impact Insight Animation.json',
      },
      {
        'title': 'Mentoring Tools',
        'description': ' Aim to guide governments, organizations, and stakeholders in implementing effective measures.',
        'json': 'assets/json/Mentoring Tools Animation.json',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 1),
              SizedBox(
                height: 640,
                child: PageView.builder(
                  controller: controller,
                  itemCount: pageContent.length,
                  itemBuilder: (_, index) {
                    final content = pageContent[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        //color: Colors.white,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (content.containsKey('json'))
                              Lottie.asset(
                                content['json']!,
                                height: 300,
                              )
                            else if (content.containsKey('image'))
                              Image.asset(
                                content['image']!,
                                height: 300,
                              ),
                            SizedBox(height: 20),
                            Text(
                              content['title']!,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF48A47C),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              content['description']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              SmoothPageIndicator(
                controller: controller,
                count: pageContent.length,
                effect: const WormEffect(
                  dotColor: Color(0x88CDEFE0),
                  activeDotColor: Color(0xFF48A47C),
                  dotHeight: 15,
                  dotWidth: 15,
                  type: WormType.thinUnderground,
                ),
              ),
              SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  // Navigate to the next screen
                  Navigator.pushReplacementNamed(context, '/home'); // Update the route as needed
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  side: BorderSide(color: Color(0xFF48A47C), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16, color: Color(0xFF48A47C),fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/////////////////////////////////////

 */

import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'start_page.dart';
import 'choose_plan_screen.dart';
import 'user_onboarding_screen.dart';
import 'business_onboarding_screen.dart';
import 'government_onboarding_screen.dart';
import 'home_screen.dart';
import 'signup.dart';
import 'login.dart';
//import 'login_screen.dart';

void main() {
  runApp(EcoSenseApp());
}

class EcoSenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // البداية تكون من SplashScreen
      routes: {
        '/': (context) => const SplashScreen(),
        '/start': (context) => const StartPage(),
        '/choose-plan': (context) => const ChoosePlanScreen(),
        '/user-onboarding': (context) => UserOnboardingScreen(),
        '/business-onboarding': (context) => BusinessOnboardingScreen(),
        '/government-onboarding': (context) => GovernmentOnboardingScreen(),
        '/home': (context) => HomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
