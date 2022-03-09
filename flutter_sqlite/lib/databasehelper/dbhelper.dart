// import 'dart:async';

// import 'package:flutter_sqlite/model/user_model.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:flutter_sqlite/databasehelper/dbhelper.dart';
// import 'dart:io' as io;

// class DbHelper {
//   static  Database _db;
//   // DATABASE NAME
//   static String DB_Name = 'test.db';
//   // TABLE NAME
//   static String Table_Name = 'name';

//   static int Version = 1;

//   static String C_Name = 'user_name';
//   static String C_phone = 'phone';
//   static String C_Email = 'email';
//   static String C_password = 'password';

//   Future<Database> get db async {
//     if (_db != null) {
//       return _db;
//     }
//     _db = await initDb();

//     return _db;
//   }

//   initDb() async {
//     io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, DB_Name);
//     var db = await openDatabase(path, version: Version, onCreate: _onCreate);
//     return db;
//   }

//   _onCreate(Database db, int intVersion) async {
//     //create table
//     await db.execute("CREATE TABLE $Table_Name ("
//         " $C_Name TEXT, "
//         " $C_phone TEXT, "
//         " $C_Email TEXT, "
//         " $C_password TEXT, "
//         " PRIMARY KEY ($C_Name)"
//         ")");
//   }

//   //CREATE SAVE USER
//   //CREATE USERMODEL CLASS
//   Future<UserModel> saveData(UserModel user) async {
//     var dbClient = await db;
//     user.user_Name =
//         (await dbClient.insert(Table_Name, user.toMap())) as String;
//     return user;
//   }
// }
