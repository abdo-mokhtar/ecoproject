import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

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
              padding: const EdgeInsets.only(
                  right: 1.0,
                  bottom: 30.0), // Padding to adjust distance from edges
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  // Navigate to the next screen
                  Navigator.pushNamed(
                      context, '/choose-plan'); // your target screen
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
