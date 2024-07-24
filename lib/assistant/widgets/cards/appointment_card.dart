import '../../model/appointment_model.dart';
import '../../widgets/cards/appointment_details_card.dart';

import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final bool? cancelAppointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.cancelAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) => AppointmentDetailsCard(
            appointment: appointment,
            cancelAppointment: cancelAppointment,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        height: 190,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 165,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Theme.of(context).colorScheme.secondary,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 15),
                    blurRadius: 25,
                    color: Colors.black45,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appointment.subjectName,
                        style: const TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'اشراف الدكتور: ${appointment.doctorName}',
                        style: const TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 20,
                        ),
                      ),
                      // Text(
                      //   'المريض:  ${appointment.patientName}',
                      //   style: const TextStyle(
                      //     fontFamily: 'ElMessiri',
                      //     fontSize: 18,
                      //   ),
                      // ),
                      Text(
                        'الكرسي رقم: ${appointment.chairNumber}',
                        style: const TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'تاريخ الموعد:   :   ${appointment.date}',
                        style: const TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 20,
                        ),
                      ),
                      //Text('$mark'),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 0,
              child: Icon(
                appointment.status == 0
                    ? EvaIcons.closeCircle
                    : appointment.status == 1
                        ? EvaIcons.checkmarkCircle2
                        : appointment.status == 2
                            ? EvaIcons.alertCircle
                            : appointment.status == 3
                                ? Icons.run_circle_rounded
                                : Icons.download_done,
                color: appointment.status == 0
                    ? Colors.redAccent
                    : appointment.status == 1
                        ? Colors.green
                        : appointment.status == 2
                            ? Colors.orangeAccent
                            : appointment.status == 3
                                ? Colors.blue
                                : Colors.grey,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
