import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mygym_app/pages/admin/admin_home.dart';
import 'package:mygym_app/pages/client/client_home.dart';
import 'package:mygym_app/pages/home_page.dart';
import 'package:mygym_app/pages/login_page.dart';
import 'package:mygym_app/providers/courses_provider.dart';
import 'package:mygym_app/providers/local_storage_provider.dart';
import 'package:mygym_app/providers/login_provider.dart';
import 'package:mygym_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // se carga el env antes de correr el programa, como buena practica
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LocalStorageProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
      
      ],
      child: MaterialApp(
        title: 'Proyecto Gimnasio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/logout': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          // '/client': (context) => const ClientHome(),
          '/client': (context) => const ClientHome(),
          '/admin': (context) => const AdminHome(),
        },
        home: const HomePage(),
      ),
    );
  }
}

