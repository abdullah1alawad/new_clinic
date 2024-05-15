import 'package:clinic_test_app/screens/appointments/appointment_card.dart';
import 'package:flutter/material.dart';

class CompletedAppointments extends StatelessWidget {
  const CompletedAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //const SizedBox(height: 20),
        Expanded(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 70),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
              ),
              ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const AppointmentCard(),
              ),
            ],
          ),
        ),
      ],
    );
    // return const Column(
    //   children: [
    //     SizedBox(height: 5),
    //     ListTile(
    //       leading: Icon(Icons.book_outlined),
    //       title: Text('قلع '),
    //       subtitle: Text('salflasbfisa'),
    //       trailing: Text('1/2/2202'),
    //       tileColor: Colors.white,
    //     ),
    //     SizedBox(height: 5),
    //     ListTile(
    //       leading: Icon(Icons.book_outlined),
    //       title: Text('قلع '),
    //       subtitle: Text('salflasbfisa'),
    //       trailing: Text('1/2/2202'),
    //       tileColor: Colors.white,
    //     ),
    //   ],
    // );
  }
}
