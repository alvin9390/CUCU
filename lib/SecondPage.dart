import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<dynamic> bonds = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBonds();
  }

  Future<void> fetchBonds() async {
    try {
      final response = await http.get(Uri.parse('https://api.example.com/bonds'));
      if (response.statusCode == 200) {
        setState(() {
          bonds = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load bonds');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching bonds: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('보관함'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : bonds.isEmpty
          ? Center(child: Text('No bonds available'))
          : ListView.builder(
        itemCount: bonds.length,
        itemBuilder: (context, index) {
          final bond = bonds[index];
          return ListTile(
            title: Text(bond['title']),
            subtitle: Text('Amount: ${bond['amount']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BondDetailPage(bond: bond),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BondDetailPage extends StatelessWidget {
  final dynamic bond;

  const BondDetailPage({required this.bond});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bond['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${bond['title']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Amount: ${bond['amount']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Date: ${bond['date']}', style: TextStyle(fontSize: 18)),
            // Add more fields as necessary
          ],
        ),
      ),
    );
  }
}
