import '../models/estudiante.dart';
import '../helpers/database_helper.dart';

class RegistroEstudianteController {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> registrarEstudiante(Estudiante estudiante) async {
    await _dbHelper.insertEstudiante(estudiante);
  }

  Future<List<Estudiante>> obtenerEstudiantes() async {
    return await _dbHelper.getEstudiantes();
  }
}
