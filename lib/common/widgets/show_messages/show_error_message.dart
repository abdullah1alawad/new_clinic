import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ShowErrorMessage {
  static void showMessage(BuildContext context, String errorMessage) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 5),
      //title: const Text('Error!'),
      // you can also use RichText widget for title and description parameters
      description: RichText(
        text: TextSpan(
          text: errorMessage,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      alignment: Alignment.bottomCenter,
      direction: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: const Icon(EvaIcons.closeCircleOutline, size: 35),
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
