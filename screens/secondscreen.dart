import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenSecond extends StatefulWidget {
  final Function(String, String, String) updateData;

  ScreenSecond(this.updateData);

  @override
  _ScreenSecondState createState() => _ScreenSecondState();
}

class _ScreenSecondState extends State<ScreenSecond> {
  final TextEditingController cryptoNameController = TextEditingController();
  final TextEditingController buyPriceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

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
              controller: cryptoNameController,
              decoration: InputDecoration(labelText: 'Crytocoin'),
            ),
            TextFormField(
              controller: buyPriceController,
              decoration: InputDecoration(labelText: 'Buy Price'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
              ],
            ),
            TextFormField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    cryptoNameController.clear();
                    buyPriceController.clear();
                    amountController.clear();
                  },
                  child: Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateData(
                      cryptoNameController.text,
                      buyPriceController.text,
                      amountController.text,
                    );

                    // Return data to the first screen
                    Navigator.pop(context, 'Data saved successfully');
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
