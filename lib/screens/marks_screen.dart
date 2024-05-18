import 'package:clinic_test_app/widgets/back_ground_container.dart';
import 'package:clinic_test_app/widgets/custom_bottom_app_bar.dart';
import 'package:clinic_test_app/widgets/mark_card.dart';
import 'package:flutter/material.dart';

class MarksScreen extends StatelessWidget {
  const MarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('العلامات'),
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
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: MarkCard(),
              );
            } else if (index == 4) {
              return const SizedBox(height: 50);
            } else {
              return const MarkCard();
            }
          },
        ),
      ),
    );
  }
}
