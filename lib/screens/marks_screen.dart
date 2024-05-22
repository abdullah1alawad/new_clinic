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
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.filter_list,
            color: Colors.white,
            size: 35,
          ),
        ),
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
