import 'package:clinic_test_app/provider/theme_provider.dart';
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
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
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
                    showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (context) => CustomContainer(
                        data: const [
                          Column(
                            children: [
                              Text(
                                'قريبا...',
                                style: TextStyle(fontSize: 50),
                              )
                            ],
                          ),
                        ],
                        icon: Icons.chair,
                        onPressButton: () {
                          Navigator.of(context).pop();
                        },
                        buttonText: "حجز موعد",
                        height: 700,
                      ),
                    );
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
                      builder: (context) => CustomContainer(
                        data: const [
                          Column(
                            children: [
                              Text(
                                'قريبا...',
                                style: TextStyle(fontSize: 50),
                              )
                            ],
                          )
                        ],
                        icon: Icons.person_add,
                        onPressButton: () {
                          Navigator.of(context).pop();
                        },
                        buttonText: "اضافة مريض",
                        height: 700,
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
