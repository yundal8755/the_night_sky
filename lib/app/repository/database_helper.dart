// ignore_for_file: avoid_print

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      print('===== Database는 이미 존재 =====');
      return _database!;
    }
    print('===== Database는 Null! =====');
    _database = await initDatabase();
    return _database!;
  }

  //! initDatabase()
  /// SQflite 필수 Table 생성
  Future<Database> initDatabase() async {
    print('===== initDatabase 실행중 =====');
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'everyones_tone.db');

    return await openDatabase(path, version: 1, onCreate: _createTables);
  }


  //! 테이블 생성
  Future<void> _createTables(Database db, int version) async {
    print('===== _createTables 실행 완료 =====');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS user (
        userEmail TEXT PRIMARY KEY,
        nickname TEXT NOT NULL,
        profilePicUrl TEXT NOT NULL,
        dateCreated TEXT NOT NULL
      );
    ''');
    print('===== user Table 만들기 성공 =====');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS chat (
        chatId TEXT PRIMARY KEY,
        dateCreated TEXT,
        postUserNickname TEXT,
        postUserEmail TEXT,
        postUserProfilePicUrl TEXT,
        postTitle TEXT,
        replyUserNickname TEXT,
        replyUserEmail TEXT,
        replyUserProfilePicUrl TEXT
      );
    ''');
    print('===== chat Table 만들기 성공 =====');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS message (
        messageId TEXT PRIMARY KEY,
        chatId TEXT,
        audioUrl TEXT,
        dateCreated TEXT,
        userEmail TEXT,
        FOREIGN KEY (chatId) REFERENCES chat (chatId)
      );
    ''');
    print('===== message Table 만들기 성공 =====');
  }

  //! 데이터베이스 파일 삭제
  Future<void> deleteDatabaseFile() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'everyones_tone.db');

    if (await databaseExists(path)) {
      await deleteDatabase(path);
      print('Database file deleted successfully.');
      _database = null; // 데이터베이스 객체를 null로 설정하여 재생성을 준비합니다.
    } else {
      print('No database file found to delete.');
    }
  }

  //! 테이블 존재 여부 체크
  Future<void> checkTableExistence() async {
    final db = await database;
    List<String> tables = ['user', 'chat', 'message'];

    print('===== HomePage 진입 =====');

    for (String table in tables) {
      var res = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='$table'");
      if (res.isNotEmpty) {
        print('$table table exists');
      } else {
        print('$table table does not exist');
      }
    }
  }

  //! 데이터 조회
  Future<void> fetchTableData() async {
    final db = await database;
    List<String> tables = ['user', 'chat', 'message'];

    for (String table in tables) {
      List<Map<String, dynamic>> result = await db.query(table);
      if (result.isNotEmpty) {
        print('Data in $table: $result');
      } else {
        print('No data found in $table table.');
      }
    }
  }
}
