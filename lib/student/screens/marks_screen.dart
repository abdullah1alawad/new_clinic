import '../../common/core/enum/connection_enum.dart';
import '../../common/widgets/back_ground_container.dart';
import '../../common/widgets/custom_bottom_app_bar.dart';

import '../provider/five_screen_provider.dart';
import '../widgets/cards/mark_card.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarksScreen extends StatelessWidget {
  const MarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('العلامات'),
        bottom: const CustomBottonAppBar(),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.filter_list,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
      body: BackGroundContainer(
        child: Consumer<FiveScreenProvider>(
          builder: (context, provider, child) {
            if (provider.connection == ConnectionEnum.connected) {
              return ListView.builder(
                itemCount: provider.marks!.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: MarkCard(
                        subjectName: provider.marks![index].subjectName,
                        mark: provider.marks![index].mark,
                        appointments: provider.marks![index].appointments,
                      ),
                    );
                  } else if (index != provider.marks!.length) {
                    return MarkCard(
                      subjectName: provider.marks![index].subjectName,
                      mark: provider.marks![index].mark,
                      appointments: provider.marks![index].appointments,
                    );
                  } else {
                    return const SizedBox(height: 50);
                  }
                },
              );
            } else if (provider.connection == ConnectionEnum.failed) {
              return Center(child: Text(provider.errorMessage ?? 'Error'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
