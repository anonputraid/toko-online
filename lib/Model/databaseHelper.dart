import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class databaseHelper {
  static const String dbName = "shopdb";
  static const String tableName = "keranjang";

  static Future<Database> createDatabase() async {
    return await openDatabase("$dbName", version: 2,
        onCreate: (db, version) async {
      await _createTable(db);
    });
  }

  static Future<void> _createTable(Database db) async {
    await db.execute(
      '''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          imgAssets TEXT,
          name_products TEXT,
          price TEXT,
          size TEXT,
          count TEXT
        )
      '''
    );
  }

  static Future<int> insertData(String imgAssets, String name_products, String price, String size, String count) async {
    try {
      final db = await createDatabase();
      final data = {
        'imgAssets': imgAssets,
        'name_products': name_products,
        'price': price,
        'size': size,
        'count': count,
      };

      final result = await db.insert(tableName, data);
      await db.close();
      return result;
    } catch (e) {
      return -1; // Return -1 if there is an error during insertion
    }
  }

   static Future<bool> resetTableData(String tableName) async {
    try {
      final db = await createDatabase();
      int rowsAffected = await db.delete(tableName);
      await db.close();

      print("Table '$tableName' data has been reset.");
      
      // Jika ada baris yang terpengaruh oleh penghapusan (rowsAffected > 0), berarti operasi berhasil.
      return rowsAffected > 0;
    } catch (e) {
      print("Error resetting table data: $e");
      return false; // Jika terjadi kesalahan, kembalikan nilai false.
    }
  }

  static Future<List<Map<String, dynamic>>> getTableSchema() async {
    try {
      final db = await createDatabase();
      final columns = await db.rawQuery('PRAGMA table_info($tableName)');
      await db.close();
      return columns;
    } catch (e) {
      return []; // Return an empty list if there is an error
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    try {
      final db = await createDatabase();
      final result = await db.query(tableName);
      await db.close();
      return result;
    } catch (e) {
      return []; // Return an empty list if there is an error
    }
  }

  static Future<int> deleteData(int id) async {
    try {
      final db = await createDatabase();
      final result = await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      await db.close();
      return result;
    } catch (e) {
      return -1; // Return -1 if there is an error during deletion
    }
  }

  static Future<bool> checkDatabase() async {
    try {
      final db = await createDatabase();
      await db.close();
      return true;
    } catch (e) {
      return false;
    }
  }
}
