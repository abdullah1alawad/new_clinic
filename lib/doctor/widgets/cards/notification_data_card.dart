import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';

import '../../../common/widgets/show_messages/show_error_message.dart';
import '../../../common/widgets/show_messages/show_success_message.dart';
import '../../../common/core/enum/connection_enum.dart';
import '../../../common/core/utils/app_constants.dart';
import '../../../common/model/user_model.dart';
import '../../../common/widgets/cards/patient_info_card.dart';
import '../../../common/widgets/custom_container.dart';

import '../../provider/decision/decision_provider.dart';
import '../../provider/get_all_available_assistants_provider.dart';
import '../../model/notification/notification_model.dart';

class NotificationDataCard extends StatelessWidget {
  final NotificationModel notification;
  const NotificationDataCard({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final decisionProvider = Provider.of<DecisionProvider>(context);

    return SingleChildScrollView(
      child: Consumer<GetAllAvailableAssistantsProvider>(
        builder: (context, provider, child) {
          if (provider.connection == ConnectionEnum.connected) {
            return Column(
              children: [
                AutoSizeText(
                  notification.data.cause == kBOOKREQUEST
                      ? "طلب حجز موعد"
                      : "اشعار بالغاء موعد",
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
                          notification.data.cause == kBOOKREQUEST
                              ? GestureDetector(
                                  onTap: () {
                                    showAssistantSearch(
                                        context, provider.assistants!);
                                  },
                                  child: Text(
                                    decisionProvider.assistantName.isNotEmpty
                                        ? decisionProvider.assistantName
                                        : provider.appointment!.assistentName
                                                .isNotEmpty
                                            ? provider
                                                .appointment!.assistentName
                                            : "إنقر لإختيار المساعد!",
                                    style: const TextStyle(
                                      fontFamily: 'ElMessiri',
                                      fontSize: 20,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              : Text(
                                  provider.appointment!.assistentName,
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
                if (provider.appointment!.mark != null)
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
                  child: Image(image: AssetImage('assets/images/avatar.png')),
                ),
                const SizedBox(height: 20),
                if (notification.data.cause == kBOOKREQUEST)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () async {
                          await decisionProvider.decision(
                              notification.data.processId, 0);

                          if (decisionProvider.connection ==
                              ConnectionEnum.connected) {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ShowSuccessMessage.showMessage(
                                  context, "تم رفض الموعد بنجاح");
                            }
                          } else if (decisionProvider.connection ==
                              ConnectionEnum.failed) {
                            if (context.mounted) {
                              ShowErrorMessage.showMessage(
                                  context, decisionProvider.errorMessage!);
                            }
                          }
                        },
                        child: decisionProvider.connection ==
                                    ConnectionEnum.cunnecting &&
                                decisionProvider.button == 0
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : Text("رفض",
                                style: Theme.of(context).textTheme.titleSmall),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          if (decisionProvider.assistantId == null) {
                            ShowErrorMessage.showMessage(
                                context, "الرجاء اختيار المساعد!");
                            return;
                          }

                          await decisionProvider.decision(
                              notification.data.processId, 1);

                          if (decisionProvider.connection ==
                              ConnectionEnum.connected) {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              ShowSuccessMessage.showMessage(
                                  context, "تم قبول الموعد بنجاح");
                            }
                          } else if (decisionProvider.connection ==
                              ConnectionEnum.failed) {
                            if (context.mounted) {
                              ShowErrorMessage.showMessage(
                                  context, decisionProvider.errorMessage!);
                            }
                          }
                        },
                        child: decisionProvider.connection ==
                                    ConnectionEnum.cunnecting &&
                                decisionProvider.button == 1
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text("قبول",
                                style: Theme.of(context).textTheme.titleSmall),
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
              Provider.of<DecisionProvider>(context, listen: false)
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
            Provider.of<DecisionProvider>(context, listen: false).choose(user);
            Navigator.of(context).pop();
          },
        ),
        searchStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}
