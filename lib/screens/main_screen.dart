import 'package:clinic_test_app/provider/chat/get_many_chats_provider.dart';
import 'package:clinic_test_app/provider/five_screen_provider.dart';
import 'package:clinic_test_app/provider/get_all_users_provider.dart';
import 'package:clinic_test_app/screens/appointments/appointments.dart';
import 'package:clinic_test_app/screens/chats/chats_list.dart';
import 'package:clinic_test_app/screens/marks_screen.dart';
import 'package:clinic_test_app/screens/notifications_screen.dart';
import 'package:clinic_test_app/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedScreen = 2;

  final List<Widget> _screens = [
    const ProfileScreen(),
    const NotificationsScreen(),
    const AppointmentsScreen(),
    const ChatsListScreen(),
    const MarksScreen(),
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FiveScreenProvider>(context, listen: false).getFiveScreen();
      Provider.of<GetManyChatsProvider>(context, listen: false).getManyChats();
      Provider.of<GetAllUsersProvider>(context, listen: false).getAllUser();
    });
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
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '7',
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
            ),
            label: 'المواعيد',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: <Widget>[
                Icon(Icons.email),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '5',
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
            label: 'المحادثة',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.my_library_books,
              //size: 25,
            ),
            label: 'العلامات',
          ),
        ],
      ),
    );
  }
}
