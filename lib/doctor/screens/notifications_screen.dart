import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';

import '../../common/core/utils/laravel_echo.dart';
import '../provider/get_all_available_assistants_provider.dart';
import '../widgets/cards/notification_data_card.dart';
import '../provider/init_screens_provider.dart';

import '../../common/core/enum/connection_enum.dart';
import '../../common/core/utils/app_constants.dart';
import '../../common/core/utils/app_services.dart';
import '../../common/widgets/back_ground_container.dart';
import '../../common/widgets/cards/notification_details_card.dart';
import '../../common/widgets/custom_bottom_app_bar.dart';
import '../../common/widgets/cards/notifications_card.dart';
import '../../common/widgets/show_messages/show_success_message.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late InitScreensProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = Provider.of<InitScreensProvider>(context, listen: false);
  }

  void listenNotificationChannel(int userId) {
    LaravelEcho.instance
        .private('App.User.$userId')
        .listen('.notification.sent', (e) {
      if (e is PusherEvent) {
        if (e.data != null) {
          _handleNewNotification(jsonDecode(e.data!));
        }
      }
    }).error((err) {
      print(err);
    });
  }

  void leaveNotificationChannel(int userId) {
    try {
      LaravelEcho.instance.leave('App.User.$userId');
    } catch (err) {
      print(err);
    }
  }

  void _handleNewNotification(Map<String, dynamic> data) {
    _userProvider.addNotification(data);
  }

  @override
  void dispose() {
    leaveNotificationChannel(_userProvider.user!.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listenNotificationChannel(_userProvider.user!.id);
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
        child: Consumer<InitScreensProvider>(
          builder: (context, provider, child) {
            if (provider.connection == ConnectionEnum.connected) {
              if (provider.notifications!.isEmpty) {
                return const Center(
                  child: Text(
                    "لاتوجد اشعارات حتى الان",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'ElMessiri',
                        fontWeight: FontWeight.bold),
                  ),
                );
              }

              return ListView.separated(
                itemCount: provider.notifications!.length,
                itemBuilder: (context, index) {
                  final notification = provider.notifications![index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: NotificationCard(
                      backgroundImage: notification.data.user.photo != null
                          ? NetworkImage(
                                  '$kIMAGEBASEURL${notification.data.user.photo}')
                              as ImageProvider<Object>
                          : const AssetImage('assets/images/avatar.png')
                              as ImageProvider<Object>,
                      date: utcToLocal(notification.createdAt),
                      message: notification.data.message,
                      isNotRead: notification.readAt == null,
                      onTap: () {
                        Provider.of<GetAllAvailableAssistantsProvider>(
                          context,
                          listen: false,
                        ).getAllAvailableAssistants(
                            notification.data.processId);
                        showDialog(
                          useSafeArea: true,
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            alignment: Alignment.center,
                            insetPadding: EdgeInsets.zero,
                            child: SingleChildScrollView(
                              child: NotificationDetailsCard(
                                data: NotificationDataCard(
                                    notification: notification),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.blue,
                  indent: 30,
                  endIndent: 30,
                ),
              );
            } else if (provider.connection == ConnectionEnum.failed) {
              return Center(child: Text(provider.errorMessage ?? 'Error'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
