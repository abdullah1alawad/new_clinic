import 'package:flutter/material.dart';

class ChooseDoctor extends StatelessWidget {
  const ChooseDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> doctorInfo = [
      "د. محمد",
      "د. احمد",
      "د. عبووود",
      "د. محمد",
      "د. احمد",
      "د. عبووود",
      "د. محمد",
      "د. احمد",
      "د. عبووود",
    ];
    int? doctorId = 1;

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'الرجاء اختيار الدكتور المشرف',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          ...List.generate(doctorInfo.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  doctorId = index;
                },
                style: ButtonStyle(
                  backgroundColor: index != doctorId
                      ? WidgetStateProperty.all<Color>(Colors.blue)
                      : WidgetStateProperty.all<Color>(Colors.white70),
                  fixedSize: WidgetStateProperty.all<Size>(const Size(250, 50)),
                ),
                child: Text(
                  doctorInfo[index],
                  style: TextStyle(
                      color: index != doctorId ? Colors.white : Colors.blue,
                      fontSize: 20,
                      fontFamily: 'ElMessiri',
                      fontWeight: FontWeight.bold,),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
