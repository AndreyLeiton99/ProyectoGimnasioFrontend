import 'package:flutter/material.dart';
import 'package:mygym_app/providers/login_provider.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador"),
        centerTitle: true,
        leading: IconButton(onPressed: () {
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