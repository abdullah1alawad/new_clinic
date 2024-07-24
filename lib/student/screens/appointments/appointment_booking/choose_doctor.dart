import '../../../provider/appointment_booking/appointment_booking_screens_provider.dart';
import '../../../provider/appointment_booking/clinic_info_provider.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseDoctor extends StatelessWidget {
  const ChooseDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    final clinicInfoProvider = Provider.of<ClinicInfoProvider>(context);
    final screenProvider =
        Provider.of<AppointmentBookingScreensProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          AutoSizeText(
            'الرجاء اختيار الدكتور المشرف',
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
          ),
          const SizedBox(height: 20),
          ...List.generate(clinicInfoProvider.doctors!.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  screenProvider.doctorId =
                      clinicInfoProvider.doctors![index].id;
                },
                style: ButtonStyle(
                  backgroundColor: clinicInfoProvider.doctors![index].id !=
                          screenProvider.doctorId
                      ? WidgetStateProperty.all<Color>(Colors.blue)
                      : WidgetStateProperty.all<Color>(Colors.white70),
                  fixedSize: WidgetStateProperty.all<Size>(const Size(250, 50)),
                ),
                child: Text(
                  clinicInfoProvider.doctors![index].name,
                  style: TextStyle(
                    color: clinicInfoProvider.doctors![index].id !=
                            screenProvider.doctorId
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
        ],
      ),
    );
  }
}
