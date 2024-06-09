import 'package:clinic_test_app/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          useSafeArea: true,
          context: context,
          builder: (context) => CustomContainer(
            data: const Column(
              children: [
                Text(
                  'قريبا...',
                  style: TextStyle(fontSize: 50),
                )
              ],
            ),
            icon: Icons.menu_book_sharp,
            onPressButton: () {
              Navigator.of(context).pop();
            },
            buttonText: "تم",
            //height: 700,
            cancel: true,
            loading: false,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        height: 190,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 165,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Theme.of(context).colorScheme.secondary,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 15),
                    blurRadius: 25,
                    color: Colors.black45,
                  )
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'قلع وتخدير',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'اشراف الدكتورة: سمر الحلبي',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'المريض: فلان الفلاني',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'الكرسي رقم: 10',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'تاريخ الموعد:   9:30   2024/7/1',
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 12,
              left: 0,
              child: Icon(
                EvaIcons.checkmarkCircle2,
                //EvaIcons.alertCircle,
                // EvaIcons.closeCircle,
                color: Colors.green,
                //color: Colors.orangeAccent,
                // color: Colors.redAccent,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
