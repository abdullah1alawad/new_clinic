import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String photo, date, message;
  final bool isNotRead;
  final VoidCallback onTap;
  const NotificationCard({
    super.key,
    required this.photo,
    required this.date,
    required this.message,
    required this.isNotRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          photo,
        ),
        radius: 23,
      ),
      title: Text(
        message,
      ),
      subtitle: Text(date),
      trailing: isNotRead ? const Icon(EvaIcons.checkmark) : const Icon(EvaIcons.doneAll),
    );
  }
}
