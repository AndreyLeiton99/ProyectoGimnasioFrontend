import 'dart:async';

import 'package:isar/isar.dart';
import 'package:mygym_app/models/token.dart';
import 'package:path_provider/path_provider.dart';
 
class LocalDatabase {
  late Future<Isar> db;
 
  LocalDatabase() {
    db = openDB();
  }
 
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([TokenSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }
 
  Future<bool> isTheCodeSaved(String token) async {
    final isar = await db;
    final Token? isCodeSaved =
        await isar.tokens.filter().jwtTokenEqualTo(token).findFirst();
    return isCodeSaved != null;
  }
 
  Future<void> saveToken(Token token) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.tokens.putSync(token));
  }
 
  Future<void> updateToken(Token token, Token updatedToken) async {
    final isar = await db;
    final token_ = await isar.tokens.filter().idEqualTo(token.id).findFirst();
    if (token_ != null) {
      token_.username = updatedToken.username;
      token_.jwtToken = updatedToken.jwtToken;
      isar.writeTxnSync(() => isar.tokens.putSync(token));
    }
  }

  Future<Token?> getfirstToken() async {
    final isar = await db;
    final tokens = await isar.tokens.where().findFirst();
      print("Username obtenido de ISAR: ${tokens?.username ?? 'No token found'}");
    return tokens;
  }

  Future<List<Token>> getallTokens() async {
    final isar = await db;
    return isar.tokens.where().findAll();
  }

  Future<void> deleteFirstToken() async {
    final isar = await db;
    final query = isar.tokens.where();
    final firstToken = await query.findFirst();
    if (firstToken != null) {
      await isar.writeTxn(() => isar.tokens.delete(firstToken.id!));
    }
  }

  // Added method to delete all tokens
  Future<void> deleteAllTokens() async {
    final isar = await db;
    await isar.writeTxn(() async {
        await isar.tokens.clear();
        // OR
        await isar.tokens.where().deleteAll();
      });
    }

}