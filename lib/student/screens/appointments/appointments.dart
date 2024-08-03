import 'package:clinic_test_app/common/core/utils/app_services.dart';

import '../../provider/appointment_booking/clinics_provider.dart';
import '../../provider/appointment_booking/appointment_booking_screens_provider.dart';
import '../../provider/five_screen_provider.dart';
import '../../screens/appointments/appointment_booking/appointment_booking.dart';
import '../../screens/appointments/coming_appointments.dart';
import '../../screens/appointments/completed_appointments.dart';

import '../../../common/widgets/back_ground_container.dart';
import '../../../common/widgets/custom_container.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentBookingScreenProvider =
        Provider.of<AppointmentBookingScreensProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المواعيد'),
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.inversePrimary,
            indicatorColor: Theme.of(context).colorScheme.inversePrimary,
            unselectedLabelColor: Theme.of(context).colorScheme.secondary,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(
                child: AutoSizeText(
                  'المواعيد القادمة',
                  style: TextStyle(fontSize: 20),
                  maxLines: 1,
                ),
              ),
              Tab(
                child: AutoSizeText(
                  'المواعيد المكتملة',
                  style: TextStyle(fontSize: 20),
                  maxLines: 1,
                ),
              )
            ],
          ),
          // actions: [
          //   ElevatedButton(
          //     onPressed: () {
          //       showNotification(context, true);
          //       Provider.of<FiveScreenProvider>(context, listen: false).fun();
          //     },
          //     child: Icon(Icons.light_mode),
          //   )
          // ],
        ),
        body: const BackGroundContainer(
          child: TabBarView(
            children: [
              ComingAppointments(),
              CompletedAppointments(),
            ],
          ),
        ),
        floatingActionButton: ExpandableFab(
          type: ExpandableFabType.up,
          distance: 70,
          children: [
            Row(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Provider.of<ClinicsProvider>(context, listen: false)
                        .getClinics();
                    showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        alignment: Alignment.center,
                        insetPadding: EdgeInsets.zero,
                        child: SingleChildScrollView(
                            child: AppointmentBookingScreen()),
                      ),
                    ).then((value) {
                      appointmentBookingScreenProvider.reSet();
                    });
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  heroTag: null,
                  child: const Icon(Icons.chair),
                ),
                SizedBox(
                  width: 110,
                  height: 35,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Theme.of(context).colorScheme.primary,
                    child: Center(
                      child: Text(
                        'حجز موعد',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: "ElMessiri",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
      ),
    );
  }
}
