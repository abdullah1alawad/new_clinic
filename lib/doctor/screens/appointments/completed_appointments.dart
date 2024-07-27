import '../../../common/core/enum/connection_enum.dart';

import '../../provider/init_screens_provider.dart';
import '../../widgets/cards/appointment_card.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedAppointments extends StatelessWidget {
  const CompletedAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InitScreensProvider>(
      builder: (context, provider, child) {
        if (provider.connection == ConnectionEnum.connected) {
          if (provider.completedAppointments!.isNotEmpty) {
            return ListView.builder(
              itemCount: provider.completedAppointments!.length + 1,
              itemBuilder: (context, index) {
                if (index != provider.completedAppointments!.length) {
                  return AppointmentCard(
                    appointment: provider.completedAppointments![index],
                    completed: true,
                    index: index,
                  );
                } else {
                  return const SizedBox(height: 50);
                }
              },
            );
          }

          return const Center(
            child: Text(
              "لاتوجد مواعيد حتى الان",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold),
            ),
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
