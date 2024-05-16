import 'package:clinic_test_app/provider/theme_provider.dart';
import 'package:clinic_test_app/screens/appointments/coming_appointments.dart';
import 'package:clinic_test_app/screens/appointments/completed_appointments.dart';
import 'package:clinic_test_app/widgets/back_ground_container.dart';
import 'package:clinic_test_app/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
            const SizedBox(height: 8),
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
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
