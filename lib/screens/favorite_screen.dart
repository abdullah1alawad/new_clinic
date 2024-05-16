import 'package:clinic_test_app/widgets/appointment_card.dart';
import 'package:clinic_test_app/widgets/back_ground_container.dart';
import 'package:clinic_test_app/widgets/custom_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
        bottom: const CustomBottonAppBar(),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تمت إزالة جميع المفضلات',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  backgroundColor: Colors.green.shade400,
                  behavior: SnackBarBehavior.floating,
                  width: 210,
                  duration: Duration(milliseconds: 1000),
                  //showCloseIcon: true,
                ),
              );
            },
            icon: const Icon(
              Icons.highlight_remove,
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
              return const AppointmentCard();
            } else {
              return const SizedBox(height: 50);
            }
          },
        ),
      ),
    );
  }
}
