import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile_pic.jpg'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'johndoe@example.com',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text('Editar Perfil'),
                      onPressed: () {
                        // Acción para editar perfil
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Progreso General',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProgressIndicator(
                    label: 'Courses Matriculados',
                    value: 0.8,
                    color: Colors.orange,
                  ),
                  ProgressIndicator(
                    label: 'Courses Completados',
                    value: 0.5,
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Notificaciones',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const NotificationList(),
              const SizedBox(height: 30),
              const Text(
                'Historial de Courses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const CourseHistoryList(),
              const SizedBox(height: 30),
              const Text(
                'Configuraciones',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Cambiar Contraseña'),
                onTap: () {
                  // Acción para cambiar contraseña
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Preferencias de Notificación'),
                onTap: () {
                  // Acción para preferencias de notificación
                },
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Soporte'),
                onTap: () {
                  // Acción para soporte
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressIndicator extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const ProgressIndicator({
    Key? key,
    required this.label,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            value: value,
            color: color,
          ),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        ListTile(
          leading: Icon(Icons.notification_important),
          title: Text('Nueva actualización en el Course X'),
        ),
        ListTile(
          leading: Icon(Icons.notification_important),
          title: Text('Clase cancelada en el Course Y'),
        ),
        // Agrega más notificaciones según sea necesario
      ],
    );
  }
}

class CourseHistoryList extends StatelessWidget {
  const CourseHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        ListTile(
          leading: Icon(Icons.check_circle),
          title: Text('Course A'),
          subtitle: Text('Completado'),
        ),
        ListTile(
          leading: Icon(Icons.check_circle),
          title: Text('Course B'),
          subtitle: Text('Completado'),
        ),
        // Agrega más Courses completados según sea necesario
      ],
    );
  }
}