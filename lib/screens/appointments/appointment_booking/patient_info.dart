import 'package:clinic_test_app/provider/appointment_booking/clinic_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo({super.key});

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    final clinicInfoProvider = Provider.of<ClinicInfoProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'الرجاء تعبئة معلومات المريض',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: 545,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemCount: clinicInfoProvider.processedQuestions.length,
            itemBuilder: (BuildContext context, int index) {
              return SingleChildScrollView(
                  child: clinicInfoProvider.processedQuestions[index]);
            },
          ),
        ),
        if (clinicInfoProvider.processedQuestions.length > 1)
          const SizedBox(height: 5),
        if (clinicInfoProvider.processedQuestions.length > 1)
          SizedBox(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    clinicInfoProvider.processedQuestions.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              _pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: _activePage == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                          ),
                        )),
              ),
            ),
          ),
      ],
    );
  }
}
