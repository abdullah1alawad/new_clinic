import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

Future uploadImageToAPI(XFile image) async {
  return MultipartFile.fromFile(image.path,
      filename: image.path.split('/').last);
}

String utcToLocal(
  String value, {
  bool hasTime = true,
}) {
  try {
    DateTime parsed = parseDateTime(value);

    return hasTime
        ? DateFormat.yMd().add_jms().format(parsed)
        : DateFormat.yMd().format(parsed);
  } catch (_) {
    return 'Invalid DateTime';
  }
}

DateTime parseDateTime(String value) {
  return DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(value).toLocal();
}

String sameDaySameWeek(String dateStr) {
    // Parse the given date string into a DateTime object
    DateTime givenDate = DateTime.parse(dateStr);

    // Get the current date and time
    DateTime currentDate = DateTime.now().toUtc();

    // Define the start of the current week (Monday)
    DateTime startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1));

    // Check if the given date is on the same day as the current date
    if (givenDate.year == currentDate.year &&
        givenDate.month == currentDate.month &&
        givenDate.day == currentDate.day) {
      return DateFormat.Hm().format(givenDate);  // H:m format
    }
    // Check if the given date is within the same week as the current date
    else if (givenDate.isAfter(startOfWeek) &&
             givenDate.isBefore(startOfWeek.add(Duration(days: 7)))) {
      return DateFormat.EEEE().format(givenDate);  // Day of the week
    }
    // Otherwise, format the date as YYYY-MM-DD
    else {
      return DateFormat.yMd().format(givenDate);  // Y:M:D format
    }
  }

void navigator(Widget navigateTo, BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}
