import 'package:flutter/material.dart';
import 'package:mygym_app/models/user_response/course_model.dart';
import 'package:mygym_app/models/user_response/user_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../app_theme.dart';
import '../../utils/getWeekday.dart';
import 'package:intl/intl.dart';
import 'dart:core';

class QRPage extends StatelessWidget {
  const QRPage({super.key, this.initialUser, this.courses});

  final User? initialUser;
  final Course? courses;

  final double infoHeight = 364.0;

  @override
  Widget build(BuildContext context) {
    final Weekday util = Weekday();
    final int? weekday = courses?.date.weekday;
    final String courseWeekday = util.getDayName(weekday);

    final String courseHour = DateFormat('h:mm a').format(courses!.date.toLocal());

    String userUUID = generateUUIDFromCourseAndUser(
        courses?.courseName, initialUser?.username, initialUser?.email);

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
            CourseDetails(
                infoHeight: infoHeight,
                tempHeight: tempHeight,
                userUUID: userUUID,
                course: courses,
                courseWeekday: courseWeekday,
                courseHour: courseHour),
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
            color: const Color.fromARGB(70, 106, 115, 116), // Opacidad del 65%
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
    required this.userUUID,
    required this.course,
    required this.courseWeekday,
    required this.courseHour,
  });

  final double infoHeight;
  final double tempHeight;

  final String userUUID;
  final Course? course;

  final String courseWeekday;
  final String courseHour;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 18, right: 16),
                    child: Text(
                      'Información del Curso\nCurso: ${widget.course!.courseName}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                        letterSpacing: 0.27,
                        color: GymAppTheme.darkerText,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 35, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.courseWeekday,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            letterSpacing: 0.27,
                            color: GymAppTheme.darkerText,
                          ),
                        ),
                        Text(
                          widget.courseHour,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            letterSpacing: 0.27,
                            color: GymAppTheme.darkerText,
                          ),
                        ),
                        Text(
                          '${widget.course?.description}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            letterSpacing: 0.27,
                            color: GymAppTheme.darkerText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, bottom: 5, top: 5),
                      child: Center(
                        child: QrImageView(
                          data: widget.userUUID,
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 25, left: 16, bottom: 16, right: 16),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 26, 28, 28),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 45),
                            ),
                            child: const Text('Atrás',
                                style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
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

String generateUUIDFromCourseAndUser(
    String? courseName, String? username, String? email) {
  // Combine the strings
  final combinedString =
      "${courseName ?? ''}'|'${username ?? ''}'|'${email ?? ''}";

  // Checkeando UUID
  print("UUID: $combinedString");

  // Generate the UUID

  var uuid = const Uuid();
  final uuidString = uuid.v5(Uuid.NAMESPACE_URL, combinedString);

  return uuidString;
}
