import 'package:clinic_test_app/provider/appointment_booking_screens_provider.dart';
import 'package:clinic_test_app/screens/appointments/appointment_booking/choose_clinic.dart';
import 'package:clinic_test_app/screens/appointments/appointment_booking/choose_doctor.dart';
import 'package:clinic_test_app/screens/appointments/appointment_booking/choose_time.dart';
import 'package:clinic_test_app/screens/appointments/appointment_booking/patient_info.dart';
import 'package:clinic_test_app/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentBookingScreen extends StatelessWidget {
  AppointmentBookingScreen({super.key});

  final List<Widget> _screens = [
    const ChooseClinic(),
    const PatientInfo(),
    const ChooseDoctor(),
    const ChooseTime(),
  ];

  final List<String> _buttonText = [
    "التالي",
    "التالي",
    "التالي",
    "حجز الموعد",
  ];
  final List<String> _secButtonText = [
    'إلغاء',
    'السابق',
    'السابق',
    'السابق',
  ];

  @override
  Widget build(BuildContext context) {
    final screenProvider =
        Provider.of<AppointmentBookingScreensProvider>(context);
    final List<VoidCallback> onPress = [
      () {
        screenProvider.nextScreen();
      },
      () {
        screenProvider.nextScreen();
      },
      () {
        screenProvider.nextScreen();
      },
      () {
        Navigator.of(context).pop();
      }
    ];
    final List<VoidCallback> secOnPress = [
      () {
        Navigator.of(context).pop();
      },
      () {
        screenProvider.previousScreen();
      },
      () {
        screenProvider.previousScreen();
      },
      () {
        screenProvider.previousScreen();
      },
    ];

    return Column(
      children: [
        CustomContainer(
          data: _screens[screenProvider.screenNumber],
          icon: Icons.chair,
          onPressButton: onPress[screenProvider.screenNumber],
          buttonText: _buttonText[screenProvider.screenNumber],
          secondOnPreesButton: secOnPress[screenProvider.screenNumber],
          secondButtonText: _secButtonText[screenProvider.screenNumber],
          height: 750,
          loading: false,
        ),
      ],
    );
  }
}
