import 'package:flutter/material.dart';
import 'package:mygym_app/models/user_response/course_model.dart';
import 'package:mygym_app/models/user_response/user_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

class QRPage extends StatelessWidget {
  const QRPage({super.key, this.initialUser, this.courses});

  final User? initialUser; 
  final Course? courses; 

  @override
  Widget build(BuildContext context) {
    String userUUID = generateUUIDFromCourseAndUser(courses?.courseName, initialUser?.username, initialUser?.email);
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Attendance"),
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