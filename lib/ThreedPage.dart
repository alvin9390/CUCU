import 'package:flutter/material.dart';

class ThreedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('차용증 작성하기'),
      ),
      body: LoanForm(),
    );
  }
}

class LoanForm extends StatefulWidget {
  @override
  _LoanFormState createState() => _LoanFormState();
}

class _LoanFormState extends State<LoanForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _borrowerController = TextEditingController();
  final TextEditingController _lenderController = TextEditingController();
  DateTime _repaymentDate = DateTime.now();
  bool _consentToRepurchase = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(labelText: '대여 금액'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '대여 금액을 입력하세요';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _borrowerController,
              decoration: InputDecoration(labelText: '빌리는 사람'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '빌리는 사람을 입력하세요';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _lenderController,
              decoration: InputDecoration(labelText: '빌려주는 사람'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '빌려주는 사람을 입력하세요';
                }
                return null;
              },
            ),
            ListTile(
              title: Text('상환 날짜'),
              subtitle: Text('${_repaymentDate.toLocal()}'.split(' ')[0]),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _repaymentDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null && picked != _repaymentDate)
                  setState(() {
                    _repaymentDate = picked;
                  });
              },
            ),
            CheckboxListTile(
              title: Text('환매동의'),
              value: _consentToRepurchase,
              onChanged: (bool? value) {
                setState(() {
                  _consentToRepurchase = value ?? false;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: Text('작성 완료'),
            ),
          ],
        ),
      ),
    );
  }
}
