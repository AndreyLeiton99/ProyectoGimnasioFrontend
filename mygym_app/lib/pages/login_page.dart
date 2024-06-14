import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mygym_app/models/login_response.dart';
import 'package:mygym_app/pages/admin/admin_home.dart';
import 'package:mygym_app/pages/client/client_home.dart';
import 'package:mygym_app/providers/login_provider.dart';
import 'package:mygym_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  List<String> rol = ['client', 'admin'];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Campo de texto para correo electrónico
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su correo electrónico';
                    } else if (!RegExp(r'^[\w-\.]+@[\w-\.]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                      return 'Formato de correo electrónico no válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo de texto para contraseña
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su contraseña';
                    } 
                    // else if (value.length < 8) {
                    //   return 'La contraseña debe tener al menos 8 caracteres';
                    // }
                    //  else if (!RegExp(r'[a-z]').hasMatch(value)) {
                    //   return 'La contraseña debe incluir al menos una letra minúscula';
                    // } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    //   return 'La contraseña debe incluir al menos una letra mayúscula';
                    // } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                    //   return 'La contraseña debe incluir al menos un número';
                    // } else if (!RegExp(r'[!?@#$%^&*()-_+=/|<>"`~.,{};:]').hasMatch(value)) {
                    //   return 'La contraseña debe incluir al menos un carácter especial';
                    // }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Botón de inicio de sesión
                ElevatedButton(
                  onPressed: _isLoading ? null : () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });

                      // Simular inicio de sesión (reemplazar con la lógica real)
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          _isLoading = false;
                          // Aqui implementar funcionalidad para detectar ROL

                          handleLogin(context, userProvider, _emailController, _passwordController);

                          // String rol = verificarRol();
                          // // TODO: cambiar esto para que verifique un inicio de sesion correcto y rol:
                          // rol = 'client';
                          // print('rol: $rol');
                          // if(rol == 'client') {
                          //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const ClientHome())));
                          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const UsersPage())));
                          // }else if(rol == 'admin'){
                          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const AdminHome())));
                          // }else{
                          //   // todo: aqui implementar mensaje de error de "acceso no autorizado"
                          // }


                        });
                      });
                    }
                  },
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Ingresar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleLogin(context, userProvider, email, password) async {
    print("Credenciales: ${email.text}    &    ${password.text}");
    // se pasan las credenciales al metodo en el provider para su verificacion
    final resultado = await userProvider.loginUser(email.text, password.text);

    if (resultado != null) {
      // Login successful!
      final user = resultado as VerifiedUser; // Cast to VerifiedUser
      print('USUARIO: ${user.user.username} verificado con exito');
      print('Token: ${user.jwt}');

      verificarRol(context, userProvider, user.jwt);

      // Update provider state and navigate or display success message
    } else {
      // En consola se imprime para debugging
      print('Login failed.');

      // Reiniciar los controladores de texto
      email.clear();
      password.clear();

      // Se le muestra mensaje del error al usuario
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error al iniciar sesión. Credenciales incorrectas. Intente nuevamente.', 
          style: TextStyle(fontSize: 18),),
      ));
    }
  }


  Future<void> verificarRol(context, userProvider, jwt) async {
    // List<String> rol = ['client', 'admin'];
    // Random random = Random();
    // int index = random.nextInt(rol.length);
    // // devuelve el rol, por ahora es random para hacer las pruebas
    // return rol[index];

    String role = await userProvider.getRole(jwt);

    print('role: $role');

    if(role == 'Public') {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const ClientHome())));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const UsersPage())));
    }else if(role == 'Authenticated'){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const AdminHome())));
    }else{
      // todo: aqui implementar mensaje de error de "acceso no autorizado"
    }

  }
}

