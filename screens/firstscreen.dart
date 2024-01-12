import 'package:cryptoapp/screens/secondscreen.dart';
import 'package:cryptoapp/screens/thirdscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenFirst(),
    );
  }
}

class ScreenFirst extends StatefulWidget {
  @override
  _ScreenFirstState createState() => _ScreenFirstState();
}

class _ScreenFirstState extends State<ScreenFirst> {
  List<Map<String, String>> cryptoDataList = [];
  String inputNama = '';

  void updateData(String cryptoName, String buyPrice, String amount) {
    setState(() {
      cryptoDataList.add({
        'cryptoName': cryptoName,
        'buyPrice': buyPrice,
        'amount': amount,
      });
    });
  }

  void removeCryptoData(int index) {
    setState(() {
      cryptoDataList.removeAt(index);
    });
  }

  void updateNama(String nama) {
    setState(() {
      inputNama = nama;
    });
  }

  void navigateToScreenThird() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenThird(updateNama: updateNama),
      ),
    );

    if (result != null) {
      setState(() {
        inputNama = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Portofolio'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenSecond(updateData),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              navigateToScreenThird();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Welcome, $inputNama',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TotalPortfolioWidget(cryptoDataList: cryptoDataList),
            Expanded(
              child: ListView.builder(
                itemCount: cryptoDataList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(cryptoDataList[index]['cryptoName']!),
                    onDismissed: (direction) {
                      removeCryptoData(index);
                    },
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                        ),
                        child: ListTile(
                          title: Text('${cryptoDataList[index]['cryptoName']}'),
                          subtitle: Text('${cryptoDataList[index]['buyPrice']}'),
                          trailing: Text('${(double.parse(cryptoDataList[index]['buyPrice'] ?? '0') * double.parse(cryptoDataList[index]['amount'] ?? '0')).toStringAsFixed(2)}'),
                          leading: Text('${cryptoDataList[index]['amount']}'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class TotalPortfolioWidget extends StatelessWidget {
  final List<Map<String, String>> cryptoDataList;

  TotalPortfolioWidget({required this.cryptoDataList});

  @override
  Widget build(BuildContext context) {
    double totalPortfolio = 0;

    cryptoDataList.forEach((crypto) {
      double buyPrice = double.parse(crypto['buyPrice'] ?? '0');
      double amount = double.parse(crypto['amount'] ?? '0');
      totalPortfolio += buyPrice * amount;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Portfolio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Total: $totalPortfolio'),
      ],
    );
  }
}
