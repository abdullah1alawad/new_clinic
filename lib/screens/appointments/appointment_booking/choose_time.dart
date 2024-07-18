import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/provider/appointment_booking/chairs_provider.dart';
import 'package:clinic_test_app/widgets/appointment_booking/chair_booking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseTime extends StatelessWidget {
  const ChooseTime({super.key});

  @override
  Widget build(BuildContext context) {
    final chairsProvider = Provider.of<ChairsProvider>(context);
    return Column(
      children: [
        AutoSizeText(
          'الرجاء اختيار يوم الموعد',
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
        ),
        chairsProvider.connection == ConnectionEnum.connected
            ? ChairBooking(data: chairsProvider.data)
            : chairsProvider.connection == ConnectionEnum.failed
                ? const Center(
                    child: Text('فشل الاتصال'),
                  )
                : const CircularProgressIndicator(),
      ],
    );
  }
}
