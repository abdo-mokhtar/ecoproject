import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<String> notifications =
      List.generate(100, (index) => "Be careful"); // 100 إشعار لتجربة القائمة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // إخفاء السهم
        // centerTitle: true, // توسيط العنوان
        title: Image.asset(
          'assets/images/EcoSenseLogo.PNG', // تأكد من صحة المسار
          height: 30, // ضبط حجم الشعار
        ),
      ),
      body: Column(
        children: [
          /// إضافة الـ Row أسفل الـ AppBar مباشرة
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Center(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // المحاذاة إلى اليسار
                children: [
                  Icon(Icons.notifications, color: Colors.orange, size: 24),
                  SizedBox(width: 8), // مسافة بين الأيقونة والنص
                  Center(
                    child: Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                // وظيفة حذف كل الإشعارات
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                minimumSize: const Size(120, 40),
                elevation: 2,
              ),
              child: const Text(
                "Clear All",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
