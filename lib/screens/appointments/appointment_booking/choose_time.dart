import 'package:clinic_test_app/widgets/appointment_booking/chair_booking.dart';
import 'package:flutter/material.dart';

class ChooseTime extends StatelessWidget {
  const ChooseTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'الرجاء اختيار يوم الموعد',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        ChairBooking(),
      ],
    );
  }
}
