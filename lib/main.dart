import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Money Guard'),
        ),
        body: HomePage(),
        bottomNavigationBar: BottomAppBar(
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
                icon: Icon(Icons.more_horiz),
                label: '더보기',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          BannerWidget(),
          SizedBox(height: 20),
          ServiceButton(
            icon: Icons.edit,
            title: '차용증 작성하기',
            description: '안전하고 간편한 전자 차용증작성 서비스',
            onTap: () {
              // Navigate to the relevant page
            },
          ),
          ServiceButton(
            icon: Icons.assignment,
            title: '채권 판매',
            description: '급하게 돈이 필요할 때 빌려준 돈을 활용해요',
            onTap: () {
              // Navigate to the relevant page
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.orange,
      child: Row(
        children: [
          Icon(Icons.file_copy, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '어떤 약속도 안심하세요! 쉽고 편리한 후불약정서 작성하기',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  ServiceButton({required this.icon, required this.title, required this.description, required this.onTap});

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


