import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                  Navigator.pushReplacementNamed(context, '/login'); // Update the route as needed
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