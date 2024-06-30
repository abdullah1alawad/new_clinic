import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ChairBooking extends StatefulWidget {
  const ChairBooking({super.key});

  @override
  State<ChairBooking> createState() => _ChairBookingState();
}

class _ChairBookingState extends State<ChairBooking> {
  Map<String, Map<String, int>> data = {
    "2024-07-01": {"09:00 AM": 1, "10:30 AM": 1, "12:00 PM": 1, "01:30 PM": 1},
    "2024-07-02": {"09:00 AM": 1, "10:30 AM": 1, "12:00 PM": 1, "01:30 PM": 1},
    "2024-07-03": {"09:00 AM": 1, "10:30 AM": 1, "12:00 PM": 1, "01:30 PM": 1},
    "2024-07-04": {"09:00 AM": 1, "10:30 AM": 1, "12:00 PM": 1, "01:30 PM": 1},
    "2024-07-05": {"09:00 AM": 1, "10:30 AM": 0, "12:00 PM": 0, "01:30 PM": 0},
    // Add more data as needed
  };

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
      String selectedDate = _selectedDay!.toIso8601String().split('T').first;
      _availableTimes = data[selectedDate]
              ?.entries
              .where((entry) => entry.value == 1)
              .map((entry) => entry.key)
              .toList() ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.orange,
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
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                  //fixedSize: WidgetStateProperty.all<Size>(const Size(250, 50)),
                ),
                onPressed: () {
                  // Handle booking logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booked ${_availableTimes[index]}')),
                  );
                },
                child: const Text(
                  'اختيار',
                  style: TextStyle(
                    color: Colors.white,
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
