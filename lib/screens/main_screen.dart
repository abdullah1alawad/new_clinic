import 'package:clinic_test_app/screens/appointments/appointments.dart';
import 'package:clinic_test_app/screens/marks_screen.dart';
import 'package:clinic_test_app/screens/notifications_screen.dart';
import 'package:clinic_test_app/screens/profile.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _selectScreen(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  int _selectedScreen = 2;

  final List<Widget> _screens = [
    const ProfileScreen(),
    const NotificationsScreen(),
    const AppointmentsScreen(),
    const Text('المحادثة'),
    const MarksScreen(),
  ];

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
        //selectedFontSize: 15,
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'الملف الشخصي',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
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
            icon: Icon(
              Icons.email,
            ),
            label: 'المحادثة',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.my_library_books,
              size: 25,
            ),
            label: 'العلامات',
          ),
        ],
      ),
    );
  }
}
