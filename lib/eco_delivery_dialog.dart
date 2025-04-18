import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class EcoDeliveryDialog {
  static final List<Map<String, dynamic>> ecoMessages = [
    {
      "message":
          "Every small action counts when it comes to preserving our planet 🌍. By choosing eco-friendly delivery methods, you're helping reduce pollution and conserve natural resources.\n\nTogether, we can make a big difference in creating a healthier and more sustainable world. Thank you for your positive impact! 💚",
      "icon": Icons.nature_people,
    },
    {
      "message":
          "By supporting eco-friendly delivery, you're helping reduce carbon emissions and protect our environment. 🌿 Every choice matters in building a greener future.\n\nWe appreciate your commitment to a sustainable planet! 💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Your choice of eco-friendly delivery helps reduce waste and conserves energy. 🌍 We're all part of a global effort to protect our planet and ensure a brighter future for generations to come. Thank you for doing your part! 💚",
      "icon": Icons.recycling,
    },
    {
      "message":
          "Sustainability is key to protecting our planet. By opting for eco-friendly delivery, you're making a positive impact on the environment. 🌱 Your support helps reduce pollution and conserve precious resources. Thank you! 💚",
      "icon": Icons.nature,
    },
    {
      "message":
          "Choosing eco-friendly delivery methods helps us reduce the carbon footprint and ensures a cleaner future. 🌍 Together, we can help protect the planet for future generations. 💚",
      "icon": Icons.solar_power,
    },
    {
      "message":
          "Thank you for choosing sustainable delivery options! By making this choice, you’re contributing to a healthier, greener planet. 🌱 Keep up the good work! 💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Your eco-friendly choice helps reduce waste, conserve resources, and promote sustainability. 🌎 Thank you for playing a key role in protecting the environment! 💚",
      "icon": Icons.recycling,
    },
    {
      "message":
          "Every delivery made through eco-friendly methods helps create a cleaner environment. 🌿 Thanks for helping us make the planet greener! 💚",
      "icon": Icons.nature_people,
    },
    {
      "message":
          "By selecting eco-friendly delivery, you’re not just getting your package — you're helping the planet breathe a little easier. 🌍 Thank you for making a difference! 💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Thank you for supporting eco-friendly delivery! Every choice to reduce our environmental impact matters. Together, we’re building a sustainable future. 💚",
      "icon": Icons.filter_vintage,
    },
    {
      "message":
          "Small actions can lead to big changes. Your choice of eco-friendly delivery is a step toward reducing pollution and preserving natural resources. 🌍 Thank you for your commitment! 💚",
      "icon": Icons.nature,
    },
    {
      "message":
          "Your decision to go eco-friendly is a win for the planet. 🌱 Let's continue to reduce our carbon footprint together! 💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Thank you for being part of the solution. By choosing eco-friendly delivery, you’re helping reduce emissions and conserve precious natural resources. 🌍",
      "icon": Icons.nature_people,
    },
    {
      "message":
          "Opting for sustainable delivery options helps protect our wildlife and preserve natural habitats. 🌿 Thank you for doing your part! 💚",
      "icon": Icons.pets,
    },
    {
      "message":
          "You’re helping reduce the waste that pollutes our oceans and landfills. 🌊 Your choice to go green is an investment in our future. 💚",
      "icon": Icons.water_damage,
    },
    {
      "message":
          "Your eco-friendly decision supports the environment and ensures cleaner air, water, and soil for future generations. 🌍 Thank you for your commitment to sustainability! 💚",
      "icon": Icons.water_drop,
    },
    {
      "message":
          "By choosing sustainable delivery, you're helping reduce waste and promote environmental responsibility. 🌿 Keep up the good work! 💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Together, we can reduce the amount of plastic waste that harms wildlife. Your choice to go eco-friendly makes a difference. 🌱 Thank you! 💚",
      "icon": Icons.recycling,
    },
    {
      "message":
          "Thank you for supporting a greener world. Every delivery made sustainably reduces pollution and helps create a cleaner, healthier planet. 🌍💚",
      "icon": Icons.nature_people,
    },
    {
      "message":
          "You’re playing an important role in reducing environmental harm. Your choice of eco-friendly delivery promotes sustainability for everyone. 🌿💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "By choosing eco-friendly delivery, you're making an impactful contribution to reducing pollution. Thank you for your dedication to the planet! 🌍💚",
      "icon": Icons.nature,
    },
    {
      "message":
          "Your commitment to eco-friendly delivery is helping reduce our global carbon footprint. 🌍 Let's continue building a better world together! 💚",
      "icon": Icons.solar_power,
    },
    {
      "message":
          "The more we choose sustainable options, the greener the world becomes. 🌱 Thank you for making an eco-friendly decision today! 💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Together, we can make the world a better place for future generations. Your eco-friendly choice is a positive step toward a sustainable future. 💚🌍",
      "icon": Icons.nature_people,
    },
    {
      "message":
          "Every eco-friendly delivery choice adds up to create a cleaner, healthier planet. Your actions are making a difference! 🌍💚",
      "icon": Icons.recycling,
    },
    {
      "message":
          "Choosing eco-friendly delivery is a small step for you, but a giant leap for the planet. 🌿 Keep up the great work! 💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Your sustainable delivery choices are making our world a better place. 🌱 Thank you for caring about the environment! 💚",
      "icon": Icons.filter_vintage,
    },
    {
      "message":
          "Every eco-friendly decision counts. By choosing sustainable delivery methods, you’re making a difference. 🌍💚",
      "icon": Icons.recycling,
    },
    {
      "message":
          "Choosing a greener delivery option reduces our reliance on fossil fuels and helps protect the planet. 🌍💚",
      "icon": Icons.solar_power,
    },
    {
      "message":
          "Thank you for your commitment to sustainability. Your decision to choose eco-friendly delivery is an important step toward reducing pollution. 🌱💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "By choosing eco-friendly delivery, you’re helping conserve the Earth’s resources and reduce waste. 🌿 Your support is invaluable! 💚",
      "icon": Icons.nature,
    },
    {
      "message":
          "The future of our planet is in our hands, and your choice today is making a big difference. 🌍 Thank you for choosing sustainability! 💚",
      "icon": Icons.nature_people,
    },
    {
      "message":
          "Thanks to your eco-friendly delivery choice, we’re one step closer to creating a cleaner, greener world. 🌱💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Sustainable delivery options are helping protect wildlife and reduce pollution. 🌿 Thank you for supporting the environment! 💚",
      "icon": Icons.pets,
    },
    {
      "message":
          "Your eco-friendly choice helps reduce harmful emissions and preserve the beauty of nature. 🌍 Keep up the great work! 💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Making sustainable choices today ensures a cleaner tomorrow. Thank you for choosing eco-friendly delivery options! 🌱💚",
      "icon": Icons.nature,
    },
    {
      "message":
          "Every eco-friendly choice is a step toward a more sustainable future. Thank you for your continued support of our planet! 💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "With each sustainable delivery option you choose, you're helping conserve natural resources. 🌍 Thank you for being part of the solution! 💚",
      "icon": Icons.recycling,
    },
    {
      "message":
          "The Earth is our home, and we must protect it. Your eco-friendly decision today helps safeguard it for the future. 🌱💚",
      "icon": Icons.nature,
    },
    {
      "message":
          "By choosing green delivery options, you're reducing waste and making a positive impact on the environment. 🌍💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Your eco-friendly decision helps reduce pollution, conserve resources, and create a sustainable future. 🌿 Thank you for caring about the planet! 💚",
      "icon": Icons.nature_people,
    },
    {
      "message":
          "Together, we can make a meaningful impact on the environment. Thank you for choosing sustainable delivery! 🌍💚",
      "icon": Icons.recycling,
    },
    {
      "message":
          "Thank you for supporting the planet through eco-friendly delivery methods. Your actions are helping create a cleaner, greener world. 🌱💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Every delivery made with eco-friendly methods is one step closer to reducing carbon emissions. Thank you for your support! 🌍💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "The future is green! By choosing sustainable delivery, you're taking part in a global effort to protect our environment. 🌿💚",
      "icon": Icons.nature,
    },
    {
      "message":
          "The planet is in good hands with people like you who choose eco-friendly delivery options. Thank you for your positive impact! 🌍💚",
      "icon": Icons.nature_people,
    },
    {
      "message":
          "Your commitment to the environment helps ensure a brighter future for everyone. Thank you for choosing eco-friendly delivery! 🌱💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "A cleaner planet starts with small steps, like choosing eco-friendly delivery. Thank you for doing your part to protect the environment! 💚",
      "icon": Icons.recycling,
    },
    {
      "message":
          "Thank you for making sustainable delivery choices. You're helping reduce the amount of plastic waste that harms our ecosystems. 🌍💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Your eco-friendly choice is helping make the world a better place, one delivery at a time. Thank you for your positive contribution! 💚",
      "icon": Icons.filter_vintage,
    },
    {
      "message":
          "Together, we can reduce emissions and protect the planet. Every choice you make counts toward a greener world. 🌍💚",
      "icon": Icons.eco,
    },
    {
      "message":
          "Sustainability isn’t just a trend, it’s a responsibility. Thank you for taking action to protect the planet through eco-friendly delivery options! 🌿💚",
      "icon": Icons.nature_people,
    },
  ];
  static Future<void> show(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final lastShownTime = prefs.getInt('lastShownTime') ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (currentTime - lastShownTime > 24 * 60 * 60 * 1000) {
      if (ecoMessages.isNotEmpty) {
        Map<String, dynamic> randomMessage =
            ecoMessages[Random().nextInt(ecoMessages.length)];

        showDialog(
          context: context,
          builder: (context) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    randomMessage["icon"],
                    color: Colors.green.shade600,
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    randomMessage["message"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      await prefs.setInt('lastShownTime', currentTime);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
  }
}
