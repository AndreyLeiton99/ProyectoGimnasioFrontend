import 'package:flutter/material.dart';
import 'package:mygym_app/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto Gimnasio'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animación o imagen de carga
            const SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 30),

            // Texto de bienvenida
            const Text(
              '¡Bienvenido al Gimnasio!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Botón para iniciar sesión o registrarse
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de autenticación
                //Navigator.pushNamed(context, '/login');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const LoginPage())));
              },
              child: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
