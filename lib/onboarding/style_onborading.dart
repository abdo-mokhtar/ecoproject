import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' show Lottie;
import 'package:simple_animations/simple_animations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    show
        CustomizableEffect,
        DotDecoration,
        ExpandingDotsEffect,
        JumpingDotEffect,
        SlideEffect,
        SmoothPageIndicator;

class StyleOnBoarding extends StatefulWidget {
  const StyleOnBoarding({
    super.key,
    required this.controller,
    required this.pageContent,
  });

  final PageController controller;
  final List<Map<String, String>> pageContent;

  @override
  _StyleOnBoardingState createState() => _StyleOnBoardingState();
}

class _StyleOnBoardingState extends State<StyleOnBoarding>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // Provides the ticker provider
      duration: const Duration(seconds: 1),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController
        .forward(); // Start the animation when the page is loaded
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FadeTransition(
        opacity: _opacityAnimation, // Apply the fade effect to the entire page
        child: Stack(
          children: [
            // الخلفية الطبيعية
            const NatureBackground(),

            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // زرار Skip
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        borderRadius:
                            BorderRadius.circular(25), // تقليل انحناء الحواف
                        splashColor: Colors.green
                            .withOpacity(0.3), // تأثير الانتقال عند الضغط
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8), // تقليل المسافة حول النص
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: Colors.white,
                                width: 2), // تحديد حدود الزر باللون الأبيض
                            color: Colors.green, // خلفية خضراء للزر
                          ),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 16, // تقليل حجم النص
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // نص أبيض لزيادة وضوحه
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.001),

                  // الـ PageView with animated page transitions
                  SizedBox(
                    height: screenHeight * 0.65,
                    child: PageView.builder(
                      controller: widget.controller,
                      itemCount: widget.pageContent.length,
                      itemBuilder: (_, index) {
                        final content = widget.pageContent[index];
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            key: ValueKey<int>(index),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (content.containsKey('json'))
                                  Expanded(
                                    flex: 5,
                                    child: Lottie.asset(
                                      content['json']!,
                                      height: screenHeight * 0.35,
                                    ),
                                  )
                                else if (content.containsKey('image'))
                                  Expanded(
                                    flex: 5,
                                    child: Image.asset(
                                      content['image']!,
                                      height: screenHeight * 0.35,
                                    ),
                                  ),
                                const SizedBox(height: 20),
                                Text(
                                  content['title']!,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0B6623),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0),
                                  child: Text(
                                    content['description']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // SmoothPageIndicator
                  SmoothPageIndicator(
                    controller: widget.controller,
                    count: widget.pageContent.length,
                    effect: const ExpandingDotsEffect(
                      expansionFactor: 3,
                      spacing: 8.0,
                      radius: 16.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      dotColor: const Color(0xFFa8e6cf),
                      activeDotColor: const Color(0xFF0B6623),
                    ),
                  ),

                  const Spacer(),

                  // زرار Get Started with Animation
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                    child: ScaleTransition(
                      scale: _animationController.drive(
                        CurveTween(curve: Curves.easeOut),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          shadowColor: Colors.black26,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor:
                              Colors.transparent, // مهم عشان نرسم الجريدينت
                        ).copyWith(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.transparent),
                          surfaceTintColor:
                              WidgetStateProperty.all(Colors.transparent),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF00c853), // أخضر فاتح
                                Color(0xFF0B6623), // أخضر غامق
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(minHeight: 50),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// خلفية طبيعية متدرجة
class NatureBackground extends StatelessWidget {
  const NatureBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return MirrorAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 8),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                    const Color(0xFF0B6623), const Color(0xFF48A47C), value)!,
                Color.lerp(
                    const Color(0xFFa8e6cf), const Color(0xFFdcedc8), value)!,
              ],
            ),
          ),
        );
      },
    );
  }
}
