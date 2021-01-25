import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../model/stocks.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();

  String tblStocks = 'stocks';
  String colId = 'id';
  String colImage = 'image';
  String colName = 'name';
  String colCategory = 'category';
  String colXXLargeQty = 'xxLargeQty';
  String colXLargeQty = 'xLargeQty';
  String colLargeQty = 'largeQty';
  String colMediumQty = 'mediumQty';
  String colSmallQty = 'smallQty';
  String colXSmallQty = 'xSmallQty';

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'stocks_004.db';
    var dbStocks = await openDatabase(path, version: 1, onCreate: _createDb);

    return dbStocks;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tblStocks($colId INTEGER PRIMARY KEY, $colImage TEXT, ' +
            '$colName TEXT, $colCategory TEXT, $colXXLargeQty INTEGER, ' +
            '$colXLargeQty INTEGER, $colLargeQty INTEGER, $colMediumQty INTEGER, ' +
            '$colSmallQty INTEGER, $colXSmallQty INTEGER)');
  }

  Future<int> insertStock(Stocks stocks) async {
    Database db = await this.db;
    var result = await db.insert(tblStocks, stocks.toMap());
    return result;
  }

  Future<List> getStocks() async {
    Database db = await this.db;
    var result = await db.rawQuery('SELECT * FROM $tblStocks');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT (*) FROM $tblStocks'));
    return result;
  }

  Future<int> updateStock(Stocks stocks) async {
    var db = await this.db;
    var result = await db.update(tblStocks, stocks.toMap(),
        where: '$colId = ?', whereArgs: [stocks.id]);
    return result;
  }

  Future<int> deleteStock(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblStocks WHERE $colId = $id');
    return result;
  }
}
