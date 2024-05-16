import 'package:clinic_test_app/provider/theme_provider.dart';
import 'package:clinic_test_app/screens/main_screen.dart';
import 'package:clinic_test_app/widgets/custom_container.dart';
import 'package:clinic_test_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String path = "/screens/auth/login.dart";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            child: const Icon(Icons.light_mode),
          ),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(
            height: 250,
            width: 100,
            child: Image.asset('assets/images/logo.png'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomContainer(
            data: const [
              Column(
                children: <Widget>[
                  CustomTextField(
                    label: 'اسم المستخدم',
                    icon: Icons.person,
                  ),
                  CustomTextField(
                    label: "كلمة السر",
                    icon: Icons.lock,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "نسيت كلمة السر؟",
                        style: TextStyle(color: Colors.black45),
                      )
                    ],
                  ),
                ],
              ),
            ],
            height: 390,
            icon: Icons.person,
            onPressButton: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
            buttonText: "تسجيل الدخول",
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
