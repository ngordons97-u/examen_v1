import 'package:flutter/material.dart';
import '../controllers/registro_estudiante_controller.dart';
import '../models/estudiante.dart';
import '../views/listado_estudiantes_view.dart';

class RegistroEstudianteView extends StatefulWidget {
  const RegistroEstudianteView({super.key});

  @override
  State<RegistroEstudianteView> createState() => _RegistroEstudianteViewState();
}

class _RegistroEstudianteViewState extends State<RegistroEstudianteView> {
  final _formKey = GlobalKey<FormState>();
  final controller = RegistroEstudianteController();

  final TextEditingController nombresController = TextEditingController();
  final TextEditingController edadController = TextEditingController();
  DateTime? fechaSeleccionada;
  final TextEditingController paisController = TextEditingController();
  final TextEditingController ciudadController = TextEditingController();
  final TextEditingController cuotaInicialController = TextEditingController();
  final TextEditingController cuotaMensualController = TextEditingController();

  final double valorCurso = 1500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registro de estudiantes",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(nombresController, 'Nombres'),
              _buildTextField(
                edadController,
                'Edad',
                keyboardType: TextInputType.number,
              ),
              _buildDatePicker(context),
              _buildTextField(paisController, 'País'),
              _buildTextField(ciudadController, 'Ciudad'),
              _buildTextField(
                cuotaInicialController,
                'Cuota inicial',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                cuotaMensualController,
                'Cuota mensual',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registrar,
                child: const Text('Registrar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListadoEstudiantesView(),
                    ),
                  );
                },
                child: const Text('Ver Registros'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              fechaSeleccionada == null
                  ? 'Seleccione una fecha'
                  : 'Fecha: ${fechaSeleccionada!.toLocal().toString().split(' ')[0]}',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              DateTime? fecha = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (fecha != null) {
                setState(() => fechaSeleccionada = fecha);
              }
            },
          ),
        ],
      ),
    );
  }

  void _registrar() async {
    if (_formKey.currentState!.validate() && fechaSeleccionada != null) {
      final estudiante = Estudiante(
        nombres: nombresController.text,
        edad: int.parse(edadController.text),
        fecha: fechaSeleccionada!,
        pais: paisController.text,
        ciudad: ciudadController.text,
        valorCurso: valorCurso,
        cuotaInicial: double.parse(cuotaInicialController.text),
        cuotaMensual: double.parse(cuotaMensualController.text),
      );

      await controller.registrarEstudiante(estudiante);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Estudiante registrado exitosamente')),
      );

      _formKey.currentState!.reset();
      setState(() {
        fechaSeleccionada = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor complete todos los campos')),
      );
    }
  }
}
