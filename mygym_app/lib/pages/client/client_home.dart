import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mygym_app/models/user_response/user_model.dart'; // Importa el modelo de Course
import 'package:mygym_app/pages/client/courses_complete_list_page.dart';
import 'package:mygym_app/providers/courses_provider.dart';
import 'package:mygym_app/providers/local_storage_provider.dart';
import 'package:mygym_app/providers/login_provider.dart';
import 'package:mygym_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';
import '../../models/user_response/course_model.dart';
import '../../models/course_response/course_response.dart';
import '../../widgets/course_info_card.dart';
import '../../widgets/title_view.dart';
import 'courses_list_page.dart';
import 'qr_client.dart';

class ClientHome extends StatelessWidget {
  const ClientHome({super.key, this.initialUser});

  final User? initialUser;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final authProvider = context.watch<AuthProvider>();
    final courseProvider = context.watch<CourseProvider>();
    final localStorageProvider = context.read<LocalStorageProvider>();

    // Lista de providers
    List<dynamic> providerList = [];
    providerList.add(authProvider); // 0
    providerList.add(userProvider); // 1
    providerList.add(courseProvider); // 2

    // se cargan las listas de modelos
    userProvider.loadPublicUserResponseList();
    //courseProvider.loadCourseResponseList();

    //courseProvider.fetchCourses();

    //List<Course> totalCourses = courseProvider.getCourseList();
    int totalCourses = courseProvider.courses.length;

    return Container(
      color: GymAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                _buildAppBar(
                    context, initialUser, authProvider, localStorageProvider),
                Expanded(
                  child: _buildMainListViewUI(context, userProvider, courseProvider, totalCourses),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, User? initialUser,
      AuthProvider authProvider, LocalStorageProvider localStorageProvider) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: GymAppTheme.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: GymAppTheme.grey.withOpacity(0.4),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).padding.top),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            initialUser != null
                                ? initialUser.username
                                : 'Bienvenido/a cliente',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontFamily: GymAppTheme.fontName,
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              letterSpacing: 1.2,
                              color: GymAppTheme.darkerText,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 38,
                        width: 38,
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          onTap: () async {
                            await localStorageProvider.deleteToken();
                            authProvider.logout();
                            Navigator.pushReplacementNamed(context, '/logout');
                          },
                          child: const Center(
                            child: Icon(
                              Icons.logout,
                              color: GymAppTheme.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Course> filterCoursesByWeekday(List<Course> courses) {
    // Obtener el día de la semana actual
    int todayWeekday = DateTime.now().weekday;

    // Filtrar los cursos que ocurren en el día de la semana actual
    return courses.where((course) => course.date.weekday == todayWeekday).toList();
  }

  Widget _buildMainListViewUI(BuildContext context, UserProvider userProvider, CourseProvider courseProvider, totalCourses) {
    List<CourseComplete> allCourses = courseProvider.courses;
    return FutureBuilder<List<Course>>(
      future: userProvider.getCoursesForUser(initialUser!.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final courses = snapshot.data!;
          List<Course> filteredCourses = filterCoursesByWeekday(courses);
          return ListView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: 10 + MediaQuery.of(context).padding.bottom,
            ),
            children: [
              _buildTitleView('Mis Cursos', 'Ver más'),
              _buildCourseInfoCard(courses, totalCourses),
              _buildTitleView('Cursos de hoy', 'Ver Todos'),
              _buildCoursesCarousel(filteredCourses, context),
              _buildViewAllCoursesButton(context, courses),
              _buildTitleView('Cursos disponibles para matrícula', 'Ver Todos'),
              // Hacer lista de courses en los que no estoy matriculado
              _buildCoursesCompleteCarousel(allCourses, context),
              _buildViewAllCoursesCompleteButton(context, allCourses),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error cargando usuarios'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildCoursesCompleteCarousel(List<CourseComplete> courses, BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseCompleteBuilder(course, context, initialUser);
        },
      ),
    );
  }

  Widget _buildCoursesCarousel(List<Course> courses, BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseBuilder(course, context, initialUser);
        },
      ),
    );
  }

  Widget _buildViewAllCoursesButton(BuildContext context, List<Course> courses) {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListViewCoursesPage(
                    courses: courses,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 190, 154),
            ),
            child: const Text('Ver todos los cursos',
                style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildViewAllCoursesCompleteButton(BuildContext context, List<CourseComplete> courses) {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListViewCoursesCompletePage(
                    courses: courses,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 190, 154),
            ),
            child: const Text('Ver todos los cursos',
                style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTitleView(String title, String subtitle) {
    return TitleView(
      titleTxt: title,
      subTxt: subtitle,
    );
  }

  Widget CourseBuilder(Course course, BuildContext context, User? initialUser) {
    final List<Color> colorList = [
      Colors.red[400]!,
      Colors.blue[400]!,
      Colors.green[400]!,
      Colors.orange[400]!,
      Colors.purple[400]!,
      Colors.yellow[400]!,
      Colors.pink[400]!,
      Colors.cyan[400]!,
      Colors.indigo[400]!,
    ];
    
    Color cardColor;
    // Generar un índice aleatorio
    final Random random = Random();
    int randomIndex = random.nextInt(colorList.length);
    // Asignar un color aleatorio de la lista
    cardColor = colorList[randomIndex];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRPage(
              courses: course,
              initialUser: initialUser,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 130,
        child: Stack(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: cardColor.withOpacity(0.6),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: <Color>[
                      cardColor,
                      cardColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(54.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 54, left: 16, right: 16, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        course.courseName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: GymAppTheme.fontName,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: GymAppTheme.white,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Día: ${getDayName(course.date.weekday)} \nCapacidad: ${course.capacity} \nInstructor: ', // Ejemplo de información adicional
                                style: const TextStyle(
                                  fontFamily: GymAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  letterSpacing: 0.2,
                                  color: GymAppTheme.white,
                                ),
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
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: GymAppTheme.nearlyWhite.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const Positioned(
              top: 0,
              left: 8,
              child: SizedBox(
                width: 80,
                height: 80,
                child: Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CourseCompleteBuilder(CourseComplete course, BuildContext context, User? initialUser) {
    Color cardColor;
    switch (course.nombreCurso) {
      case 'Yoga':
        cardColor = Colors.blue[400]!;
        break;
      case 'Pilates':
        cardColor = Colors.green[400]!;
        break;
      case 'Nutrición':
        cardColor = Colors.orange[400]!;
        break;
      default:
        cardColor = Colors.grey[400]!;
        break;
    }

    return GestureDetector(
      onTap: () {
        // Con los cursos sin matricular, no hay accion de nada
      },
      child: SizedBox(
        width: 130,
        child: Stack(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: cardColor.withOpacity(0.6),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: <Color>[
                      cardColor,
                      cardColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(54.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 54, left: 16, right: 16, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        course.nombreCurso,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: GymAppTheme.fontName,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: GymAppTheme.white,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Día: ${getDayName(course.date.weekday)} \nCapacidad: ${course.capacity} \nInstructor: ', // Ejemplo de información adicional
                                style: const TextStyle(
                                  fontFamily: GymAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  letterSpacing: 0.2,
                                  color: GymAppTheme.white,
                                ),
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
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: GymAppTheme.nearlyWhite.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const Positioned(
              top: 0,
              left: 8,
              child: SizedBox(
                width: 80,
                height: 80,
                child: Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Actividades',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Perfil',
        ),
      ],
    );
  }

  Widget _buildCourseInfoCard(List<Course> courses, int totalCourses) {
    return CourseInfoCard(courses: courses, totalCourses: totalCourses,);
  }

  String getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return 'Día desconocido';
    }
  }
}
