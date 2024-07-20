import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String name, lastMessage, date, photo;
  final VoidCallback onTap;
  const ChatCard({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.date,
    required this.photo,
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
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(lastMessage),
      trailing: Text(date),
    );
  }
}
