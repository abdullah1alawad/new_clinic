import 'package:clinic_test_app/screens/chats/chat.dart';
import 'package:clinic_test_app/widgets/back_ground_container.dart';
import 'package:clinic_test_app/widgets/custom_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدردشات'),
        bottom: const CustomBottonAppBar(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
      body: BackGroundContainer(
        child: ListView.separated(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ChatScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(-1.0, 0.0); // Reverse direction
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/avatar.png',
                  ),
                  radius: 23,
                ),
                title: Text(
                  'عبدالله',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('مرحبااااااااااااااااا !'),
                trailing: Text('10:50'),
              ),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(
            color: Colors.blue,
            indent: 30,
            endIndent: 30,
          ),
          itemCount: 10,
        ),
      ),
    );
    ;
  }
}
