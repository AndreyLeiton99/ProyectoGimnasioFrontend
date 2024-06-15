import 'package:flutter/material.dart';
import 'package:mygym_app/models/token.dart';
import 'package:mygym_app/providers/local_storage_provider.dart';
import 'package:mygym_app/providers/login_provider.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final localStorageProvider = context.read<LocalStorageProvider>();

    // Token currentUser = await localStorageProvider.getfirstToken();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador"),
        centerTitle: true,
        leading: IconButton(onPressed: () async {
          localStorageProvider.deleteToken();
          authProvider.logout();

          Navigator.pushReplacementNamed(context, '/logout');
        }, icon: const Icon(Icons.logout)),
      ),
      body: const Center(
        child: Text("Pantalla de Inicio de Administrador"),
      ),
    );
  }
}
