import 'package:flutter/material.dart';
import 'package:mygym_app/models/user_response.dart';
import 'package:mygym_app/providers/local_storage_provider.dart';
import 'package:mygym_app/providers/login_provider.dart';
import 'package:mygym_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
   final userProvider = context.watch<UserProvider>();
   final authProvider = context.watch<AuthProvider>();
   final localStorageProvider = context.read<LocalStorageProvider>();
   userProvider.loadPublicUserResponseList();
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Clientes", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, ), ),
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
          child: ListView.builder(
            itemCount: userProvider.userResponseList.length,
            itemBuilder: (context, index) {
              final user = userProvider.userResponseList[index];
              return ListTile(
                title: Center(
                  child: Column(
                    children: [
                      userBuilder(user, context),
                    ],
                  )),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => PersonaDetailsPage(persona: user)) 
                  // );
                },
              );
            }
          ),
        )
      )
    );
  }
}

Widget userBuilder(User user, BuildContext context){
  return Card(
      color: const Color.fromARGB(255, 23, 190, 154),
      shadowColor: const Color.fromARGB(255, 7, 61, 50),
      margin: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: SizedBox(
          height: 100,
          width: 200,
          child: Center(
              child: 
                Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text(
                      user.username,
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
                          child: const Text('Ver más', style: TextStyle(color: Colors.black),),
                        ),
                      )
            ],
                )
            )
        )
    );
}





// import 'package:flutter/material.dart';

// class ClientHome extends StatelessWidget {
//   const ClientHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Clientes"),
//         centerTitle: true,
//         leading: IconButton(onPressed: () => Navigator.pushReplacementNamed(context, '/logout'), icon: const Icon(Icons.logout)),
//       ),
//       body: const Center(
//         child: Text("Pantalla de Inicio de Cliente"),
//       ),
//     );
//   }
// }