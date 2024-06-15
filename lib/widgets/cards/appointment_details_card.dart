import 'package:clinic_test_app/model/appointment_model.dart';
import 'package:clinic_test_app/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsCard extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentDetailsCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          data: Column(
            children: [
              Text(
                appointment.subjectName,
                style: const TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 22,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اشراف :',
                        style: TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'المحضر :',
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
                      Text(
                        appointment.patientName,
                        style: const TextStyle(
                          fontFamily: 'ElMessiri',
                          fontSize: 20,
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
              const SizedBox(height: 20),
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
            ],
          ),
          icon: Icons.menu_book_sharp,
          onPressButton: () {
            Navigator.of(context).pop();
          },
          buttonText: "تم",
          cancel: false,
          loading: false,
          height: 750,
        ),
      ],
    );
  }
}
