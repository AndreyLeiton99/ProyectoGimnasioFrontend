import 'package:flutter/material.dart';
import 'package:mygym_app/models/login_response.dart';
import 'package:mygym_app/models/user_response.dart';
import 'package:mygym_app/providers/local_storage_provider.dart';
import 'package:mygym_app/providers/login_provider.dart';
import 'package:mygym_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  //! Se pone el parametro opcional initialUser para pasarle el usuario actual al componente
  const UsersPage({super.key, this.initialUser});

  // TODO: Siempre verificar si el initialUser no es null
  final Usuario? initialUser; 

  @override
  Widget build(BuildContext context) {
   final userProvider = context.watch<UserProvider>();
   final authProvider = context.watch<AuthProvider>();
   final localStorageProvider = context.read<LocalStorageProvider>();
   userProvider.loadPublicUserResponseList();
    return  Scaffold(
      appBar: AppBar(
        title: Text('${initialUser != null ? initialUser!.username : 'Bienvenido/a cliente'} ',
          style: const TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold, ), ),
        centerTitle: true,
        leading: IconButton(onPressed: () async {
          localStorageProvider.deleteToken();
          authProvider.logout();
          // Si el usuario selecciona el icono de Logout, cierra sesion y borra credenciales
          Navigator.pushReplacementNamed(context, '/logout');
        }, icon: const Icon(Icons.logout)),
        backgroundColor: const Color.fromARGB(255, 23, 190, 154),
        toolbarHeight: 70,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),

          child: FutureBuilder<List<Curso>>(
            future: userProvider.getCoursesForUser(initialUser!.id), // Fetch cursos
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final cursos = snapshot.data!;
                // Display users in a ListView
                return ListView.builder(
                  itemCount: cursos.length,
                  itemBuilder: (context, index) {
                    final curso = cursos[index];
                    // TODO: Aqui se reemplaza el disenio de la tarjeta
                    return userBuilder(curso, context);
                  },
                );
              } else if (snapshot.hasError) {
                print('Error loading users: ${snapshot.error}');
                return const Center(child: Text('Error cargando usuarios'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
      )
    );
  }
}

// TODO: Componente para mostrar los disenios
Widget userBuilder(Curso curso, BuildContext context){
  return Card(
      color: const Color.fromARGB(255, 23, 190, 154),
      shadowColor: const Color.fromARGB(255, 7, 61, 50),
      margin: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: SizedBox(
          height: 200,
          width: 150,
          child: Center(
              child: 
                Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text(
                      curso.nombreCurso,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: ElevatedButton(
                          onPressed: () {
                          //   Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => PersonaDetailsPage(persona: user)) 
                          // );
                          },
                          child: const Text('Ver QR', style: TextStyle(color: Colors.black, fontSize: 15),),
                        ),
                      )
            ],
                )
            )
        )
    );
}
