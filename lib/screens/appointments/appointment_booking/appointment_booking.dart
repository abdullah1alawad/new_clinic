import 'package:clinic_test_app/provider/appointment_booking/appointment_booking_screens_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/chairs_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/clinic_info_provider.dart';
import 'package:clinic_test_app/screens/appointments/appointment_booking/choose_clinic.dart';
import 'package:clinic_test_app/screens/appointments/appointment_booking/choose_doctor.dart';
import 'package:clinic_test_app/screens/appointments/appointment_booking/choose_subject.dart';
import 'package:clinic_test_app/screens/appointments/appointment_booking/choose_time.dart';
import 'package:clinic_test_app/screens/appointments/appointment_booking/patient_info.dart';
import 'package:clinic_test_app/widgets/custom_container.dart';
import 'package:clinic_test_app/widgets/show_messages/show_error_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentBookingScreen extends StatelessWidget {
  AppointmentBookingScreen({super.key});

  final List<Widget> _screens = [
    const ChooseClinic(),
    const ChooseSubject(),
    const ChooseDoctor(),
    const PatientInfo(),
    const ChooseTime(),
  ];

  final List<String> _buttonText = [
    "التالي",
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
    'السابق',
  ];

  @override
  Widget build(BuildContext context) {
    final screenProvider =
        Provider.of<AppointmentBookingScreensProvider>(context);
    final List<VoidCallback> onPress = [
      () {
        if (screenProvider.clinicId == -1) {
          ShowErrorMessage.showMessage(context, "لم يتم اختيار العيادة");
        } else {
          Provider.of<ClinicInfoProvider>(context, listen: false)
              .getClinicInfo(screenProvider.clinicId);
          screenProvider.nextScreen();
        }
      },
      () {
        if (screenProvider.subjectId == -1) {
          ShowErrorMessage.showMessage(context, "لم يتم اختيار المادة");
        } else {
          screenProvider.nextScreen();
        }
      },
      () {
        if (screenProvider.doctorId == -1) {
          ShowErrorMessage.showMessage(context, "لم يتم اختيار الدكتور");
        } else {
          Provider.of<ChairsProvider>(context, listen: false)
              .getChairs(screenProvider.doctorId, screenProvider.clinicId);
          screenProvider.nextScreen();
        }
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
