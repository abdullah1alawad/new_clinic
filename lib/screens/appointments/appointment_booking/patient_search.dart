import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/provider/appointment_booking/appointment_booking_screens_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/clinic_info_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/patient_search_provider.dart';
import 'package:clinic_test_app/widgets/custom_container.dart';
import 'package:clinic_test_app/widgets/custom_text_field.dart';
import 'package:clinic_test_app/widgets/show_messages/show_error_message.dart';
import 'package:clinic_test_app/widgets/show_messages/show_success_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientSearch extends StatelessWidget {
  const PatientSearch({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final patientSearchProvider = Provider.of<PatientSearchProvider>(context);
    final screenProvider =
        Provider.of<AppointmentBookingScreensProvider>(context);
    final clinicProvider = Provider.of<ClinicInfoProvider>(context);

    return Column(
      children: [
        CustomContainer(
          data: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                "ابحث عن مريض ادخلته من قبل",
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
              ),
              CustomTextField(
                label: "الرقم الوطني",
                icon: Icons.person,
                controller: patientSearchProvider.dataController,
                validator: (val) {
                  return null;
                },
                obscureText: false,
              ),
              // SizedBox(
              //   height: 20,
              // )
            ],
          ),
          icon: Icons.search,
          onPressButton: () async {
            // if (patientSearchProvider.dataController.text.isEmpty) {
            //   ShowErrorMessage.showMessage(
            //       context, "الرجاء ادخال الرقم الوطني");
            //   return;
            // }

            await patientSearchProvider
                .searchForPatient(screenProvider.clinicId);

            if (patientSearchProvider.connection == ConnectionEnum.connected) {
              if (context.mounted) {
                clinicProvider.updateAnswer(patientSearchProvider.patientInfo!);
                Navigator.of(context).pop();
                ShowSuccessMessage.showMessage(
                    context, "الرجاء التاكد من معلومات المريض");
              }
            } else if (patientSearchProvider.connection ==
                ConnectionEnum.failed) {
              if (context.mounted) {
                ShowErrorMessage.showMessage(
                    context, patientSearchProvider.errorMessage!);
              }
            }
          },
          secondOnPreesButton: () {
            Navigator.of(context).pop();
          },
          buttonText: "إبحث",
          secondButtonText: "إلغاء",
          height: screenHeight * 0.50,
          loading:
              patientSearchProvider.connection == ConnectionEnum.cunnecting,
        )
      ],
    );
  }
}
