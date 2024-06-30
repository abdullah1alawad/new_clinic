import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ChairBookingPage extends StatefulWidget {
  const ChairBookingPage({super.key});

  @override
  State<ChairBookingPage> createState() => _ChairBookingPageState();
}

class _ChairBookingPageState extends State<ChairBookingPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Chair Booking UI'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2023, 7, 1),
            lastDay: DateTime(2024, 12, 31),
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
            calendarStyle: CalendarStyle(
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
          Expanded(
            child: ListView.builder(
              itemCount: _availableTimes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_availableTimes[index]),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Handle booking logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Booked ${_availableTimes[index]}')),
                      );
                    },
                    child: Text('Book'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
