import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StyleOnBoarding extends StatelessWidget {
  const StyleOnBoarding({
    super.key,
    required this.controller,
    required this.pageContent,
  });

  final PageController controller;
  final List<Map<String, String>> pageContent;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.01),
          SizedBox(
            height: screenHeight * 0.65,
            child: PageView.builder(
              controller: controller,
              itemCount: pageContent.length,
              itemBuilder: (_, index) {
                final content = pageContent[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (content.containsKey('json'))
                          Lottie.asset(
                            content['json']!,
                            height: screenHeight * 0.35,
                          )
                        else if (content.containsKey('image'))
                          Image.asset(
                            content['image']!,
                            height: screenHeight * 0.35,
                          ),
                        SizedBox(height: screenHeight * 0.03),
                        Text(
                          content['title']!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF48A47C),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          content['description']!,
                          style: const TextStyle(
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
          SizedBox(height: screenHeight * 0.02),
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
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02),
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                side: const BorderSide(color: Color(0xFF48A47C), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF48A47C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
