import 'package:flutter/services.dart';
import 'package:flutter_router_example/src/core/common/assets/asset_database.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite/sqflite.dart';

const dogTableName = 'dog';

class DatabaseHelper {
  static const databaseName = 'my_db.db';

  Future<Database> open() async => openDatabase(await getDatabasePath(), version: 1, onCreate: _createDB);

  Future _createDB(Database db, int version) async {
    var createQuery = await rootBundle.loadString(AssetDatabase.create);
    db.transaction((txn) async {
      for (final String query in splitQuery(createQuery)) {
        txn.execute(query);
      }
    });
  }

  static Future<String> getDatabasePath() async =>
      join((await path_provider.getApplicationDocumentsDirectory()).path, databaseName);
}

Iterable<String> splitQuery(String query) =>
    query.split(';').map((e) => e.trim().replaceAll('\r\n', '')).where((e) => e.isNotEmpty);
