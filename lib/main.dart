import 'package:flutter/material.dart';
import 'package:fortyseventen_mobile/screens/StockList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4710 Stocks',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(title: '4710 Stocks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          '4710  STOCKS',
          style: TextStyle(fontFamily: 'Muller', fontSize: 25),
        ),
      ),
      body: StockList(),
    );
  }
}
