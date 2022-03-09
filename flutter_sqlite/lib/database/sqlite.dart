import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase('test.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
      database.execute(
          "CREATE TABLLE user(id INTEGERR PRIMARY KEY AUTOINCREMENT NOT NULL,email TEXT,password TEXT)");
    });
  }

  //INSERT FUNCTION
  static Future<int> insertData(String title, String des) async {
    final database = await SQLHelper.db();
    var values = {"title": title, "description": des};
    int status = await database.insert("items", values);
    return status;
  }

  //GET DATA FUNSTION
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  //SAVE FUNSTION
  static Future<int> saveNotes(String title, String description) async {
    final db = await SQLHelper.db();
    final values = {'title': title, 'description': description};
    int status = await db.insert("items", values,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return status;
  }

  //UPDATE FUNSTION
  static Future<int> updateData(int id, String title, String des) async {
    final database = await SQLHelper.db();
    var values = {"title": title, "description": des};
    int status = await database
        .update("items", values, where: "id = ?", whereArgs: [id]);
    return status;
  }

  //DELETE FUNCTION
  static Future<int> deleteData(int id) async {
    final database = await SQLHelper.db();
    int status =
        await database.delete("items", where: "id = ?", whereArgs: [id]);
    return status;
  }

  static Future<user> ChekLogin(int id, String email, String password) async {
    final database = await SQLHelper.db();
    final values = await SQLHelper.rawQuery(
        "SETECT *FROM user WHERE email = '$email' and password = '$password'");

    if (values.length > 0) {
      return user.fromMap(values.first);
    }
    return null;
  }

  static rawQuery(String s) {}
}


// import 'package:sqflite/sqflite.dart' as sqLite;

// class SQLHelper {
//   static Future<sqLite.Database> db() async {
//     return sqLite.openDatabase("info.db", version: 1,
//         onCreate: (sqLite.Database database, int version) {
//       database.execute(
//           "CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT,description TEXT)");
//     });
//   }

// //INSERT FUNCTION
//   static Future<int> insertNoteData(String title, String description) async {
//     final db = await SQLHelper.db();

//     var values = {"title": title, "description": description};
//     return db.insert("note", values);
//   }  

//   // GET DATA FUNCTION
//   static Future<List<Map<String, dynamic>>> getAllData() async {
//     final db = await SQLHelper.db();
//     return db.query("note", orderBy: "id");
//   }
//   //UPDATE DATA

//   static Future<int> upDateData(
//       int id, String title, String description) async {
//     final db = await SQLHelper.db();
//     var values = {"title": title, "description": description};
//     return db.update("note", values, where: "id = ?", whereArgs: [id]);
//   }

//   //DELETE DATA
//   static Future<int> deleteData( 
//       int id) async {
//     final db = await SQLHelper.db();
//     return db.delete("note", where: "id = ?",whereArgs: [id]);
//   }
// }
