import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            margin: const EdgeInsets.all(50),
            elevation: 5.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              side: BorderSide(
                color: Colors.grey,
                width: 3.0,
              ),
            ),
            child: TableCalendar(
              firstDay: DateTime(2022),
              lastDay: DateTime(2023),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              rowHeight: 60,
              daysOfWeekHeight: 60,
              headerStyle: HeaderStyle(
                titleTextStyle: const TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                formatButtonTextStyle: const TextStyle(color: Colors.teal),
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.teal,
                  size: 28,
                ),
                rightChevronIcon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.teal,
                  size: 28,
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.black),
              ),
              calendarStyle: const CalendarStyle(
                weekendTextStyle: TextStyle(color: Colors.black),
                todayDecoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Appointments Today',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Column(
                children: [
                  Text('Appointment'),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text('Fitzy'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
