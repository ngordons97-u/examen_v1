import 'package:flutter/material.dart';
import '../controllers/registro_estudiante_controller.dart';
import '../models/estudiante.dart';

class ListadoEstudiantesView extends StatefulWidget {
  const ListadoEstudiantesView({super.key});

  @override
  State<ListadoEstudiantesView> createState() => _ListadoEstudiantesViewState();
}

class _ListadoEstudiantesViewState extends State<ListadoEstudiantesView> {
  final controller = RegistroEstudianteController();
  late Future<List<Estudiante>> estudiantesFuture;

  @override
  void initState() {
    super.initState();
    estudiantesFuture = controller.obtenerEstudiantes(); // Cargar estudiantes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Estudiantes'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Estudiante>>(
        future: estudiantesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay estudiantes registrados.'));
          } else {
            final estudiantes = snapshot.data!;
            return ListView.builder(
              itemCount: estudiantes.length,
              itemBuilder: (context, index) {
                final estudiante = estudiantes[index];
                return ListTile(
                  title: Text(estudiante.nombres),
                  subtitle: Text(
                    '* Edad: ${estudiante.edad} \n* Fecha: ${estudiante.fecha}\n* Ciudad: ${estudiante.ciudad} \n* Valor de Curso: ${estudiante.valorCurso} \n* Cuota Inicial: ${estudiante.cuotaInicial} \n* Cuota Final: ${estudiante.cuotaMensual}',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
