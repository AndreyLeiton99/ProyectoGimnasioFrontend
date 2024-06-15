import 'package:flutter/material.dart';
import 'package:mygym_app/models/token.dart';
import 'package:mygym_app/services/local_database.dart';
 
class LocalStorageProvider extends ChangeNotifier {
  Future<void> save(Token token) async {
    LocalDatabase localDatabase = LocalDatabase();
    await localDatabase.saveToken(token);
    notifyListeners();
  }

  Future<void> update(Token token, Token updatedToken) async {
    LocalDatabase localDatabase = LocalDatabase();
    await localDatabase.updateToken(token, updatedToken);
    notifyListeners();
  }
  
  Future<Token?> getfirstToken() async {
    final localDatabase = LocalDatabase();
    final firstToken = await localDatabase.getfirstToken();
    notifyListeners(); 
    return firstToken;
  }

  Future<List<Token>> getAll() async {
    LocalDatabase localDatabase = LocalDatabase();
    final listTokens = await localDatabase.getallTokens();
    notifyListeners();
    return listTokens;
  }

  Future<int> getCount() async {
    LocalDatabase localDatabase = LocalDatabase();
    final listTokens = await localDatabase.getallTokens();
    notifyListeners();
    return listTokens.length;
  }

  Future<void> deleteToken() async {
    LocalDatabase localDatabase = LocalDatabase();
    await localDatabase.deleteFirstToken();
    notifyListeners();
  }
}
