import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../views/registro_estudiante_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final AuthController _authController = AuthController();

  String _errorMessage = "";

  void _login() {
    String user = _userController.text.trim();
    String pass = _passController.text.trim();
    bool isValid = _authController.authenticate(user, pass);

    if (isValid) {
      setState(() {
        _errorMessage = "";
      });
      // Navegar a otra vista en caso de autenticación exitosa
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Bienvenido")));
      // Navegar a la pantalla de registro
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegistroEstudianteView()),
      );
    } else {
      setState(() {
        _errorMessage = "Usuario o contraseña incorrectos";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/login.png', height: 120), // logo cargado
                const SizedBox(height: 20),
                const Text(
                  "Inicio de sesión",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _userController,
                  decoration: const InputDecoration(labelText: 'Usuario'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                ),
                const SizedBox(height: 10),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text("Ingresar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
