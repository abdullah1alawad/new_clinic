import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String name, lastMessage, date;
  final bool isNotRead;
  final ImageProvider<Object>? backgroundImage;
  final VoidCallback onTap;
  const ChatCard({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.date,
    required this.backgroundImage,
    required this.onTap,
    required this.isNotRead,
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
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        maxLines: 1,
      ),
      subtitle: AutoSizeText(
        lastMessage,
        style: isNotRead
            ? TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              )
            : null,
        maxLines: 1,
      ),
      trailing: AutoSizeText(
        date,
        style: TextStyle(fontSize: 15),
        maxLines: 1,
      ),
    );
  }
}
