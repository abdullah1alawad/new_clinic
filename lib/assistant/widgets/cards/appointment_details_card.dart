import '../../model/appointment_model.dart';
import '../../provider/init_screens_provider.dart';

import '../../../common/core/enum/connection_enum.dart';
import '../../../common/widgets/cards/patient_info_card.dart';
import '../../../common/widgets/custom_container.dart';
import '../../../common/widgets/show_messages/show_error_message.dart';
import '../../../common/widgets/show_messages/show_success_message.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentDetailsCard extends StatelessWidget {
  final AppointmentModel appointment;
  final bool? cancelAppointment;

  const AppointmentDetailsCard({
    super.key,
    required this.appointment,
    this.cancelAppointment,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final appointmentProvider = Provider.of<InitScreensProvider>(context);

    return Column(
      children: [
        CustomContainer(
          data: SingleChildScrollView(
            child: Column(
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      //height: screenHeight * 0.87,
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
                          // const Icon(
                          //   Icons.read_more,
                          //   textDirection: TextDirection.ltr,
                          // ),
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
                const SizedBox(height: 20),
              ],
            ),
          ),
          icon: Icons.menu_book_sharp,
          onPressButton: () {
            Navigator.of(context).pop();
          },
          buttonText: "تم",
          loading: false,
          height: screenHeight * 0.89,
        ),
      ],
    );
  }
}
