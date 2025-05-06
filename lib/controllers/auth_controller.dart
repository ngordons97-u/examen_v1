import '../models/user_model.dart';

class AuthController {
  // Usuario quemado en el código
  final UserModel _validUser = UserModel(username: "admin", password: "admin");

  bool authenticate(String username, String password) {
    return username == _validUser.username && password == _validUser.password;
  }
}
