import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:coco/SecondPage.dart';
import 'package:coco/ThreedPage.dart';
import 'package:coco/FourPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/second': (context) => SecondPage(),
        '/threed': (context) => ThreedPage(),
        '/four': (context) => FourPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('머니실드'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            ServiceButton(
              icon: Icons.edit,
              title: '차용증 작성하기',
              description: '안전하고 간편한 차용증 작성',
              onTap: () {
                Navigator.pushNamed(context, '/threed');
              },
            ),
            ServiceButton(
              icon: Icons.assignment,
              title: '차용증 판매하기',
              description: '급전이 필요할 때 빌려준 돈을 활용해요',
              onTap: () {
                Navigator.pushNamed(context, '/four');
              },
            ),
            Spacer(),
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const ServiceButton({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18)),
                  SizedBox(height: 5),
                  Text(description, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: '보관함',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_flat),
            label: '거래소',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
            // Home button action
              Navigator.pushNamed(context, '/');
              break;
            case 1:
            // Navigate to SecondPage when "보관함" is clicked
              Navigator.pushNamed(context, '/second');
              break;
            case 2:
            // Exchange button action
            // Handle exchange button action
              break;
          }
        },
      ),
    );
  }
}
