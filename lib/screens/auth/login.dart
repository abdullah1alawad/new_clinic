import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/validations.dart';
import 'package:clinic_test_app/provider/login_provider.dart';
import 'package:clinic_test_app/screens/main_screen.dart';
import 'package:clinic_test_app/widgets/custom_container.dart';
import 'package:clinic_test_app/widgets/custom_text_field.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatelessWidget {
  static const String path = "/screens/auth/login.dart";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: <Widget>[
          // ElevatedButton(
          //   onPressed: () {
          //     Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          //   },
          //   child: const Icon(Icons.light_mode),
          // ),
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
          Form(
            child: CustomContainer(
              data: [
                Column(
                  children: <Widget>[
                    CustomTextField(
                      label: 'اسم المستخدم',
                      icon: Icons.person,
                      controller: loginProvider.usernameControler,
                      validator: Validations.validateUsername,
                    ),
                    CustomTextField(
                      label: "كلمة السر",
                      icon: Icons.lock,
                      controller: loginProvider.passwordControler,
                      validator: Validations.validatePassword,
                    ),
                    const Row(
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
              onPressButton: () async {
                await loginProvider.logIn();

                if (loginProvider.connecion == ConnectionEnum.connected) {
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                  }
                } else if (loginProvider.connecion == ConnectionEnum.failed) {
                  if (context.mounted) {
                    showMessage(context, loginProvider.errorMessage!);
                  }
                }
              },
              buttonText: "تسجيل الدخول",
              cancel: false,
              loading: loginProvider.connecion == ConnectionEnum.cunnecting,
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  void showMessage(BuildContext context, String errorMessage) {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text('Error!'),
      // you can also use RichText widget for title and description parameters
      description: RichText(text: TextSpan(text: errorMessage)),
      alignment: Alignment.bottomCenter,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(EvaIcons.closeCircle, size: 30),
      primaryColor: Colors.red,
      backgroundColor: Colors.redAccent,
      //foregroundColor: Colors.black,
      //padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      //margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      // callbacks: ToastificationCallbacks(
      //   onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
      //   onCloseButtonTap: (toastItem) =>
      //       print('Toast ${toastItem.id} close button tapped'),
      //   onAutoCompleteCompleted: (toastItem) =>
      //       print('Toast ${toastItem.id} auto complete completed'),
      //   onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
      // ),
    );
  }
}
