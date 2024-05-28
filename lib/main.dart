import 'package:clinic_test_app/provider/edite_profile_provider.dart';
import 'package:clinic_test_app/provider/login_provider.dart';
import 'package:clinic_test_app/provider/reset_password_provider.dart';
import 'package:clinic_test_app/provider/theme_provider.dart';
import 'package:clinic_test_app/screens/edite_profile.dart';
import 'package:clinic_test_app/screens/main_screen.dart';

import '/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/cache/cache_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => EditeProfileProvider()),
        ChangeNotifierProvider(create: (context) => ResetPasswordProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'), // English
      ],
      title: 'Clinic App',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: LoginScreen(),
    );
  }
}
