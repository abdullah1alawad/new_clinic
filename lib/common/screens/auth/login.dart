import 'package:clinic_test_app/common/core/utils/app_constants.dart';

import '../../core/enum/connection_enum.dart';
import '../../core/utils/validations.dart';
import '../../provider/login_provider.dart';
import '/../../student/screens/main_screen.dart' as student;
import '/../../doctor/screens/main_screen.dart' as doctor;
import '/../../assistant/screens/main_screen.dart' as assistant;
import '../../widgets/custom_container.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/show_messages/show_error_message.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String path = "/screens/auth/login.dart";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    GlobalKey<FormState> formState = GlobalKey();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 50.0,
          ),
          SizedBox(
            height: 250,
            width: 100,
            child: Image.asset('assets/images/logo.png'),
          ),
          const SizedBox(
            height: 100.0,
          ),
          Form(
            key: formState,
            child: CustomContainer(
              data: Column(
                children: <Widget>[
                  CustomTextField(
                    label: 'اسم المستخدم',
                    icon: Icons.person,
                    controller: loginProvider.usernameController,
                    validator: Validations.validateUsername,
                    obscureText: false,
                  ),
                  CustomTextField(
                    label: "كلمة السر",
                    icon: Icons.lock,
                    controller: loginProvider.passwordController,
                    validator: Validations.validatePassword,
                    obscureText: true,
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
              icon: Icons.person,
              onPressButton: () async {
                if (formState.currentState!.validate()) {
                  await loginProvider.logIn();

                  if (loginProvider.connecion == ConnectionEnum.connected) {
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            final userRole = loginProvider.loginInfo!.userRole;
                            
                            if (userRole == kSTUDENT) {
                              return const student.MainScreen();
                            } else if (userRole == kDOCTOR) {
                              return const doctor.MainScreen();
                            } else {
                              return const assistant.MainScreen();
                            }
                          },
                        ),
                      );
                    }
                  } else if (loginProvider.connecion == ConnectionEnum.failed) {
                    if (context.mounted) {
                      ShowErrorMessage.showMessage(
                          context, loginProvider.errorMessage!);
                    }
                  }
                }
              },
              buttonText: "تسجيل الدخول",
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
}
