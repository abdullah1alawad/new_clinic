import 'package:clinic_test_app/common/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class NotificationDetailsCard extends StatelessWidget {
  final Widget data;
  const NotificationDetailsCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        CustomContainer(
          data: SingleChildScrollView(
            child: data,
          ),
          icon: Icons.notifications,
          onPressButton: () {
            Navigator.of(context).pop();
          },
          buttonText: "تم",
          height: screenHeight * 0.89,
          loading: false,
        ),
      ],
    );
  }
}
