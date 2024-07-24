import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/core/utils/app_constants.dart';
import 'common/cache/cache_helper.dart';

import 'student/screens/main_screen.dart' as student;
import 'doctor/screens/main_screen.dart' as doctor;
import 'assistant/screens/main_screen.dart' as assistant;
import 'common/screens/auth/login.dart';

import 'common/provider/chat/create_chat_provider.dart';
import 'common/provider/chat/create_message_provider.dart';
import 'common/provider/chat/get_chat_messages_provider.dart';
import 'common/provider/chat/get_many_chats_provider.dart';
import 'common/provider/chat/get_single_chat_provider.dart';
import 'common/provider/theme_provider.dart';
import 'common/provider/edite_profile_provider.dart';
import 'common/provider/login_provider.dart';
import 'common/provider/reset_password_provider.dart';
import 'common/provider/get_all_users_provider.dart';

import 'student/provider/appointment_booking/appointment_booking_provider.dart';
import 'student/provider/appointment_booking/appointment_booking_screens_provider.dart';
import 'student/provider/appointment_booking/chairs_provider.dart';
import 'student/provider/appointment_booking/clinic_info_provider.dart';
import 'student/provider/appointment_booking/clinics_provider.dart';
import 'student/provider/appointment_booking/patient_search_provider.dart';
import 'student/provider/cancel_appointment_provider.dart' as student;
import 'student/provider/five_screen_provider.dart';

import 'doctor/provider/init_screens_provider.dart' as doctor;
import 'doctor/provider/cancel_appointment_provider.dart' as doctor;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(
    MultiProvider(
      providers: [
        ////////////////////// common ///////////////////////
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => EditeProfileProvider()),
        ChangeNotifierProvider(create: (context) => ResetPasswordProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CreateChatProvider()),
        ChangeNotifierProvider(create: (context) => CreateMessageProvider()),
        ChangeNotifierProvider(create: (context) => GetManyChatsProvider()),
        ChangeNotifierProvider(create: (context) => GetSingleChatProvider()),
        ChangeNotifierProvider(create: (context) => GetChatMessagesProvider()),
        ChangeNotifierProvider(create: (context) => GetAllUsersProvider()),
        ////////////////////// student ///////////////////////
        ChangeNotifierProvider(create: (context) => FiveScreenProvider()),
        ChangeNotifierProvider(
            create: (context) => AppointmentBookingScreensProvider()),
        ChangeNotifierProvider(
            create: (context) => AppointmentBookingProvider()),
        ChangeNotifierProvider(create: (context) => ClinicsProvider()),
        ChangeNotifierProvider(create: (context) => ClinicInfoProvider()),
        ChangeNotifierProvider(create: (context) => ChairsProvider()),
        ChangeNotifierProvider(
            create: (context) => student.CancelAppointmentProvider()),
        ChangeNotifierProvider(create: (context) => PatientSearchProvider()),
        //////////////////// doctor ////////////////////////////
        ChangeNotifierProvider(create: (context) =>doctor.InitScreensProvider()),
        ChangeNotifierProvider(create: (context) =>doctor.CancelAppointmentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final token = CacheHelper().getDataString(key: kTOKEN);
    final userRole = CacheHelper().getDataString(key: kUSERROLE);

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
      home: token == null
          ? const LoginScreen()
          : userRole == kSTUDENT
              ? const student.MainScreen()
              : userRole == kDOCTOR
                  ? const doctor.MainScreen()
                  : const assistant.MainScreen(),
    );
  }
}
