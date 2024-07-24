import 'package:clinic_test_app/common/widgets/my_painter.dart';
import 'package:flutter/material.dart';

class CustomBottonAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomBottonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 5),
      painter: MyPainter(),
      // Container(
      //   color: Theme.of(context).colorScheme.secondary,
      //   height: 1.0,
      // ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 5);
}
