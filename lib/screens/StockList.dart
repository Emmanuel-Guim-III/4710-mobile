import 'package:flutter/material.dart';
import 'package:fortyseventen_mobile/model/stocks.dart';
import 'package:fortyseventen_mobile/util/dbhelper.dart';
import 'package:fortyseventen_mobile/screens/StockDetails.dart';

class StockList extends StatefulWidget {
  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  DbHelper _helper = DbHelper();
  List<Stocks> _stocks;
  int _count = 0;
  TextStyle _textStyle;
  String dropdownValue = 'Stocks high to low';

  @override
  Widget build(BuildContext context) {
    _textStyle = Theme.of(context).textTheme.headline6;

    if (_stocks == null) {
      _stocks = List<Stocks>();
      _getStocks();
    }

    return Scaffold(
      body: Column(
        children: [_searchBar(), _sortButton(), _stockListItems()],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _navigateToStockDetails(Stocks('', '', '', 0, 0, 0, 0, 0, 0));
        },
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
      child: Container(
        height: 50,
        child: TextField(
          style: _textStyle,
          onChanged: (value) => _filterSearchResults(value),
          decoration: InputDecoration(
            labelText: 'Search',
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  void _filterSearchResults(String query) {
    List<Stocks> dummyStockList = List<Stocks>();
    dummyStockList.addAll(List<Stocks>.from(_stocks));

    if (query.isNotEmpty) {
      List<Stocks> stocksList = List<Stocks>();

      dummyStockList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          stocksList.add(item);
        }
      });

      setState(() {
        _stocks = List<Stocks>.from(stocksList);
        _count = stocksList.length;
      });
    } else {
      _getStocks();
    }
  }

  _sortButton() {
    return Container(
      width: 165,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.sort),
        iconSize: 24,
        elevation: 16,
        isExpanded: true,
        underline: Container(
          height: 2,
        ),
        onChanged: (value) => _sortStockList(value),
        items: <String>[
          'Stocks high to low',
          'Stocks low to high',
          'Name A to Z',
          'Name Z to A'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  _stockListItems() {
    return Expanded(
      child: ListView.builder(
        itemCount: _count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(this._stocks[position].image),
                    ),
                  ),
                ),
              ),
              title: Text(
                this._stocks[position].name,
                textScaleFactor: 1.15,
              ),
              subtitle: _sizesAvailable(this._stocks[position]),
              trailing: Text(
                this._stocks[position].overAllQty.toString(),
                textScaleFactor: 1.75,
              ),
              onTap: () => _navigateToStockDetails(this._stocks[position]),
            ),
          );
        },
      ),
    );
  }

  void _getStocks() {
    final dbFuture = _helper.initializeDb();
    dbFuture.then((result) {
      final stocksFuture = _helper.getStocks();
      stocksFuture.then((result) {
        List<Stocks> stockList = List<Stocks>();

        for (int i = 0; i < result.length; i++) {
          stockList.add(Stocks.fromObject(result[i]));
        }

        setState(() {
          _stocks = stockList;
          _count = result.length;
        });
      });
    });
  }

  void _navigateToStockDetails(Stocks stocks) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StockDetails(stocks)),
    );

    if (result == true) {
      _getStocks();
    }
  }

  Text _sizesAvailable(item) {
    List<String> sizes = [];

    if (item.xxLargeQty > 0) {
      sizes.add('XXL  ');
    }
    if (item.xLargeQty > 0) {
      sizes.add('XL  ');
    }
    if (item.largeQty > 0) {
      sizes.add('L  ');
    }
    if (item.mediumQty > 0) {
      sizes.add('M  ');
    }
    if (item.smallQty > 0) {
      sizes.add('S  ');
    }
    if (item.xSmallQty > 0) {
      sizes.add('XS  ');
    }

    return Text(sizes.join().toString(),
        style: TextStyle(fontWeight: FontWeight.bold));
  }

  void _sortStockList(String newValue) {
    setState(() {
      dropdownValue = newValue;
    });

    switch (newValue) {
      case 'Stocks high to low':
        _stocks.sort((a, b) => a.overAllQty.compareTo(b.overAllQty));
        _stocks = _stocks.reversed.toList();
        break;

      case 'Stocks low to high':
        _stocks.sort((a, b) => a.overAllQty.compareTo(b.overAllQty));
        break;

      case 'Name A to Z':
        _stocks.sort((a, b) => a.name.compareTo(b.name));
        break;

      case 'Name Z to A':
        _stocks.sort((a, b) => a.name.compareTo(b.name));
        _stocks = _stocks.reversed.toList();
        break;
      default:
    }
  }
}
