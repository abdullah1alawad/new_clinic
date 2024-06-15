import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/provider/five_screen_provider.dart';
import 'package:clinic_test_app/widgets/cards/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComingAppointments extends StatelessWidget {
  const ComingAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FiveScreenProvider>(
      builder: (context, provider, child) {
        if (provider.connection == ConnectionEnum.connected) {
          return ListView.builder(
            itemCount: provider.comingAppointments!.length + 1,
            itemBuilder: (context, index) {
              if (index != provider.comingAppointments!.length) {
                return AppointmentCard(
                  appointment: provider.comingAppointments![index],
                );
              } else {
                return const SizedBox(height: 50);
              }
            },
          );
        } else if (provider.connection == ConnectionEnum.failed) {
          return Center(child: Text(provider.errorMessage ?? 'Error'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
