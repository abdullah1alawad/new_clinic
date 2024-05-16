import 'package:clinic_test_app/widgets/back_ground_container.dart';
import 'package:clinic_test_app/widgets/custom_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            color: Colors.white,
          )
        ],
        bottom: const CustomBottonAppBar(),
      ),
      body: BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundColor: Theme.of(context).colorScheme.background,
              backgroundImage: AssetImage('assets/images/avatar.png'),
              //child: Image.asset('assets/images/avatar.png'),
            ),
            const SizedBox(width: double.infinity, height: 20),
            Text(
              "محمد نور الخطيب",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              width: 300,
              height: 40,
              child: Divider(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
