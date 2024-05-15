import 'package:clinic_test_app/widgets/custom_container.dart';
import 'package:flutter/material.dart';

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
            icon: Icons.menu_book_sharp,
            onPressButton: () {
              Navigator.of(context).pop();
            },
            buttonText: "تم",
            height: 700,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: 190,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 165,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 15),
                    blurRadius: 25,
                    color: Colors.black45,
                  )
                ],
              ),
            ),
            Positioned(
              top: 12,
              left: 0,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'تمت الاضافة للمفضلة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      backgroundColor: Colors.green.shade400,
                      behavior: SnackBarBehavior.floating,
                      width: 176,
                      duration: Duration(milliseconds: 900),
                      //showCloseIcon: true,
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue.shade300,
                  child: const Icon(
                    Icons.star_outlined,
                    size: 30,
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 40,
              child: Text(
                'قلع وتخدير',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 20,
                ),
              ),
            ),
            const Positioned(
              top: 75,
              child: Text(
                'اشراف الدكتورة: سمر الحلبي',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 18,
                ),
              ),
            ),
            const Positioned(
              top: 105,
              child: Text(
                'المريض : راضي شقيفة',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 18,
                ),
              ),
            ),
            const Positioned(
              top: 135,
              child: Text(
                'الكرسي رقم : 10',
                style: TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: 18,
                ),
              ),
            ),
            const Positioned(
              bottom: 10,
              right: 10,
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'مقبول',
                    style: TextStyle(fontFamily: 'ElMessiri', fontSize: 17),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 10,
              left: 10,
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
