import 'package:clinic_test_app/model/appointment_model.dart';
import 'package:clinic_test_app/widgets/cards/appointment_details_card.dart';
import 'package:flutter/material.dart';

class MarkCard extends StatelessWidget {
  final String subjectName;
  final int mark;
  final List<AppointmentModel> appointments;

  const MarkCard({
    super.key,
    required this.subjectName,
    required this.mark,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 25,
            color: Colors.black45,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              subjectName,
              style: const TextStyle(
                fontFamily: 'ElMessiri',
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 7),
            Table(
              border: TableBorder.all(color: Colors.black),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  children: [
                    TableCell(
                      child: Center(
                        child: Text(
                          'رقم الموعد',
                          style: TextStyle(
                            fontFamily: 'ElMessiri',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'العلامة',
                          style: TextStyle(
                            fontFamily: 'ElMessiri',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          'التفاصيل',
                          style: TextStyle(
                            fontFamily: 'ElMessiri',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ...List.generate(
                  appointments.length,
                  (index) {
                    return TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              '${appointments[index].mark}',
                              style: const TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                useSafeArea: true,
                                context: context,
                                builder: (context) => AppointmentDetailsCard(
                                  appointment: appointments[index],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.read_more,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Table(
              border: TableBorder.all(color: Colors.black),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    const TableCell(
                      child: Center(
                        child: Text(
                          'العلامة النهائية',
                          style: TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          '$mark',
                          style: const TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}
