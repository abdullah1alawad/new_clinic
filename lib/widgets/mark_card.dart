import 'package:flutter/material.dart';

class MarkCard extends StatelessWidget {
  const MarkCard({super.key});

  @override
  Widget build(BuildContext context) {
    int _total = 0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      //height: 200,
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
            const Text(
              'قلع وتخدير',
              style: TextStyle(
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
                  3,
                  (index) {
                    _total += (index * 2 + 1);
                    return TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              '$index',
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
                              '${index * 2 + 1}',
                              style: const TextStyle(
                                fontFamily: 'ElMessiri',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: TextButton(
                            onPressed: () {},
                            child: Text('انقر للتفاصيل'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                TableRow(
                  children: [
                    const TableCell(
                      child: Center(
                        child: Text(
                          'المجموع',
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
                          '$_total',
                          style: const TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Text(
                          '$_total',
                          style: const TextStyle(
                              fontFamily: 'ElMessiri',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
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
