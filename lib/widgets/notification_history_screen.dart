import 'package:ecosensetest/screens/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification History"),
        backgroundColor: Colors.green.shade400,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: NotificationService.getSavedNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No notifications found."));
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final timestamp = DateTime.parse(notification['timestamp']);
              final formattedTime =
                  DateFormat('yyyy-MM-dd hh:mm a').format(timestamp);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    notification['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${notification['body']}\n$formattedTime"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
