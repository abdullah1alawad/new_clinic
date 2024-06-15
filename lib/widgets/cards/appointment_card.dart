import 'package:clinic_test_app/model/subprocess_model.dart';
import 'package:clinic_test_app/widgets/cards/appointment_details_card.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class AppointmentCard extends StatelessWidget {
  final String subjectName,
      doctorName,
      patientName,
      assistentName,
      clinicName,
      date,
      photo;
  final int id, chairNumber, status;
  final int? mark;
  final List<SubprocessModel> subprocess;

  const AppointmentCard({
    super.key,
    required this.subjectName,
    required this.doctorName,
    required this.patientName,
    required this.assistentName,
    required this.clinicName,
    required this.date,
    required this.photo,
    required this.id,
    required this.chairNumber,
    required this.status,
    this.mark,
    required this.subprocess,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) => AppointmentDetailsCard(
            subjectName: subjectName,
            doctorName: doctorName,
            patientName: patientName,
            assistentName: assistentName,
            clinicName: clinicName,
            date: date,
            photo: photo,
            id: id,
            chairNumber: chairNumber,
            status: status,
            subprocess: subprocess,
            mark: mark,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subjectName,
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'اشراف الدكتورة: $doctorName',
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'المريض:  $patientName',
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'الكرسي رقم: $chairNumber',
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'تاريخ الموعد:   :   $date',
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
            Positioned(
              top: 12,
              left: 0,
              child: Icon(
                status == 0
                    ? EvaIcons.closeCircle
                    : status == 1
                        ? EvaIcons.checkmarkCircle2
                        : status == 2
                            ? EvaIcons.alertCircle
                            : status == 3
                                ? Icons.run_circle_rounded
                                : Icons.download_done,
                color: status == 0
                    ? Colors.redAccent
                    : status == 1
                        ? Colors.green
                        : status == 2
                            ? Colors.orangeAccent
                            : status == 3
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
