import 'package:flutter/material.dart';
import 'package:mygym_app/models/login_response.dart';
import 'package:mygym_app/models/token.dart';
import 'package:mygym_app/models/user_response/user_model.dart';
import 'package:mygym_app/pages/admin/admin_home.dart';
import 'package:mygym_app/pages/client/client_home.dart';
import 'package:mygym_app/providers/courses_provider.dart';
import 'package:mygym_app/providers/local_storage_provider.dart';
import 'package:mygym_app/providers/login_provider.dart';
import 'package:mygym_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final double infoHeight = 364.0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: const Color.fromARGB(255, 27, 27, 27),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            const CourseHeaderImage(),
            CourseDetails(infoHeight: infoHeight, tempHeight: tempHeight),
            const LogoButton(),
          ],
        ),
      ),
    );
  }
}

class CourseHeaderImage extends StatelessWidget {
  const CourseHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.2,
          child: Image.asset(
            'assets/gym.jpeg',
            color: Color.fromARGB(70, 106, 115, 116), // Opacidad del 65%
            colorBlendMode: BlendMode.modulate,
          ),
        ),
      ],
    );
  }
}

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    super.key,
    required this.infoHeight,
    required this.tempHeight,
  });

  final double infoHeight;
  final double tempHeight;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final userProvider = context.watch<UserProvider>();
    final isarProvider = context.read<LocalStorageProvider>();
    final coursesProvider = context.read<CourseProvider>();

    // Lista de providers
    List<dynamic> providerList = [];
    providerList.add(authProvider); // 0
    providerList.add(userProvider); // 1
    providerList.add(isarProvider); // 2

    // cargamos la lista de usuarios actuales
    userProvider.loadPublicUserResponseList();
    coursesProvider.fetchCourses();

    return Positioned(
      top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: GymAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: GymAppTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                  minHeight: widget.infoHeight,
                  maxHeight: widget.tempHeight > widget.infoHeight
                      ? widget.tempHeight
                      : widget.infoHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 32.0, left: 18, right: 16),
                    child: Text(
                      'Inicio de Sesión\nMy Gym App',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                        letterSpacing: 0.27,
                        color: GymAppTheme.darkerText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 8, top: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Campo de texto para correo electrónico
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Correo electrónico',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su correo electrónico';
                              } else if (!RegExp(
                                      r'^[\w-\.]+@[\w-\.]+\.[a-zA-Z]{2,}$')
                                  .hasMatch(value)) {
                                return 'Formato de correo electrónico no válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40),
                      
                          // Campo de texto para contraseña
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su contraseña';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, bottom: 16, right: 16),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 75,
                          ),
                          ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      // Simular inicio de sesión (reemplazar con la lógica real)
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          _isLoading = false;
                                          // Aqui implementar funcionalidad para detectar ROL

                                          handleLogin(
                                              context,
                                              providerList,
                                              emailController,
                                              passwordController);
                                        });
                                      });
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 26, 28, 28),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 45),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text('Ingresar',
                                    style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LogoButton extends StatelessWidget {
  const LogoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
      right: 35,
      child: Card(
        color: const Color.fromARGB(255, 34, 35, 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 10.0,
        child: SizedBox(
          width: 60,
          height: 60,
          child: Center(
            child: Image.asset('assets/monogreen.png', height: 45),
          ),
        ),
      ),
    );
  }
}

Future<void> handleLogin(context, providerList, email, password) async {
  print("Credenciales: ${email.text}    &    ${password.text}");
  // se pasan las credenciales al metodo en el provider para su verificacion
  final resultado = await providerList[0].loginUser(email.text, password.text);

  if (resultado != null) {
    // Login successful!
    final user = resultado as VerifiedUser; // Cast to VerifiedUser
    print('USUARIO: ${user.user.username} verificado con exito');
    print('Token: ${user.jwt}');

    // Se guarda el Token en la DB de Isar
    Token token = Token(jwtToken: user.jwt, username: user.user.username);
    providerList[2].save(token);

    verificarRol(context, providerList, user);

    // Update provider state and navigate or display success message
  } else {
    // En consola se imprime para debugging
    print('Login failed.');

    // Reiniciar los controladores de texto
    email.clear();
    password.clear();

    // Se le muestra mensaje del error al usuario
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Error al iniciar sesión. Credenciales incorrectas. Intente nuevamente.',
        style: TextStyle(fontSize: 18),
      ),
    ));
  }
}

Future<void> verificarRol(context, providerList, VerifiedUser user) async {
  String role = await providerList[0].getRole(user.jwt);

  print('role: $role');

  // Aqui cargamos ya el User utilizando el ID del Usuario del response de login
  User userById = providerList[1].getUserById(user.user.id);

  if (role == 'Public') {
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const ClientHome())));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: ((context) => ClientHome(
                  initialUser: userById,
                ))));
  } else if (role == 'Authenticated') {
    // TODO: Agregar el parametro de usuario a AdminHome()
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => const AdminHome())));
  } else {
    // todo: aqui implementar mensaje de error de "acceso no autorizado"
  }
}
