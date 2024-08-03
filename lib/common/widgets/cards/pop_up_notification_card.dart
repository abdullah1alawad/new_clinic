import 'package:flutter/material.dart';

class PopUpNotificationCard extends StatelessWidget {
  final bool type;

  const PopUpNotificationCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.lightBlueAccent, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          type
              ? const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 40,
                )
              : const Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 40,
                ),
          const SizedBox(width: 16),
          type
              ? const Text(
                  'إشعار جديد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const Text(
                  'رسالة جديدة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ],
      ),
    );
  }
}
