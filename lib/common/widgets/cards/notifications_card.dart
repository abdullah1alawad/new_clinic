import 'package:auto_size_text/auto_size_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String date, message;
  final ImageProvider<Object>? backgroundImage;
  final bool isNotRead;
  final VoidCallback onTap;
  const NotificationCard({
    super.key,
    required this.backgroundImage,
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
        backgroundImage: backgroundImage,
        radius: 30,
      ),
      title: AutoSizeText(
        message,
        style: TextStyle(fontSize: 17),
        maxLines: 3,
      ),
      subtitle: Text(
        date,
        // style: TextStyle(fontSize: 17),
      ),
      trailing: isNotRead
          ? const Icon(EvaIcons.checkmark)
          : const Icon(EvaIcons.doneAll),
    );
  }
}
