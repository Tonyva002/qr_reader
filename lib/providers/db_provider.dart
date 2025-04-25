import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider{

  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

 Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }
  // Crea la base de datos con la tablas
  Future<Database> initDB() async{
   // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    //Crear la base de datos
    return await openDatabase(
        path,
        version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
          await db.execute('''
            CREATE TABLE Scans(
             id INTEGER PRIMARY KEY,
             type TEXT,
             value TEXT
            )
          ''');

      }
    );

  }

  // Inserta scans a la tabla
  Future<int> createScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());
    return res;
  }

  // Obtiene los scans por id
Future<ScanModel?> getScanById( int id) async {
   final db = await database;
   final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
   
   return res.isNotEmpty
       ? ScanModel.fromJson(res.first)
       : null;
}
  // Obtiene todos los Scans
  Future<List<ScanModel>?> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  // Obtiene los Scans por tipo
  Future<List<ScanModel>?> getScansForType( String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'type = ?', whereArgs: [type]);

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  // Actualizar Scan
  Future<int> updateScan( ScanModel newScan) async {
     final db = await database;
     final res = await db.update('Scans', newScan.toJson(), where: 'id = ?', whereArgs: [newScan.id]);
     return res;
  }

  // Eliminar Scan por id
  Future<int> deleteScan( int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // Eliminar todos los Scans
  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }


}