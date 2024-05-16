import 'package:clinic_test_app/widgets/appointment_card.dart';
import 'package:flutter/material.dart';

class CompletedAppointments extends StatelessWidget {
  const CompletedAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        if (index != 4) {
          return const AppointmentCard();
        } else {
          return const SizedBox(height: 50);
        }
      },
    );
  }
}
