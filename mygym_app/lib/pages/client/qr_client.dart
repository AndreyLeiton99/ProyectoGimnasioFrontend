import 'package:flutter/material.dart';
import 'package:mygym_app/models/login_response.dart';
import 'package:mygym_app/models/user_response.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

class QRPage extends StatelessWidget {
  const QRPage({super.key, this.initialUser, this.curso});

  final Usuario? initialUser; 
  final Curso? curso; 

  @override
  Widget build(BuildContext context) {
    String userUUID = generateUUIDFromCourseAndUser(curso?.nombreCurso, initialUser?.username, initialUser?.email);
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Asistencia"),
        centerTitle: true,
      ),
      body: Center(
        child: QrImageView(
          data: userUUID,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),

    );
  }
}

String generateUUIDFromCourseAndUser(String? courseName, String? username, String? email) {
  // Combine the strings
  final combinedString = "${courseName ?? ''}'|'${username ?? ''}'|'${email ?? ''}";

  // Checkeando UUID
  print("UUID: $combinedString");

  // Generate the UUID

  var uuid = const Uuid();
  final uuidString = uuid.v5(Uuid.NAMESPACE_URL, combinedString);
  

  return uuidString;
}