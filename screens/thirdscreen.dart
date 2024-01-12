import 'package:flutter/material.dart';

class ScreenThird extends StatefulWidget {
  final Function(String) updateNama;

  ScreenThird({required this.updateNama});

  @override
  _ScreenThirdState createState() => _ScreenThirdState();
}

class _ScreenThirdState extends State<ScreenThird> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Portofolio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Input Nama'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.updateNama(nameController.text);
                Navigator.pop(context, nameController.text);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}