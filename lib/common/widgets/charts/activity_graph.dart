import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class ActivityGraph extends StatelessWidget {
  const ActivityGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Stack(
        children: [
          HeatMap(
            datasets: {
              DateTime(2024, 5, 22): 1,
              DateTime(2024, 5, 21): 2,
              DateTime(2024, 5, 8): 1,
              DateTime(2024, 5, 9): 3,
              DateTime(2024, 5, 13): 2,
            },
            //startDate: DateUtils.addMonthsToMonthDate(DateTime.now(), -2),
            //size: 10,
            //fontSize: 0,
            borderRadius: 0,
            colorMode: ColorMode.color,
            defaultColor: Colors.white,
            showText: false,
            showColorTip: false,
            scrollable: true,
            colorsets: const {
              1: Color(0xff91DA9E),
              2: Color(0xff30A14E),
              3: Color(0xff216E39),
            },
            onClick: (value) {
              //int proNum = widget.datasets[value];
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(value.toString())));
            },
          ),
          Container(
            width: 49,
            height: 190,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 17),
                Text(
                  'السبت',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'ElMessiri',
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'الأحد',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'ElMessiri',
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'الاثنين',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'ElMessiri',
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'الثلاثاء',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'ElMessiri',
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'الأربعاء',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'ElMessiri',
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'الخميس',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'ElMessiri',
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'الجمعة',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'ElMessiri',
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
