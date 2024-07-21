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
