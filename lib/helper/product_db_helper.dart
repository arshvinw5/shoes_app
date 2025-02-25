import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shoes_app/model/products.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductDbHelper {
  static final _databaseName = 'product.db';
  static final _databaseVersion = 1;

  static final _table_products = 'products';

  static String? path;

  //reason to use singleton pattern is to avoid creating multiple database instance and less amoint of memory usage

  // private constructor to prevent creating multiple instances of database
  // with the help of named constructor _privateConstructor
  // we are creating a single instance of database
  // and making it available to the outside world with the "instance" variable
  // this is called singleton pattern
  ProductDbHelper._privateConstructor();

  // this is the single instance of database
  // with the help of this instance, we can access the database methods
  static final ProductDbHelper instance = ProductDbHelper._privateConstructor();

  static Database? _database;

  /// check whether database is created or not///

  Future get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  ////// initialize database with local file path////////

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //real = float
  //table name has been mentioned above

//on create for create table in database
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_table_products(id INTEGER PRIMARY KEY autoincrement, name TEXT, description TEXT, price REAL, imageUrl TEXT, quantity INTEGER)');
  }

  //to access the db file path
  static Future getDatabasePath() async {
    return getDatabasePath().then((value) {
      return path = value;
    });
  }

  //insert method to insert data in database
  //those methods are future methods because they are returning future and take times to access the database
  Future insertProduct(Products products) async {
    Database db = await instance.database;
    //import it from products.dart object
    return await db.insert(_table_products, Products.toMap(products),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Products>> getProductsList() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_table_products);
    print(maps);
    //this is loop through the list of maps and then add it to a list of products from db
    return Products.fromList(maps);
  }

  ///So, when combined, where and whereArgs form the complete
  ///WHERE clause: id = products.id. This tells the database to update
  ///only the row(s) where the id column matches the id of the Products
  /// object being updated.///

  Future<Products> updateProduct(Products products) async {
    //initialize database
    Database db = await instance.database;

    await db.update(_table_products, Products.toMap(products),
        where: 'id=?', whereArgs: [products.id]);
    return products;
  }

  Future deleteProduct(Products products) async {
    //initialize database
    Database db = await instance.database;
    var deleteProduct = await db
        .delete(_table_products, where: 'id=?', whereArgs: [products.id]);

    return deleteProduct;
  }
}
