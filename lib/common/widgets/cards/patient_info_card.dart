import 'package:auto_size_text/auto_size_text.dart';
import '../../model/patient_info_model.dart';
import 'package:clinic_test_app/common/widgets/patient_question_text_field.dart';
import 'package:flutter/material.dart';

class PatientInfo extends StatefulWidget {
  final List<PatientInfoModel> patientInfo;
  const PatientInfo({
    super.key,
    required this.patientInfo,
  });

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    List<Column> patientInfo = processPatientInfo(widget.patientInfo);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AutoSizeText(
          'معلومات المريض',
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
        ),
        SizedBox(
          height: screenHeight * 0.53, //400, //545
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemCount: patientInfo.length,
            itemBuilder: (BuildContext context, int index) {
              return SingleChildScrollView(child: patientInfo[index]);
            },
          ),
        ),
        if (patientInfo.length > 1) const SizedBox(height: 5),
        if (patientInfo.length > 1)
          SizedBox(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    patientInfo.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: InkWell(
                            onTap: () {
                              _pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 5,
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

  List<Column> processPatientInfo(List<PatientInfoModel> patientInfo) {
    int size = patientInfo.length;
    List<Column> processedPatientInfo = [];

    for (int i = 0; i < size; i += 5) {
      List<PatientQuestionTextField> temp = [];
      for (int j = i; j < i + 5 && j < size; j++) {
        temp.add(
          PatientQuestionTextField(
            label: patientInfo[j].question,
            icon: Icons.question_mark,
            controller: null,
            obscureText: false,
            readOnly: true,
            hintText: patientInfo[j].answer,
          ),
        );
      }
      processedPatientInfo.add(Column(children: temp));
    }

    return processedPatientInfo;
  }
}
