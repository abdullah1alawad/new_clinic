import '../../common/widgets/back_ground_container.dart';
import '../../common/widgets/cards/notification_details_card.dart';
import '../../common/widgets/custom_bottom_app_bar.dart';
import '../../common/widgets/cards/notifications_card.dart';
import '../../common/widgets/show_messages/show_success_message.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات'),
        bottom: const CustomBottonAppBar(),
        actions: [
          IconButton(
            onPressed: () {
              ShowSuccessMessage.showMessage(
                context,
                "تم تعليم الكل ك مقروء",
              );
            },
            icon: const Icon(
              EvaIcons.doneAll,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: BackGroundContainer(
        child: ListView.separated(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8),
            child: NotificationCard(
              photo: "assets/images/avatar.png",
              date: "10:10",
              message: "لقد وافق الدكتور فلان على حجز الموعد.",
              isNotRead: index & 1 == 0,
              onTap: () {
                showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) => const Dialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    alignment: Alignment.center,
                    insetPadding: EdgeInsets.zero,
                    child: SingleChildScrollView(
                      child: NotificationDetailsCard(
                        data: Text("لقد وافق الدكتور فلان على حجز الموعد."),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          separatorBuilder: (context, index) => const Divider(
            color: Colors.blue,
            indent: 30,
            endIndent: 30,
          ),
          itemCount: 10,
        ),
      ),
    );
  }
}
