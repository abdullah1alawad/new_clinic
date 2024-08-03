import 'dart:convert';

import 'package:clinic_test_app/common/core/utils/app_services.dart';
import 'package:clinic_test_app/common/provider/chat/make_chat_read_provider.dart';
import 'package:pusher_client/pusher_client.dart';

import '../../common/core/enum/connection_enum.dart';
import '../../common/cache/cache_helper.dart';
import '../../common/core/utils/app_constants.dart';
import '../../common/core/utils/laravel_echo.dart';

import '../../common/model/chat/message_model.dart';
import '../../common/provider/chat/get_chat_messages_provider.dart';
import '../../common/provider/chat/get_many_chats_provider.dart';
import '../provider/init_screens_provider.dart';
import '../../common/provider/get_all_users_provider.dart';

import '../screens/appointments/appointments.dart';
import '../../common/screens/chats/chats_list.dart';
import '../screens/notifications_screen.dart';
import '../screens/profile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedScreen = 2;
  late InitScreensProvider _userProvider;
  late GetChatMessagesProvider _selectedChatProvider;
  late GetManyChatsProvider _chatsProvider;
  late MakeChatReadProvider _chatReadProvider;

  List<Widget> _screens = [
    const ProfileScreen(),
    const NotificationsScreen(),
    const AppointmentsScreen(),
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await Provider.of<InitScreensProvider>(context, listen: false)
            .getInitScreens();

        await Provider.of<GetManyChatsProvider>(context, listen: false)
            .getManyChats();
        Provider.of<GetAllUsersProvider>(context, listen: false).getAllUser();
        LaravelEcho.init(token: CacheHelper().getData(key: kTOKEN));

        _screens.add(
          ChatsListScreen(
              chatUser: Provider.of<InitScreensProvider>(context, listen: false)
                  .user!
                  .toChatUser),
        );

        _chatReadProvider =
            Provider.of<MakeChatReadProvider>(context, listen: false);

        _userProvider =
            Provider.of<InitScreensProvider>(context, listen: false);
        listenNotificationChannel(_userProvider.user!.id);

        _selectedChatProvider =
            Provider.of<GetChatMessagesProvider>(context, listen: false);
        _chatsProvider =
            Provider.of<GetManyChatsProvider>(context, listen: false);

        for (int i = 0; i < _chatsProvider.chats!.length; i++) {
          LaravelEcho.instance
              .private('chat.${_chatsProvider.chats![i].id}')
              .listen('.message.sent', (e) {
            if (e is PusherEvent) {
              if (e.data != null) {
                _handleNewMessage(jsonDecode(e.data!));
              }
            }
          }).error((err) {
            print(err);
          });
        }
      },
    );
  }

  void _handleNewMessage(Map<String, dynamic> data) {
    if (_selectedChatProvider.chat != null &&
        _selectedChatProvider.chat!.id == data['chat_id']) {
      final chatMessage = MessageModel.fromJson(data);
      _selectedChatProvider.addMessage(chatMessage);
      _chatsProvider.makeItRead(data['chat_id']);
      _chatReadProvider.makeChatRead(data['chat_id']);
    } else {
      showNotification(context, false);
    }

    _chatsProvider.updateLastMessage(data['chat_id'], data);
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

  void _handleNewNotification(Map<String, dynamic> data) {
    _userProvider.addNotification(data);
    showNotification(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Center(child: _screens[_selectedScreen]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedScreen,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.white,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'الملف الشخصي',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                const Icon(Icons.notifications),
                if (Provider.of<InitScreensProvider>(context).unReadNotify != 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '${Provider.of<InitScreensProvider>(context, listen: false).unReadNotify}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
            label: 'الاشعارات',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
            ),
            label: 'المواعيد',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                const Icon(Icons.email),
                if (Provider.of<GetManyChatsProvider>(context).unRead != 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '${Provider.of<GetManyChatsProvider>(context, listen: false).unRead}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
            label: 'المحادثة',
          ),
        ],
      ),
    );
  }
}
