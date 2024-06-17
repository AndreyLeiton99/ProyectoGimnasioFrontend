import 'package:flutter/material.dart';
import 'package:mygym_app/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 255, 191),
      body: WelcomeScreenOverlay(),
    );
  }
}

class WelcomeScreenOverlay extends StatelessWidget {
  const WelcomeScreenOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen del logo de la aplicación
            const SizedBox(
              width: 200,
              height: 200,
              child: Image(
                image: AssetImage('assets/logo.png'), // Asegúrate de que la ruta sea correcta
              ),
            ),
            const SizedBox(height: 100),

            // Texto de bienvenida
            const Text(
              '¡Bienvenido a tu aplicación\nde gestión de cursos!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 100),

            // Botón para iniciar sesión
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const LoginPage())));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 26, 28, 28),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
              ),
              child: const Text(
                'Iniciar Sesión',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
