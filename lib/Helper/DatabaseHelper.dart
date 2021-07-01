import 'package:flutter_web_test/ModelClass/ModelCartList.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableCart = 'CartItems';
  final String columnId = 'id';
  // ignore: non_constant_identifier_names
  final String columnProduct_ID = 'product_id';
  // ignore: non_constant_identifier_names
  final String columnUnit_Price = 'unit_price';
  final String columnDiccount = 'discount_price';
  final String columnUnit = 'unit';

  // ignore: non_constant_identifier_names
  final String columnUser_ID = 'user_id';
  // ignore: non_constant_identifier_names
  final String columnStore_ID = 'shop_id';
  // ignore: non_constant_identifier_names
  final String columnTotal_Quantity = 'total_quantity';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cartitemstemp.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableCart($columnId INTEGER PRIMARY KEY, $columnProduct_ID TEXT, $columnUnit_Price TEXT, $columnDiccount TEXT , $columnUnit TEXT, $columnUser_ID TEXT, $columnStore_ID TEXT, $columnTotal_Quantity TEXT )');
  }

  Future<int> saveUpdateCartItem(Map cartItemJson) async {
    var dbClient = await db;
    var cartItem = new CartItems.fromJson(cartItemJson);
    List<Map> result = await dbClient.query(tableCart,
        columns: [
          columnId,
          columnProduct_ID,
          columnUnit_Price,
          columnDiccount,
          columnUnit,
          columnUser_ID,
          columnStore_ID,
          columnTotal_Quantity
        ],
        where: '$columnProduct_ID = ?',
        whereArgs: [cartItem.productId]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
    var isAvailable = false;
    if (result.length > 0) {
      isAvailable = true;
    }
    print('Item Add Into Cart $cartItemJson');
    var resultFinal = 0;
    if (isAvailable) {
      var cartItemTemp = new CartItems.fromJson(result.first);
      cartItemTemp.totalQuantity = (int.parse(cartItemTemp.totalQuantity) +
              int.parse(cartItemJson['total_quantity']))
          .toString();
      resultFinal = await dbClient.update(tableCart, cartItemTemp.toJson(),
          where: "$columnId = ?", whereArgs: [cartItemTemp.id]);
    } else {
      resultFinal = await dbClient.insert(tableCart, cartItem.toNewJson());
    }

    return resultFinal;
  }

  Future<int> saveCartItem(CartItems cartItem) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableCart, cartItem.toJson());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');

    return result;
  }

  Future<List<CartItems>> getAllCartItems() async {
    var dbClient = await db;
    var result = await dbClient.query(tableCart, columns: [
      columnId,
      columnProduct_ID,
      columnUnit_Price,
      columnDiccount,
      columnUnit,
      columnUser_ID,
      columnStore_ID,
      columnTotal_Quantity,
    ]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    List<CartItems>  locaCartItems = new List();

    result.forEach((element) {
      locaCartItems.add(new CartItems.fromJson(element));
    });

    return locaCartItems;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableCart'));
  }

Future<double> getCartTotalAmount() async {
      var dbClient = await db;
    var result = await dbClient.query(tableCart, columns: [
      columnId,
      columnProduct_ID,
      columnUnit_Price,
      columnDiccount,
      columnUnit,
      columnUser_ID,
      columnStore_ID,
      columnTotal_Quantity,
    ]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    double totalAmount = 0;

    result.forEach((element) {
      var item = new CartItems.fromJson(element);
      print(element);
      totalAmount = totalAmount + (double.parse(item.unitPrice) * double.parse(item.totalQuantity));
    });
    print("Total Amount for AppBar Widget ==> ${totalAmount}");
    return totalAmount;
  }

  Future<CartItems> getCartItem(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableCart,
        columns: [
          columnId,
          columnProduct_ID,
          columnUnit_Price,
          columnDiccount,
          columnUnit,
          columnUser_ID,
          columnStore_ID,
          columnTotal_Quantity
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new CartItems.fromJson(result.first);
    }

    return null;
  }

  Future<String> getCartItemQuantity(String productId) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableCart,
        columns: [
          columnId,
          columnProduct_ID,
          columnUnit_Price,
          columnDiccount,
          columnUnit,
          columnUser_ID,
          columnStore_ID,
          columnTotal_Quantity
        ],
        where: '$columnProduct_ID = ?',
        whereArgs: [productId]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      var cartItem = new CartItems.fromJson(result.first);
      if(cartItem.totalQuantity == null){
        return '';
      }
      return cartItem.totalQuantity;
    }
    return "";
  }

  Future<int> deleteCartItem(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableCart, where: '$columnId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }
  //Delete Selected Product From Cart
  Future<int> deleteListCartItem(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableCart, where: '$columnProduct_ID = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future<int> deleteAllCartItem(int id) async {

    var dbClient = await db;
    return await dbClient
        .delete(tableCart, where: '$columnUser_ID = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }


  Future<int> updateCartItem(CartItems cartProduct) async {
    var dbClient = await db;
    return await dbClient.update(tableCart, cartProduct.toJson(),
        where: "$columnId = ?", whereArgs: [cartProduct.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnTitle = \'${note.title}\', $columnDescription = \'${note.description}\' WHERE $columnId = ${note.id}');
  }

  /*Future<String> getItems(String productID)
  async {
    var Result = "";
     await getCartItemQuantity(productID).then((value) {
      if(value != null)
      {
        Result = value;
      }
    });
    return Result;
  }*/

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
