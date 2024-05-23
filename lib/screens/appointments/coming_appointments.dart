import 'package:clinic_test_app/widgets/cards/appointment_card.dart';
import 'package:flutter/material.dart';

class ComingAppointments extends StatelessWidget {
  const ComingAppointments({super.key});

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
