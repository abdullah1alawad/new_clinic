import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/provider/reset_password_provider.dart';
import 'package:clinic_test_app/widgets/custom_container.dart';
import 'package:clinic_test_app/widgets/custom_text_field.dart';
import 'package:clinic_test_app/widgets/show_error_message.dart';
import 'package:clinic_test_app/widgets/show_success_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final resetPasswordProvider = Provider.of<ResetPasswordProvider>(context);
    return CustomContainer(
      data: [
        Column(
          children: [
            CustomTextField(
              label: "كملة السر القديمة",
              icon: Icons.lock,
              controller: resetPasswordProvider.oldPasswordController,
            ),
            CustomTextField(
              label: "كملة السر الجديدة",
              icon: Icons.lock,
              controller: resetPasswordProvider.newPasswordController,
            ),
            CustomTextField(
              label: "تأكيد كلمة السر",
              icon: Icons.lock,
              controller: resetPasswordProvider.confirmPasswordController,
            ),
          ],
        )
      ],
      icon: Icons.lock,
      onPressButton: () async {
        await resetPasswordProvider.resetPassword();

        if (resetPasswordProvider.connection == ConnectionEnum.connected) {
          if (context.mounted) {
            ShowSuccessMessage.showMessage(context, "تم تعديل الكلمة بنجاح");
          }
        } else if (resetPasswordProvider.connection == ConnectionEnum.failed) {
          if (context.mounted) {
            ShowErrorMessage.showMessage(
                context, resetPasswordProvider.errorMessage!);
          }
        }
      },
      buttonText: "تغيير كلمة السر",
      height: 450,
      cancel: true,
      loading: resetPasswordProvider.connection == ConnectionEnum.cunnecting,
    );
  }
}
