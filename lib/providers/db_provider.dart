import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qrscanner/models/scan_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
export 'package:qrscanner/models/scan_models.dart';


class DBProvider {
  static Database? _database;
 
  static final DBProvider db = DBProvider._();
 
  DBProvider._();
 
  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }
 
  Future<Database> initDB() async {
    // path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);
 
    // crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
    });
  }

  Future<int> nuevoScan( ScanModel nuevoScan ) async {

    final db = await database;
    final res = await db!.insert('Scans', nuevoScan.toJson() );

    print(res);
    // Es el ID del último registro insertado;
    return res;
  }

  Future<ScanModel?> getScanById( int id ) async { ///SE AGREGO UN ? EN SCANMODEL

    final db  = await database;
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]); ///SE AGREGO UN ! EN DB

    return res.isNotEmpty
          ? ScanModel.fromJson( res.first )
          : null;
  }

   Future<List<ScanModel>> getTodosLosScans() async { ///VER DE DATOS TODOS

    final db  = await database;
    final res = await db!.query('Scans');

    return res.isNotEmpty
          ? res.map( (s) => ScanModel.fromJson(s) ).toList()
          : [];
  }

  Future<List<ScanModel>> getScansPorTipo( String tipo ) async { ///LISTA DE DATOS

    final db  = await database;
    final res = await db!.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'    
    ''');

    return res.isNotEmpty
          ? res.map( (s) => ScanModel.fromJson(s) ).toList()
          : [];
  }


  Future<int> updateScan( ScanModel nuevoScan ) async { ///ACTUALIZAR DE DATOS 1 A 1
    final db  = await database;
    final res = await db!.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [ nuevoScan.id ] );
    return res;
  }

  Future<int> deleteScan( int id ) async { ///ELIMINAR DE DATOS 1 A 1
    final db  = await database;
    final res = await db!.delete( 'Scans', where: 'id = ?', whereArgs: [id] );
    return res;
  }

  Future<int> deleteAllScans() async { ///ELIMINAR DE DATOS TODOS
    final db  = await database;
    final res = await db!.rawDelete('''
      DELETE FROM Scans    
    ''');
    return res;
  }
}