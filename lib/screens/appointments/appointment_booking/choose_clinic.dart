import 'package:clinic_test_app/widgets/appointment_booking/clinic.dart';
import 'package:flutter/material.dart';

class ChooseClinic extends StatelessWidget {
  const ChooseClinic({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'اختر العيادة المطلوبة للموعد',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 20),
        const Row(
          children: [
            Clinic(
                clinicName: 'قلع وتخدير',
                imageUrl: 'assets/images/clinic2.jpg'),
            SizedBox(width: 10),
            Clinic(
                clinicName: 'قلع وتخدير',
                imageUrl: 'assets/images/clinic2.jpg'),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Clinic(
              clinicName: 'قلع وتخدير',
              imageUrl: 'assets/images/clinic2.jpg',
            ),
            SizedBox(width: 10),
            Clinic(
              clinicName: 'قلع وتخدير',
              imageUrl: 'assets/images/clinic.jpg',
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Clinic(
              clinicName: 'قلع وتخدير',
              imageUrl: 'assets/images/clinic.jpg',
            ),
            SizedBox(width: 10),
            Clinic(
              clinicName: 'قلع وتخدير',
              imageUrl: 'assets/images/clinic.jpg',
            ),
          ],
        ),
      ],
    );
  }
}
