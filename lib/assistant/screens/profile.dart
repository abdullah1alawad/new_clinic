import '../../common/cache/cache_helper.dart';
import '../../common/core/enum/connection_enum.dart';
import '../../common/core/utils/app_constants.dart';
import '../../common/core/utils/laravel_echo.dart';
import '../../common/screens/auth/login.dart';
import '../../common/widgets/charts/activity_graph.dart';
import '../../common/widgets/back_ground_container.dart';
import '../../common/widgets/charts/pie_chart.dart';
import '../../common/widgets/custom_bottom_app_bar.dart';
import '../../common/screens/edite_profile.dart';

import '../provider/init_screens_provider.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<InitScreensProvider>(context);

    ImageProvider<Object> backgroundImage;
    if (profileProvider.user!.photo == null) {
      backgroundImage = const AssetImage('assets/images/avatar.png');
    } else {
      backgroundImage =
          NetworkImage('$kIMAGEBASEURL${profileProvider.user!.photo}');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        leading: IconButton(
          onPressed: () {
            //LaravelEcho.instance.disconnect();
            CacheHelper().removeData(key: kTOKEN);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      EditeProfileScreen(user: profileProvider.user!),
                ),
              );
            },
            icon: const Icon(EvaIcons.edit2Outline),
            color: Colors.white,
          )
        ],
        bottom: const CustomBottonAppBar(),
      ),
      body: BackGroundContainer(
        child: profileProvider.connection == ConnectionEnum.connected
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        backgroundImage: backgroundImage,
                      ),
                      const SizedBox(width: double.infinity, height: 20),
                      Text(
                        profileProvider.user!.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        width: 300,
                        height: 40,
                        child: Divider(
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'نشاطاتك خلال العام الماضي :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const ActivityGraph(),
                      const SizedBox(height: 30),
                      const SizedBox(
                        width: 300,
                        height: 40,
                        child: Divider(
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'المواد التي تم العمل عليها  :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const MyPieChart(),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              )
            : profileProvider.connection == ConnectionEnum.failed
                ? const Center(
                    child: Text("فشل الاتصال"),
                  )
                : const CircularProgressIndicator(),
      ),
    );
  }
}
