import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/provider/appointment_booking/appointment_booking_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/chairs_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/clinic_info_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/clinics_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/appointment_booking_screens_provider.dart';
import 'package:clinic_test_app/provider/cancel_appointment_provider.dart';
import 'package:clinic_test_app/provider/edite_profile_provider.dart';
import 'package:clinic_test_app/provider/five_screen_provider.dart';
import 'package:clinic_test_app/provider/login_provider.dart';
import 'package:clinic_test_app/provider/reset_password_provider.dart';
import 'package:clinic_test_app/provider/theme_provider.dart';
import 'package:clinic_test_app/screens/main_screen.dart';
import 'package:clinic_test_app/test.dart';

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
        ChangeNotifierProvider(create: (context) => FiveScreenProvider()),
        ChangeNotifierProvider(
            create: (context) => AppointmentBookingScreensProvider()),
        ChangeNotifierProvider(
            create: (context) => AppointmentBookingProvider()),
        ChangeNotifierProvider(create: (context) => ClinicsProvider()),
        ChangeNotifierProvider(create: (context) => ClinicInfoProvider()),
        ChangeNotifierProvider(create: (context) => ChairsProvider()),
        ChangeNotifierProvider(
            create: (context) => CancelAppointmentProvider()),
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
      home: CacheHelper().getDataString(key: kTOKEN) == null
          ? const LoginScreen()
          : const MainScreen(),
    );
  }
}
