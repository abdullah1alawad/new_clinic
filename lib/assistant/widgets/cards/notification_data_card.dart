import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/cards/patient_info_card.dart';
import '../../../common/widgets/custom_container.dart';

import '../../model/appointment_model.dart';
import '../../model/notification/notification_model.dart';

class NotificationDataCard extends StatelessWidget {
  final NotificationModel notification;
  final AppointmentModel appointment;
  const NotificationDataCard({
    super.key,
    required this.notification,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AutoSizeText(
            notification.data.message,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
          ),
          const SizedBox(height: 20),
          Text(
            appointment.subjectName,
            style: const TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 22,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الطالب :',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'المساعد :',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'المريض :',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'العيادة :',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'الكرسي :',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'تاريخ الموعد : ',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'حالة الموعد :',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      appointment.assistentName,
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          useSafeArea: true,
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            alignment: Alignment.center,
                            insetPadding: EdgeInsets.zero,
                            child: Column(
                              children: [
                                CustomContainer(
                                  data: PatientInfo(
                                      patientInfo: appointment.patientInfo),
                                  icon: Icons.person,
                                  onPressButton: () {
                                    Navigator.of(context).pop();
                                  },
                                  buttonText: 'تم',
                                  loading: false,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'انقر للمزيد',
                        style: TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Text(
                      appointment.clinicName,
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${appointment.chairNumber}',
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      appointment.date,
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      appointment.status == 0
                          ? 'مرفوضة'
                          : appointment.status == 1
                              ? 'مقبولة'
                              : appointment.status == 2
                                  ? 'قيد الانتظار'
                                  : appointment.status == 3
                                      ? 'جارية'
                                      : 'منتهية',
                      style: const TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (appointment.mark != null)
            Column(
              children: [
                const Text(
                  'العلامات الجزئية',
                  style: TextStyle(
                    fontFamily: 'ElMessiri',
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Table(
                  border: TableBorder.all(color: Colors.black),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    const TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              'الوصف',
                              style: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              'العلامة',
                              style: TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...List.generate(
                      appointment.subprocesses.length,
                      (index) {
                        return TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                child: Text(
                                  appointment.subprocesses[index].name,
                                  style: const TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Text(
                                  '${appointment.subprocesses[index].mark}',
                                  style: const TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                Table(
                  border: TableBorder.all(color: Colors.black),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        const TableCell(
                          child: Center(
                            child: Text(
                              'العلامة النهائية',
                              style: TextStyle(
                                  fontFamily: 'ElMessiri',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              '${appointment.mark}',
                              style: const TextStyle(
                                  fontFamily: 'ElMessiri',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          const Text(
            'صورة الحالة  :',
            style: TextStyle(
              fontFamily: 'ElMessiri',
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 200,
            width: 200,
            child: Image(image: AssetImage('assets/images/avatar.png')),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
