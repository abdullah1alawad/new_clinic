import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/provider/appointment_booking/appointment_booking_screens_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/clinic_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseSubject extends StatelessWidget {
  const ChooseSubject({super.key});

  @override
  Widget build(BuildContext context) {
    final clinicInfoProvider = Provider.of<ClinicInfoProvider>(context);
    final screenProvider =
        Provider.of<AppointmentBookingScreensProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'الرجاء اختيار المادة',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          clinicInfoProvider.connection == ConnectionEnum.connected
              ? Column(
                  children: List.generate(clinicInfoProvider.subjects!.length,
                      (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          screenProvider.subjectId =
                              clinicInfoProvider.subjects![index].id;
                        },
                        style: ButtonStyle(
                          backgroundColor: clinicInfoProvider
                                      .subjects![index].id !=
                                  screenProvider.subjectId
                              ? WidgetStateProperty.all<Color>(Colors.blue)
                              : WidgetStateProperty.all<Color>(Colors.white70),
                          fixedSize: WidgetStateProperty.all<Size>(
                              const Size(250, 50)),
                        ),
                        child: Text(
                          clinicInfoProvider.subjects![index].name,
                          style: TextStyle(
                            color: clinicInfoProvider.subjects![index].id !=
                                    screenProvider.subjectId
                                ? Colors.white
                                : Colors.blue,
                            fontSize: 20,
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                )
              : clinicInfoProvider.connection == ConnectionEnum.failed
                  ? const Center(
                      child: Text('فشل الاتصال'),
                    )
                  : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
