import 'package:flutter/material.dart';
import 'package:fortyseventen_mobile/model/stocks.dart';
import 'package:fortyseventen_mobile/util/dbhelper.dart';

DbHelper helper = DbHelper();

final List<String> choices = const <String>['Back', 'Remove'];

const menuBack = 'Back';
const menuRemove = 'Remove';

class StockDetails extends StatefulWidget {
  final Stocks stocks;
  StockDetails(this.stocks);

  @override
  _StockDetailsState createState() => _StockDetailsState(stocks);
}

class _StockDetailsState extends State<StockDetails> {
  Stocks stocks;
  _StockDetailsState(this.stocks);

  TextEditingController imageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController xxLargeQtyController = TextEditingController();
  TextEditingController xLargeQtyController = TextEditingController();
  TextEditingController largeQtyController = TextEditingController();
  TextEditingController mediumQtyController = TextEditingController();
  TextEditingController smallQtyController = TextEditingController();
  TextEditingController xSmallQtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final sizeX = MediaQuery.of(context).size.width;
    // final sizeY = MediaQuery.of(context).size.height;

    imageController.text = stocks.image;
    nameController.text = stocks.name;
    categoryController.text = stocks.category;
    xxLargeQtyController.text = stocks.xxLargeQty.toString();
    xLargeQtyController.text = stocks.xLargeQty.toString();
    largeQtyController.text = stocks.largeQty.toString();
    mediumQtyController.text = stocks.mediumQty.toString();
    smallQtyController.text = stocks.smallQty.toString();
    xSmallQtyController.text = stocks.xSmallQty.toString();

    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    Row title = Row(children: [Text('Add Stocks')]);
    if (stocks.name.length > 0) {
      title = Row(children: [Text('Update '), Text(stocks.name)]);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: title,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => select(value),
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 15),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: imageController,
                    style: textStyle,
                    onChanged: (value) => this.updateImage(),
                    decoration: InputDecoration(
                      labelText: 'Image link',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                child: TextField(
                  controller: nameController,
                  style: textStyle,
                  onChanged: (value) => this.updateName(),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: categoryController,
                    style: textStyle,
                    onChanged: (value) => this.updateCategory(),
                    decoration: InputDecoration(
                      labelText: 'Category',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              Row(children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 7, 15),
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: xxLargeQtyController,
                        style: textStyle,
                        onChanged: (value) => this.updateXXLargeQty(),
                        decoration: InputDecoration(
                          labelText: 'XXL',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 0, 15),
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: xLargeQtyController,
                        style: textStyle,
                        onChanged: (value) => this.updateXLargeQty(),
                        decoration: InputDecoration(
                          labelText: 'XL',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              Row(children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 7, 15),
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: largeQtyController,
                        style: textStyle,
                        onChanged: (value) => this.updateLargeQty(),
                        decoration: InputDecoration(
                          labelText: 'L',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 0, 15),
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: mediumQtyController,
                        style: textStyle,
                        onChanged: (value) => this.updateMediumQty(),
                        decoration: InputDecoration(
                          labelText: 'M',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              Row(children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 7, bottom: 10),
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: smallQtyController,
                        style: textStyle,
                        onChanged: (value) => this.updateSmallQty(),
                        decoration: InputDecoration(
                          labelText: 'S',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 7, bottom: 10),
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: xSmallQtyController,
                        style: textStyle,
                        onChanged: (value) => this.updateXSmallQty(),
                        decoration: InputDecoration(
                          labelText: 'XS',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
          Container(
            height: 45,
            child: ElevatedButton(
              onPressed: () => save(),
              child: Text(
                'SAVE',
                textScaleFactor: 1.4,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void select(String value) async {
    int result;

    switch (value) {
      case menuBack:
        Navigator.pop(context, true);
        break;

      case menuRemove:
        Navigator.pop(context, true);

        if (stocks.id == null) return;

        result = await helper.deleteStock(stocks.id);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text('Item has been removed'),
            content: Row(
              children: [
                Expanded(
                  child: Text('Item "' +
                    stocks.name +
                        '" with a total number of ' +
                        stocks.overAllQty.toString() +
                        ' stocks has been removed successfully',
                  ),
                ),
              ],
            ),
          );

          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;

      default:
    }
  }

  void save() {
    if (stocks.id != null) {
      helper.updateStock(stocks);
    } else {
      helper.insertStock(stocks);
    }

    Navigator.pop(context, true);
  }

  void updateImage() {
    stocks.image = imageController.text;
  }

  void updateName() {
    stocks.name = nameController.text;
  }

  void updateCategory() {
    stocks.category = categoryController.text;
  }

  void updateXXLargeQty() {
    stocks.xxLargeQty = int.parse(xxLargeQtyController.text);
  }

  void updateXLargeQty() {
    stocks.xLargeQty = int.parse(xLargeQtyController.text);
  }

  void updateLargeQty() {
    stocks.largeQty = int.parse(largeQtyController.text);
  }

  void updateMediumQty() {
    stocks.mediumQty = int.parse(mediumQtyController.text);
  }

  void updateSmallQty() {
    stocks.smallQty = int.parse(smallQtyController.text);
  }

  void updateXSmallQty() {
    stocks.xSmallQty = int.parse(xSmallQtyController.text);
  }
}
