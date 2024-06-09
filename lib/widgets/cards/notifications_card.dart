import 'package:clinic_test_app/widgets/custom_container.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

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
            icon: Icons.notifications,
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
        height: 185,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 160,
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
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'لقد وافق الدكتور فلان الفلاني على حجز الكرسي رقم 10 من اجل المريض فلان في المادة الفلانلة بتاريخ كذا',
                  style: TextStyle(
                    fontFamily: 'ElMessiri',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 10,
              right: 12,
              child: Row(
                children: [
                  Icon(
                    EvaIcons.doneAll,
                    color: Colors.green,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'مقروئة (ممكن نغيرا)',
                    style: TextStyle(fontFamily: 'ElMessiri', fontSize: 17),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 10,
              left: 12,
              child: Text(
                '9:30 24/7/1',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
