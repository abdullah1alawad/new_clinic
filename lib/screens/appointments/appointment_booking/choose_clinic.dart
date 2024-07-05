import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/provider/appointment_booking/appointment_booking_screens_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/clinics_provider.dart';
import 'package:clinic_test_app/widgets/appointment_booking/clinic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseClinic extends StatelessWidget {
  const ChooseClinic({super.key});

  @override
  Widget build(BuildContext context) {
    final clinicsProvider = Provider.of<ClinicsProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'اختر العيادة المطلوبة للموعد',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          if (clinicsProvider.connection == ConnectionEnum.connected)
            gridBuild(context),
          if (clinicsProvider.connection == ConnectionEnum.cunnecting)
            const Center(child: CircularProgressIndicator()),
          if (clinicsProvider.connection == ConnectionEnum.failed)
            Center(child: Text(clinicsProvider.errorMessage ?? 'Error')),
        ],
      ),
    );
  }

  Widget gridBuild(BuildContext context) {
    final clinicsProvider = Provider.of<ClinicsProvider>(context);
    final screenProvider =
        Provider.of<AppointmentBookingScreensProvider>(context);

    int size = clinicsProvider.clinics!.length;
    int half = (size ~/ 2);
    List<Widget> firstHalf = [];
    List<Widget> secondHalf = [];

    for (int i = half; i < size; i++) {
      firstHalf.add(
        GestureDetector(
          onTap: () {
            screenProvider.clinicId = clinicsProvider.clinics![i].id;
          },
          child: Clinic(
            clinicName: clinicsProvider.clinics![i].name,
            imageUrl: 'assets/images/clinic2.jpg',
            isChosen: screenProvider.clinicId == clinicsProvider.clinics![i].id,
          ),
        ),
      );
      firstHalf.add(const SizedBox(height: 10));
    }

    for (int i = 0; i < half; i++) {
      secondHalf.add(
        GestureDetector(
          onTap: () {
            screenProvider.clinicId = clinicsProvider.clinics![i].id;
          },
          child: Clinic(
            clinicName: clinicsProvider.clinics![i].name,
            imageUrl: 'assets/images/clinic2.jpg',
            isChosen: screenProvider.clinicId == clinicsProvider.clinics![i].id,
          ),
        ),
      );
      secondHalf.add(const SizedBox(height: 10));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: firstHalf,
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: secondHalf,
        ),
      ],
    );
  }
}
