import 'package:anti_rigging/models/user.dart';

class LoginState {
  String? email;
  String? password;
  bool? loading;
  String? loginResult;
  AppUser? user;

  LoginState({this.email, this.password, this.loading = false, this.user, this.loginResult});

  LoginState copyWith({String? mail, String? pass, bool? load, AppUser? us, String? result}) {
    return LoginState(
        email: mail ?? email,
        password: pass ?? password,
        loading: load ?? loading,
        user: us ?? user,
        loginResult: result ?? loginResult);
  }
}
