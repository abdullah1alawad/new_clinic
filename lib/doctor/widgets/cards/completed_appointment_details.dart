import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinic_test_app/doctor/provider/marks/add_mark_provider.dart';
import 'package:clinic_test_app/doctor/provider/marks/delete_mark_provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import '../../../common/core/utils/app_constants.dart';
import '../../../common/model/user_model.dart';
import '../../model/appointment_model.dart';
import '../../provider/cancel_appointment_provider.dart';
import '../../provider/get_all_available_assistants_provider.dart';
import '../../provider/init_screens_provider.dart';

import '../../../common/core/enum/connection_enum.dart';
import '../../../common/widgets/cards/patient_info_card.dart';
import '../../../common/widgets/custom_container.dart';
import '../../../common/widgets/show_messages/show_error_message.dart';
import '../../../common/widgets/show_messages/show_success_message.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedAppointmentDetails extends StatelessWidget {
  final AppointmentModel appointment;
  final int? index;

  const CompletedAppointmentDetails({
    super.key,
    required this.appointment,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final markProvider = Provider.of<AddMarkProvider>(context);
    final deleteMarkProvider = Provider.of<DeleteMarkProvider>(context);
    final appointmentProvider = Provider.of<InitScreensProvider>(context);
    int totalMark = 0;

    return Column(
      children: [
        CustomContainer(
          data: SingleChildScrollView(
            child: Column(
              children: [
                AutoSizeText(
                  "معلومات وتعديل الموعد",
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
                Row(
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
                          appointment.studentName,
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
                        totalMark += appointment.subprocesses[index].mark;
                        return TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await deleteMarkProvider.deleteMark(
                                            appointment.subprocesses[index].id);

                                        if (deleteMarkProvider.connection ==
                                            ConnectionEnum.connected) {
                                          appointmentProvider.deleteMark(
                                              this.index!,
                                              appointment
                                                  .subprocesses[index].id);
                                        } else if (deleteMarkProvider
                                                .connection ==
                                            ConnectionEnum.failed) {
                                          ShowErrorMessage.showMessage(context,
                                              deleteMarkProvider.errorMessage!);
                                        }
                                      },
                                      icon: const Icon(
                                        EvaIcons.closeCircle,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      appointment.subprocesses[index].name,
                                      style: const TextStyle(
                                        fontFamily: 'ElMessiri',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
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
                    TableRow(
                      children: [
                        TableCell(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "اكتب هنا",
                              contentPadding: EdgeInsets.only(right: 35),
                            ),
                            controller: markProvider.name,
                          ),
                        ),
                        TableCell(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "اكتب هنا",
                              contentPadding: EdgeInsets.only(right: 35),
                            ),
                            controller: markProvider.mark,
                          ),
                        ),
                      ],
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
                              '$totalMark',
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    if (markProvider.name.text.isEmpty ||
                        markProvider.mark.text.isEmpty) {
                      ShowErrorMessage.showMessage(
                          context, "الرجاء ادخال الوصف والعلامة");

                      return;
                    }

                    await markProvider.addMark(appointment.id);

                    if (markProvider.connection == ConnectionEnum.connected) {
                      appointmentProvider.addMark(
                          index!, markProvider.subprocess!);
                    } else if (markProvider.connection ==
                        ConnectionEnum.failed) {
                      if (context.mounted) {
                        ShowErrorMessage.showMessage(
                            context, markProvider.errorMessage!);
                      }
                    }
                  },
                  child: markProvider.connection == ConnectionEnum.cunnecting
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text("إضافة العلامة",
                          style: Theme.of(context).textTheme.titleSmall),
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
