import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/provider/five_screen_provider.dart';
import 'package:clinic_test_app/widgets/cards/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedAppointments extends StatelessWidget {
  const CompletedAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FiveScreenProvider>(
      builder: (context, provider, child) {
        if (provider.connection == ConnectionEnum.connected) {
          return ListView.builder(
            itemCount: provider.completedAppointments!.length + 1,
            itemBuilder: (context, index) {
              if (index != provider.completedAppointments!.length) {
                return AppointmentCard(
                  subjectName:
                      provider.completedAppointments![index].subjectName,
                  doctorName: provider.completedAppointments![index].doctorName,
                  patientName:
                      provider.completedAppointments![index].patientName,
                  chairNumber:
                      provider.completedAppointments![index].chairNumber,
                  status: provider.completedAppointments![index].status,
                  date: provider.completedAppointments![index].date,
                  assistentName:
                      provider.completedAppointments![index].assistenName,
                  clinicName: provider.completedAppointments![index].clinicName,
                  id: provider.completedAppointments![index].id,
                  photo: provider.completedAppointments![index].photo,
                  mark: provider.completedAppointments![index].mark,
                  subprocess:
                      provider.completedAppointments![index].subprocesses,
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
