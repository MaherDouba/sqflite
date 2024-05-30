
///import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' ;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//import 'package:sqflite_common/sqlite_api.dart';


class SqlDb {

  static Database? _db ; 
  
  Future<Database?> get db async {
      if (_db == null){
        _db  = await intialDb() ;
        return _db ;  
      }else {
        return _db ; 
      }
  }


intialDb() async {
  databaseFactory = databaseFactoryFfi;

  String databasepath = await getDatabasesPath() ; 
  String path = join(databasepath , 'new.db') ;   
  Database mydb = await openDatabase(path , onCreate: _onCreate , version: 1  , onUpgrade:_onUpgrade ) ;  
  return mydb ; 
}

_onUpgrade(Database db , int oldversion , int newversion )async {
 print("onUpgrade =====================================") ; 
  await db.execute('ALTER TABEL notes ADD COULMUN title TEXT ');
   await db.execute('ALTER TABEL notes ADD COULMUN color TEXT ');
}

_onCreate(Database db , int version) async {
  await db.execute('''
  CREATE TABLE "notes" (
    "id" AUTOINCREMENT INTEGER  NOT NULL PRIMARY KEY  , 
    "note" TEXT NOT NULL
  )
 ''') ;
 print(" onCreate =====================================") ; 

}

readData(String sql) async {
  Database? mydb = await db ; 
  List<Map> response = await  mydb!.rawQuery(sql);
  return response ; 
}
insertData(String sql) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.rawInsert(sql);
  return response ; 
}
updateData(String sql) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.rawUpdate(sql);
  return response ; 
}
deleteData(String sql) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.rawDelete(sql);
  return response ; 
}
mydeletedatabase()async{
String databasepath = await getDatabasesPath();
String path = join(databasepath , "new.db");
await deleteDatabase(path);
}
 

// SELECT 
// DELETE 
// UPDATE 
// INSERT 
 

}

