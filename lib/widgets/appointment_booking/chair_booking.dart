import 'package:clinic_test_app/provider/appointment_booking/appointment_booking_screens_provider.dart';
import 'package:clinic_test_app/provider/appointment_booking/chairs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ChairBooking extends StatefulWidget {
  final Map<String, Map<String, int>> data;
  const ChairBooking({super.key, required this.data});

  @override
  State<ChairBooking> createState() => _ChairBookingState();
}

class _ChairBookingState extends State<ChairBooking> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<String> _availableTimes = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _updateAvailableTimes();
  }

  void _updateAvailableTimes() {
    setState(() {
      String selectedDate = stringDay(_selectedDay);
      _availableTimes = widget.data[selectedDate]?.entries
              .where((entry) => entry.value == 1)
              .map((entry) => entry.key)
              .toList() ??
          [];
    });
  }

  String stringDay(DateTime? selectedDay) {
    return selectedDay!.toIso8601String().split('T').first;
  }

  @override
  Widget build(BuildContext context) {
    final screenProvider =
        Provider.of<AppointmentBookingScreensProvider>(context);
    return Column(
      children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 30)),
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _updateAvailableTimes();
            });
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          calendarStyle: const CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.amberAccent,
              shape: BoxShape.circle,
            ),
          ),
        ),
        //const SizedBox(height: 5),
        ...List.generate(
          _availableTimes.length,
          (index) {
            return ListTile(
              title: Text(_availableTimes[index]),
              trailing: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      screenProvider.time == _availableTimes[index] &&
                              screenProvider.day == stringDay(_selectedDay)
                          ? WidgetStateProperty.all<Color>(Colors.white70)
                          : WidgetStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  screenProvider.time = _availableTimes[index];
                  screenProvider.day = stringDay(_selectedDay);
                },
                child: Text(
                  'اختيار',
                  style: TextStyle(
                    color: screenProvider.time == _availableTimes[index] &&
                            screenProvider.day == stringDay(_selectedDay)
                        ? Colors.blue
                        : Colors.white,
                    fontFamily: 'ElMessiri',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
        if (_availableTimes.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              "لايوجد اوقات متاحة بهذا اليوم !",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
