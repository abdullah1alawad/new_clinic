import 'package:clinic_test_app/provider/appointment_booking/appointment_booking_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/appointment_booking_screens_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/chairs_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/clinic_info_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/clinics_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/patient_search_provider.dart';
import 'package:clinic_test_app/provider/cancel_appointment_provider.dart';
import 'package:clinic_test_app/provider/edite_profile_provider.dart';
import 'package:clinic_test_app/provider/five_screen_provider.dart';
import 'package:clinic_test_app/provider/login_provider.dart';
import 'package:clinic_test_app/provider/reset_password_provider.dart';
import 'package:clinic_test_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> providers = [
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
            ChangeNotifierProvider(
            create: (context) => PatientSearchProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
];
