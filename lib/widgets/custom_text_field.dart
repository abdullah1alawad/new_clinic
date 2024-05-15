import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;

  const CustomTextField({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
              label: Text(label),
              labelStyle: Theme.of(context).textTheme.labelMedium,
              border: InputBorder.none,
              icon: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              )),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Divider(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
