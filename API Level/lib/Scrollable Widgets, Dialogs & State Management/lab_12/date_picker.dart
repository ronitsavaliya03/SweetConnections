import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime date = DateTime.now();

  List<String> days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday'];
  List<Map<String, List<String>>> timetable = [
    {
      "monday": [
        "Mathematics",
        "Physics",
        "Chemistry",
        "Biology",
        "English Literature",
        "History"
      ]
    },
    {
      "tuesday": [
        "Computer Science",
        "Geography",
        "Economics",
        "Philosophy",
        "Art and Design",
        "Engineering Mechanics"
      ]
    },
    {
      "wednesday": [
        "Physics",
        "Biology",
        "Mathematics",
        "Economics",
        "History",
        "Philosophy"
      ]
    },
    {
      "thursday": [
        "Chemistry",
        "English Literature",
        "Art and Design",
        "Geography",
        "Computer Science",
        "Biology"
      ]
    },
    {
      "friday": [
        "Engineering Mechanics",
        "History",
        "Mathematics",
        "Philosophy",
        "Physics",
        "Economics"
      ]
    },
  ];

  // Selected day
  String selectedDay = 'monday';

  @override
  Widget build(BuildContext context) {
    String s1 = DateFormat("dd/MM/yyyy").format(date);
    String s2 = DateFormat("EEEE, MMMM d, yyyy").format(date);
    String s3 = DateFormat("dd-MMM-yyyy").format(date);
    String s4 = DateFormat("dd-MM-yy").format(date);
    String s5 = DateFormat("dd MMM, yyyy").format(date);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Date and Time',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              date.toString(),
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            Text(
              "Formats of DateTime",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "${s1}\n${s2}\n${s3}\n${s4}\n${s5}\n",
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            ElevatedButton(
              onPressed: () async {
                DateTime? d = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2027));

                if (d != null && d != date) {
                  setState(() {
                    date = d;
                  });
                }
              },
              child: Text("Select Date"),
            ),
            SizedBox(height: 30,),
            DropdownButton<String>(
              value: selectedDay,
              items: days.map((day) {
                return DropdownMenuItem(
                  value: day,
                  child: Text(day.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDay = value!;
                });
              },
            ),
            Container(
              height: 300,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return getDayWiseTimetable(selectedDay);
                },
                itemCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getDayWiseTimetable(String day) {
    // Find the map for the selected day
    Map<String, List<String>>? dayTimetable =
    timetable.firstWhere((map) => map.containsKey(day), orElse: () => {});

    if (dayTimetable.isEmpty || !dayTimetable.containsKey(day)) {
      return Center(
        child: Text(
          "No timetable available for $day.",
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      );
    }

    List<String> lectures = dayTimetable[day]!;

    return Column(
      children: lectures.map((lecture) {
        return Card(
          elevation: 10,
          child: ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text(
              lecture,
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }).toList(),
    );
  }
}
