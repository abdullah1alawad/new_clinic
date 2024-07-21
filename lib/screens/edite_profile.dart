import 'dart:io';

import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/validations.dart';
import 'package:clinic_test_app/provider/edite_profile_provider.dart';
import 'package:clinic_test_app/provider/five_screen_provider.dart';
import 'package:clinic_test_app/screens/reset_password.dart';
import 'package:clinic_test_app/widgets/back_ground_container.dart';
import 'package:clinic_test_app/widgets/custom_bottom_app_bar.dart';
import 'package:clinic_test_app/widgets/custom_text_field.dart';
import 'package:clinic_test_app/widgets/show_messages/show_error_message.dart';
import 'package:clinic_test_app/widgets/show_messages/show_success_message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditeProfileScreen extends StatelessWidget {
  const EditeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final editeProfileProvider = Provider.of<EditeProfileProvider>(context);
    final profileProvider = Provider.of<FiveScreenProvider>(context);
    editeProfileProvider.initInfo(profileProvider.user!);
    GlobalKey<FormState> formState = GlobalKey();

    ImageProvider<Object> backgroundImage;
    if (editeProfileProvider.photo == null) {
      backgroundImage = const AssetImage('assets/images/avatar.png');
    } else {
      backgroundImage = FileImage(File(editeProfileProvider.photo!.path));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل الملف الشخصي'),
        bottom: const CustomBottonAppBar(),
      ),
      body: BackGroundContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    backgroundImage: backgroundImage,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                ImagePicker()
                                    .pickImage(source: ImageSource.gallery)
                                    .then((value) => editeProfileProvider
                                        .uploadProfilePhoto(value!));
                              },
                              child: const Icon(
                                Icons.camera_alt_sharp,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: double.infinity, height: 20),
                  // const SizedBox(
                  //   width: 300,
                  //   height: 40,
                  //   child: Divider(
                  //     color: Colors.blue,
                  //   ),
                  // ),
                  CustomTextField(
                    label: "الاسم",
                    icon: Icons.person,
                    controller: editeProfileProvider.nameController,
                    validator: Validations.validateName,
                    obscureText: false,
                  ),
                  CustomTextField(
                    label: 'البريد الالكتروني',
                    icon: Icons.email,
                    controller: editeProfileProvider.emailController,
                    validator: Validations.validateEmail,
                    obscureText: false,
                  ),
                  CustomTextField(
                    label: 'اسم المستخدم',
                    icon: Icons.person,
                    controller: editeProfileProvider.usernameController,
                    validator: (String? val) {
                      return null;
                    },
                    obscureText: false,
                  ),
                  CustomTextField(
                    label: 'رقم الهاتف',
                    icon: Icons.phone,
                    controller: editeProfileProvider.phoneController,
                    validator: (String? val) {
                      return null;
                    },
                    obscureText: false,
                  ),
                  CustomTextField(
                    label: 'الرقم الوطني',
                    icon: Icons.medical_information,
                    controller: editeProfileProvider.nationalIdController,
                    validator: (String? val) {
                      return null;
                    },
                    obscureText: false,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.male,
                        color: Colors.blue,
                        size: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'الجنس',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 50),
                      Radio(
                        value: 0,
                        groupValue: editeProfileProvider.gender,
                        onChanged: (value) {
                          editeProfileProvider.toggleGender(value);
                        },
                      ),
                      Text(
                        'ذكر',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(width: 25),
                      Radio(
                        value: 1,
                        groupValue: editeProfileProvider.gender,
                        onChanged: (value) {
                          editeProfileProvider.toggleGender(value);
                        },
                      ),
                      Text(
                        'انثى',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (formState.currentState!.validate()) {
                        await editeProfileProvider.editeProfile();

                        if (editeProfileProvider.connecion ==
                            ConnectionEnum.connected) {
                          if (context.mounted) {
                            ShowSuccessMessage.showMessage(
                                context, "تم تعديل المعلومات بنجاح");
                          }
                        } else if (editeProfileProvider.connecion ==
                            ConnectionEnum.failed) {
                          if (context.mounted) {
                            ShowErrorMessage.showMessage(
                                context, editeProfileProvider.errorMessage!);
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: editeProfileProvider.connecion ==
                            ConnectionEnum.cunnecting
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text('تعديل',
                            style: Theme.of(context).textTheme.titleSmall),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (context) => const Dialog(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          alignment: Alignment.center,
                          insetPadding: EdgeInsets.zero,
                          child: ResetPassword(),
                        ),
                      );
                    },
                    child: Text(
                      "تغيير كلمة المرور؟",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
