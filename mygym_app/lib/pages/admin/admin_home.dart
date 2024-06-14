import 'package:flutter/material.dart';
import 'package:mygym_app/pages/users_page.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador"),
        centerTitle: true,
        leading: IconButton(onPressed: () => Navigator.pushReplacementNamed(context, '/logout'), icon: const Icon(Icons.logout)),
      ),
      body: const Center(
        child: Text("Pantalla de Inicio de Administrador"),
        // child: UsersPage(),
      ),
    );
  }
}