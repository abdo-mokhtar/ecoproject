import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  final List<String> notifications =
      List.generate(100, (index) => "Be careful"); // 100 إشعار لتجربة القائمة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 19, left: 16, right: 16, bottom: 12),
            child: Center(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // توسيط الصف بأكمله
                children: [
                  const Icon(Icons.tips_and_updates,
                      color: Colors.orange, size: 24),
                  const SizedBox(width: 8), // زيادة المسافة قليلاً
                  const Text(
                    "Tips",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// قائمة الإشعارات
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          notifications[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/EcoSenseLogo.PNG',
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          /// زر "Clear All"
        ],
      ),
    );
  }
}
