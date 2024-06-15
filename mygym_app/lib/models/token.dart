import 'package:isar/isar.dart';
part 'token.g.dart';
//part 'token.g.dart'; // mismo nombre que la clase, ej: Product
// El archivo de arriba se va a generar solo una vez se ejecute el comando 'flutter pub run build_runner build'
// si se modifica algo de aqui, se tiene que volver a correr el 'flutter pub run build_runner build'

@collection // para indicarle a ISAR que lo siguiente va a ser una tabla
class Token {
  Id? id; // siempre va a necesitar un ID para ISAR
  String jwtToken;
  String username;

  // en este caso, se tuvo que modificar el "final" de los atributos para poder cambiarlos en ejecucion

  Token({required this.jwtToken, required this.username, Id? id});
}