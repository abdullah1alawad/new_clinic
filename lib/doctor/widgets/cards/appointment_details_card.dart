import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinic_test_app/doctor/provider/decision/update_decision_provider.dart';
import 'package:search_page/search_page.dart';

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

class AppointmentDetailsCard extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentDetailsCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final updateDecision = Provider.of<UpdateDecisionProvider>(context);

    return Column(
      children: [
        CustomContainer(
          data: SingleChildScrollView(
            child: Consumer<GetAllAvailableAssistantsProvider>(
              builder: (context, provider, child) {
                if (provider.connection == ConnectionEnum.connected) {
                  return Column(
                    children: [
                      AutoSizeText(
                        "معلومات وتعديل الموعد",
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        provider.appointment!.subjectName,
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
                                  provider.appointment!.studentName,
                                  style: const TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontSize: 20,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showAssistantSearch(
                                        context, provider.assistants!);
                                  },
                                  child: Text(
                                    provider.appointment!.assistentName.isNotEmpty
                                        ? provider.appointment!.assistentName
                                        : updateDecision.assistantName.isNotEmpty
                                            ? updateDecision.assistantName
                                            : "إنقر لإختيار المساعد!",
                                    style: const TextStyle(
                                      fontFamily: 'ElMessiri',
                                      fontSize: 20,
                                      color: Colors.blue,
                                    ),
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
                                                  patientInfo: provider
                                                      .appointment!.patientInfo),
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
                                  provider.appointment!.clinicName,
                                  style: const TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '${provider.appointment!.chairNumber}',
                                  style: const TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  provider.appointment!.date,
                                  style: const TextStyle(
                                    fontFamily: 'ElMessiri',
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  provider.appointment!.status == 0
                                      ? 'مرفوضة'
                                      : provider.appointment!.status == 1
                                          ? 'مقبولة'
                                          : provider.appointment!.status == 2
                                              ? 'قيد الانتظار'
                                              : provider.appointment!.status == 3
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
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
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
                                  provider.appointment!.subprocesses.length,
                                  (index) {
                                    return TableRow(
                                      children: [
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              provider.appointment!
                                                  .subprocesses[index].name,
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
                                              '${provider.appointment!.subprocesses[index].mark}',
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
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
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
                                          '${provider.appointment!.mark}',
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
                        child: Image(
                            image: AssetImage('assets/images/avatar.png')),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                            onPressed: () async {
                              await updateDecision.updateDecision(
                                  appointment.id, 0);

                              if (updateDecision.connection ==
                                  ConnectionEnum.connected) {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  ShowSuccessMessage.showMessage(
                                      context, "تم رفض الموعد بنجاح");
                                }
                              } else if (updateDecision.connection ==
                                  ConnectionEnum.failed) {
                                if (context.mounted) {
                                  ShowErrorMessage.showMessage(
                                      context, updateDecision.errorMessage!);
                                }
                              }
                            },
                            child: updateDecision.connection ==
                                        ConnectionEnum.cunnecting &&
                                    updateDecision.button == 0
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                : Text("رفض",
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0)),
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () async {
                              if (updateDecision.assistantId == null) {
                                ShowErrorMessage.showMessage(
                                    context, "الرجاء اختيار المساعد!");
                                return;
                              }

                              await updateDecision.updateDecision(
                                  appointment.id, 1);

                              if (updateDecision.connection ==
                                  ConnectionEnum.connected) {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  ShowSuccessMessage.showMessage(
                                      context, "تم قبول الموعد بنجاح");
                                }
                              } else if (updateDecision.connection ==
                                  ConnectionEnum.failed) {
                                if (context.mounted) {
                                  ShowErrorMessage.showMessage(
                                      context, updateDecision.errorMessage!);
                                }
                              }
                            },
                            child: updateDecision.connection ==
                                        ConnectionEnum.cunnecting &&
                                    updateDecision.button == 1
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text("قبول",
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (provider.connection == ConnectionEnum.failed) {
                  return Center(child: Text(provider.errorMessage ?? 'Error'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
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

  void showAssistantSearch(BuildContext context, List<UserModel> users) {
    showSearch(
      context: context,
      delegate: SearchPage<UserModel>(
        items: users,
        searchLabel: 'إبحث عن مساعد ....',
        suggestion: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => ListTile(
            leading: users[index].photo == null
                ? const Icon(Icons.account_circle, size: 50.0)
                : CircleAvatar(
                    backgroundImage:
                        NetworkImage('$kIMAGEBASEURL${users[index].photo}'),
                    radius: 23,
                  ),
            title: Text(users[index].name),
            subtitle: Text(users[index].email),
            onTap: () {
              Provider.of<UpdateDecisionProvider>(context, listen: false)
                  .choose(users[index]);
              Navigator.of(context).pop();
            },
          ),
        ),
        failure: Center(
          child: Text(
            'لايوجد مساعد بهذا الاسم :(',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black54),
          ),
        ),
        filter: (user) => [user.name],
        builder: (user) => ListTile(
          leading: user.photo == null
              ? const Icon(Icons.account_circle, size: 50.0)
              : CircleAvatar(
                  backgroundImage: NetworkImage('$kIMAGEBASEURL${user.photo}'),
                  radius: 23,
                ),
          title: Text(user.name),
          subtitle: Text(user.email),
          onTap: () {
            Provider.of<UpdateDecisionProvider>(context, listen: false)
                .choose(user);
            Navigator.of(context).pop();
          },
        ),
        searchStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}
