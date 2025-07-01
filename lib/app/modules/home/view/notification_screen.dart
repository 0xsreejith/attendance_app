import 'package:attendance_app/app/modules/home/view/components/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]),
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const NotificationCard(
            icon: Icons.close,
            iconColor: Colors.red,
            title: 'Missed Punch',
            titleColor: Colors.red,
            message:
                'Missed Clock-in Detected. Please update your attendance or contact HR.',
          ),
          const NotificationCard(
            icon: Icons.alarm,
            iconColor: Colors.orange,
            title: 'Late Attendance',
            titleColor: Colors.orange,
            message:
                'You’re running late! Your clock-in time is beyond the scheduled shift start.',
          ),
          const NotificationCard(
            icon: Icons.calendar_today,
            iconColor: Colors.blue,
            title: 'Daily Summary',
            titleColor: Colors.blue,
            message:
                'Your attendance today: Clock-in at 9:12 AM, Clock-out at 6:05 PM. Total hours: 8.53',
          ),
          const NotificationCard(
            icon: Icons.check_circle,
            iconColor: Colors.green,
            title: 'Leave Approval',
            titleColor: Colors.green,
            message:
                'Your leave request for June 15 has been approved. Enjoy your day off!',
          ),
          const NotificationCard(
            icon: Icons.minimize,
            iconColor: Colors.red,
            title: 'Leave Rejection',
            titleColor: Colors.red,
            message:
                'Leave request declined. Please check with your manager for details.',
          ),
          const NotificationCard(
            icon: Icons.update,
            iconColor: Colors.lightBlue,
            title: 'Shift Update',
            titleColor: Colors.lightBlue,
            message:
                'Shift updated: New shift time is 10:00 AM – 7:00 PM, effective from June 14.',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Leave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

