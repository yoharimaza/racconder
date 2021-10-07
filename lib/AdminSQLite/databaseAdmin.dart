import 'dart:io';
import 'package:racconder/Entidades/EntidadProducto.dart';
import 'package:racconder/Entidades/entityHistoria.dart';
import 'package:racconder/Entidades/entityListaCompilar.dart';
import 'package:racconder/Entidades/entityMomento.dart';
import 'package:racconder/Entidades/entityVideo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAdmin {
  Database _database;
   initDatabase() async {
      _database=  await openDatabase(
        join(await getDatabasesPath(), 'database.db'),
     onCreate: (db, version) {
      db.execute(
        "CREATE TABLE productos(idProducto INTEGER PRIMARY KEY, nombreProducto TEXT, marcaProducto TEXT, presentacionProducto TEXT, descripcionProducto TEXT, cantidadProducto INTEGER, duracionProducto INTEGER, rutaImagen  TEXT)",
      );
      db.execute(
        "CREATE TABLE datamomento(idMomento INTEGER PRIMARY KEY,nombreMomento TEXT, pathMomento TEXT, colorMomento TEXT, isPredeterminado INTEGER)",
      );
      db.execute(
        "CREATE TABLE datavideo(idVideo INTEGER PRIMARY KEY,pathVideo TEXT, anio INTEGER,mes INTEGER,dia INTEGER, idMomento INTEGER,idHistoria INTEGER )",
      );
      db.execute(
        "CREATE TABLE listacompilar(idCompilar INTEGER PRIMARY KEY, idVideo INTEGER, idHistoria INTEGER)",
      );
     },
     version:1,
     );
     // print("BASE DE DATOS INICIADA");
   }

   Future<Database> get getDatabase async{
     return _database;
   }

  Future<int> insertarProducto(EntidadProducto entidadProducto) async{
    return await _database.insert('productos', entidadProducto.toMap());
  }

  Future<List<EntidadProducto>> obtenerTodosProductos() async{
    List<Map<String, dynamic>> results = await _database.query('productos');
    return results.map((map) => EntidadProducto.fromMap(map)).toList();
  }


 // UPDATE employeesSET lastname = 'Smith'WHERE employeeid = 3;
  updateVideo(int idHistoria, int idMomento, String pathVideo) async{
    print(await _database.rawUpdate('''
    UPDATE datavideo
    SET idMomento = ?,idHistoria = ? 
    WHERE pathVideo = ?
    ''',[idMomento,idHistoria, pathVideo]));
  }

  updateMomento(int idMomento, String nombreMomento, String pathMomento, String colorMomento) async{
    print(await _database.rawUpdate('''
    UPDATE datamomento
    SET nombreMomento = ?,pathMomento = ?,colorMomento = ? 
    WHERE idMomento = ?
    ''',[nombreMomento,pathMomento, colorMomento, idMomento]));
  }

  updateHistoria(int idHistoria, String nombreHistoria, String pathHistoria) async{
    print(await _database.rawUpdate('''
    UPDATE datahistoria
    SET nombreHistoria = ?,pathHistoria = ? 
    WHERE idHistoria = ?
    ''',[nombreHistoria, pathHistoria, idHistoria]));
  }

  deleteVideo(String pathVideo)async{
    print(await _database.rawDelete('''
    DELETE FROM datavideo  WHERE pathVideo = ?
    ''',[pathVideo]));
    await File(pathVideo).delete();
  }

  deleteMomento(int idMomento, String pathMomento)async{
    print(await _database.rawDelete('''
    DELETE FROM datamomento  WHERE idMomento = ?
    ''',[idMomento]));
    await File(pathMomento).delete();
  }

  deleteHistoria(int idHistoria, String pathHistoria)async{
    print(await _database.rawDelete('''
    DELETE FROM datahistoria  WHERE idHistoria = ?
    ''',[idHistoria]));
    //await File(pathHistoria).delete();
  }

  insertVideo(EntityVideo entityVideo) async{
       print( await _database.insert('datavideo', entityVideo.toMap()));
  }

  agregarALista(EntityListaCompilar entityListaCompilar) async{
    print( await _database.insert('listacompilar', entityListaCompilar.toMap()));
  }



Future<List<EntityVideo>> getAllVideo() async{
     List<Map<String, dynamic>> results = await _database.query('datavideo');
     return results.map((map) => EntityVideo.fromMap(map)).toList();
}

  Future<List<EntityHistoria>> getAllHistorias() async{
    List<Map<String, dynamic>> results = await _database.query('datahistoria');
    return results.map((map) => EntityHistoria.fromMap(map)).toList();
  }

  Future<List<EntityMomento>> getAllMomentos() async{
    List<Map<String, dynamic>> results = await _database.query('datamomento');
    return results.map((map) => EntityMomento.fromMap(map)).toList();
  }

  Future<List<EntityVideo>>getParaCompilar() async {
    List<Map<String, dynamic>> results = await _database.rawQuery("SELECT datavideo.idVideo, pathVideo, anio, mes ,dia , idMomento, datavideo.idHistoria FROM datavideo,listacompilar WHERE datavideo.idHistoria=listacompilar.idHistoria AND datavideo.idVideo=listaCompilar.idVideo");
    return results.map((map) => EntityVideo.fromMap(map)).toList();
  }

  Future<List<EntityVideo>>getByMomentoByHistoria(int idMomento,int idHistoria ) async {

    List<Map<String, dynamic>> results = await _database.rawQuery("SELECT *FROM datavideo WHERE idMomento =\'$idMomento\' AND idHistoria=\'$idHistoria\'");

    return results.map((map) => EntityVideo.fromMap(map)).toList();
  }
  Future<List<EntityVideo>>getByHistoria(int idHistoria ) async {

    List<Map<String, dynamic>> results = await _database.rawQuery("SELECT *FROM datavideo WHERE idHistoria=\'$idHistoria\'");

    return results.map((map) => EntityVideo.fromMap(map)).toList();
  }

  Future<List<EntityVideo>>getByfecha(String anio,String mes ) async {

    List<Map<String, dynamic>> results = await _database.rawQuery("SELECT *FROM datavideo WHERE anio =\'$anio\' AND mes=\'$mes\'");

    return results.map((map) => EntityVideo.fromMap(map)).toList();
  }


  Future<EntityHistoria> getHistoria(int idHistoria ) async {
    print(idHistoria);

    List<Map<String, dynamic>> results = await _database.rawQuery("SELECT *FROM datahistoria WHERE idHistoria ='$idHistoria'");
    print(results.isEmpty);
   List<EntityHistoria> list=results.map((map) => EntityHistoria.fromMap(map)).toList();

    return list.isEmpty ? null: list[0];
  }

  Future<EntityMomento> getMomento(int idMomento ) async {
    print(idMomento);

    List<Map<String, dynamic>> results = await _database.rawQuery("SELECT *FROM datamomento WHERE idMomento ='$idMomento'");
    print(results.isEmpty);
    List<EntityMomento> list=results.map((map) => EntityMomento.fromMap(map)).toList();
    return list.isEmpty ? null: list[0];
  }


  Future<EntityVideo> getVideoByPath(String path) async {
    List<Map<String, dynamic>> results = await _database.rawQuery("SELECT *FROM datavideo WHERE pathVideo ='$path'");
    List<EntityVideo> list=results.map((map) => EntityVideo.fromMap(map)).toList();
    return list.isEmpty ? null: list[0];
  }


  insertMomento(EntityMomento entityMomento)async{
    print( await _database.insert('datamomento',entityMomento.toMap()));
  }

  Future<int> insertHistoria(EntityHistoria entityHistoria) async{
     return await _database.insert('datahistoria',entityHistoria.toMap());
  }

}

