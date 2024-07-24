import '../../../../common/core/enum/connection_enum.dart';
import '../../../../common/core/utils/app_constants.dart';
import '../../../../common/widgets/custom_container.dart';
import '../../../../common/widgets/show_messages/show_error_message.dart';
import '../../../../common/widgets/show_messages/show_success_message.dart';

import '../../../model/question_model.dart';
import '../../../provider/appointment_booking/appointment_booking_provider.dart';
import '../../../provider/appointment_booking/appointment_booking_screens_provider.dart';
import '../../../provider/appointment_booking/chairs_provider.dart';
import '../../../provider/appointment_booking/clinic_info_provider.dart';
import '../../../provider/five_screen_provider.dart';
import '../../../screens/appointments/appointment_booking/choose_clinic.dart';
import '../../../screens/appointments/appointment_booking/choose_doctor.dart';
import '../../../screens/appointments/appointment_booking/choose_subject.dart';
import '../../../screens/appointments/appointment_booking/choose_time.dart';
import '../../../screens/appointments/appointment_booking/patient_info.dart';
import '../../../screens/appointments/appointment_booking/patient_search.dart';

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
    final bookAppointmentProvider =
        Provider.of<AppointmentBookingProvider>(context);
    final clinicInfoProvider = Provider.of<ClinicInfoProvider>(context);
    final appointmentProvider = Provider.of<FiveScreenProvider>(context);

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
        if (validate(clinicInfoProvider.questions!)) {
          screenProvider.nextScreen();
        } else {
          ShowErrorMessage.showMessage(
              context, "الرجاء الاجابة على كل الاسئلة");
        }
      },
      () async {
        if (screenProvider.time.isEmpty) {
          ShowErrorMessage.showMessage(context, "لم يتم اختيار الوقت");
        } else {
          await bookAppointmentProvider.bookAppointment(
            screenProvider.clinicId,
            screenProvider.doctorId,
            screenProvider.subjectId,
            '${screenProvider.day} ${screenProvider.time}',
            clinicInfoProvider.questions == null
                ? [{}]
                : getAnswer(clinicInfoProvider.questions!),
          );

          if (bookAppointmentProvider.connecion == ConnectionEnum.connected) {
            if (context.mounted) {
              appointmentProvider
                  .addAppointment(bookAppointmentProvider.appointment!);
              Navigator.of(context).pop();
              ShowSuccessMessage.showMessage(context, "تم حجز الموعد بنجاح");
            }
          } else if (bookAppointmentProvider.connecion ==
              ConnectionEnum.failed) {
            if (context.mounted) {
              ShowErrorMessage.showMessage(
                  context, bookAppointmentProvider.errorMessage!);
            }
          }
        }
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

    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        CustomContainer(
          data: _screens[screenProvider.screenNumber],
          icon: Icons.chair,
          onPressButton: onPress[screenProvider.screenNumber],
          buttonText: _buttonText[screenProvider.screenNumber],
          secondOnPreesButton: secOnPress[screenProvider.screenNumber],
          secondButtonText: _secButtonText[screenProvider.screenNumber],
          height: screenHeight * 0.87,
          loading: screenProvider.screenNumber != 4
              ? false
              : bookAppointmentProvider.connecion == ConnectionEnum.cunnecting,
        ),
        if (screenProvider.screenNumber == 3)
          Positioned(
            top: 40,
            right: 40,
            child: IconButton(
              icon: const Icon(Icons.search),
              color: Theme.of(context).colorScheme.secondary,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary),
              ),
              onPressed: () {
                showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) => const Dialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    alignment: Alignment.center,
                    insetPadding: EdgeInsets.zero,
                    child: SingleChildScrollView(
                      child: PatientSearch(),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  List<Map<String, dynamic>> getAnswer(List<QuestionsModel> question) {
    List<Map<String, dynamic>> ret = [];

    for (int i = 0; i < question.length; i++) {
      ret.add({
        kID: question[i].id,
        kANSWER: question[i].answer.text,
      });
    }

    return ret;
  }

  bool validate(List<QuestionsModel> question) {
    for (int i = 0; i < question.length; i++) {
      if (question[i].answer.text.isEmpty) {
        return false;
      }
    }

    return true;
  }
}
