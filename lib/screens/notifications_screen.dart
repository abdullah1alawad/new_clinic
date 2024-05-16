import 'package:clinic_test_app/widgets/back_ground_container.dart';
import 'package:clinic_test_app/widgets/custom_bottom_app_bar.dart';
import 'package:clinic_test_app/widgets/notifications_card.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات'),
        bottom: const CustomBottonAppBar(),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تمت تعليم الكل ك مقروء',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  backgroundColor: Colors.green.shade400,
                  behavior: SnackBarBehavior.floating,
                  width: 200,
                  duration: Duration(milliseconds: 1000),
                  //showCloseIcon: true,
                ),
              );
            },
            icon: const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: BackGroundContainer(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            if (index != 4) {
              return const NotificationCard();
            } else {
              return const SizedBox(height: 50);
            }
          },
        ),
      ),
    );
  }
}
