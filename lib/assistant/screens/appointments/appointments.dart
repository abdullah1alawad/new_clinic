import '../../../common/widgets/back_ground_container.dart';

import '../../provider/init_screens_provider.dart';
import '../appointments/coming_appointments.dart';
import '../appointments/completed_appointments.dart';

import 'package:auto_size_text/auto_size_text.dart';
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
          //       Provider.of<InitScreensProvider>(context, listen: false).fun();
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
      ),
    );
  }
}
