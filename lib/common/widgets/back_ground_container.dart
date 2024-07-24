import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BackGroundContainer extends StatelessWidget {
  final Widget child;
  const BackGroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
