import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            label: Text(label),
            labelStyle: Theme.of(context).textTheme.labelMedium,
            border: InputBorder.none,
            icon: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          controller: controller,
          validator: validator,
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
