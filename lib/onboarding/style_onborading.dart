import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StyleOnBoarding extends StatefulWidget {
  const StyleOnBoarding({
    super.key,
    required this.controller,
    required this.pageContent,
  });

  final PageController controller;
  final List<Map<String, String>> pageContent;

  @override
  State<StyleOnBoarding> createState() => _StyleOnBoardingState();
}

class _StyleOnBoardingState extends State<StyleOnBoarding>
    with SingleTickerProviderStateMixin {
  late AnimationController _screenAnimationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation أول لما تفتح الصفحة
    _screenAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _screenAnimationController,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _screenAnimationController,
      curve: Curves.easeOut,
    ));

    _screenAnimationController.forward();
  }

  @override
  void dispose() {
    _screenAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                height: screenHeight * 0.65,
                child: PageView.builder(
                  controller: widget.controller,
                  itemCount: widget.pageContent.length,
                  itemBuilder: (_, index) {
                    final content = widget.pageContent[index];
                    return AnimatedBuilder(
                      animation: widget.controller,
                      builder: (context, child) {
                        double value = 1.0;
                        if (widget.controller.position.haveDimensions) {
                          value = widget.controller.page! - index;
                          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                        }
                        return Transform.scale(
                          scale: value,
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
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
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              SmoothPageIndicator(
                controller: widget.controller,
                count: widget.pageContent.length,
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
                padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
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
        ),
      ),
    );
  }
}
