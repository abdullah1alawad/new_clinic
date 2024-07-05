import 'package:clinic_test_app/provider/appointment_booking/clinics_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/appointment_booking_screens_provider.dart';
import 'package:clinic_test_app/provider/five_screen_provider.dart';
import 'package:clinic_test_app/provider/theme_provider.dart';
import 'package:clinic_test_app/screens/appointments/appointment_booking/appointment_booking.dart';
import 'package:clinic_test_app/screens/appointments/coming_appointments.dart';
import 'package:clinic_test_app/screens/appointments/completed_appointments.dart';
import 'package:clinic_test_app/widgets/back_ground_container.dart';
import 'package:clinic_test_app/widgets/custom_container.dart';
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
                text: 'المواعيد القادمة',
              ),
              Tab(
                text: 'المواعيد المكتملة',
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Provider.of<ThemeProvider>(context, listen: false)
                //     .toggleTheme();
                Provider.of<FiveScreenProvider>(context, listen: false).fun();
              },
              child: Icon(Icons.light_mode),
            )
          ],
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
                    Provider.of<ClinicsProvider>(context,listen: false)
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
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        alignment: Alignment.center,
                        insetPadding: EdgeInsets.zero,
                        child: CustomContainer(
                          data: const Column(
                            children: [
                              Text('hello'),
                              // CustomTextField(
                              //   label: 'اسم المستخدم',
                              //   icon: Icons.person,
                              // ),
                              // CustomTextField(
                              //   label: "كلمة السر",
                              //   icon: Icons.lock,
                              // ),
                              // CustomTextField(
                              //   label: "كلمة السر",
                              //   icon: Icons.lock,
                              // ),
                            ],
                          ),
                          icon: Icons.person,
                          onPressButton: () {
                            Navigator.of(context).pop();
                          },
                          buttonText: "إضافة مريض",
                          loading: false,
                        ),
                      ),
                    );
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  heroTag: null,
                  child: const Icon(Icons.person_add),
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
                        'إضافة مريض',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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