import 'package:anti_rigging/models/program_enum.dart';
import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  String? fullName;
  String? email;
  String? regno;
  String? password;
  String? confirmPassword;
  Program? program;
  bool? loading;
  String? authRes;
  bool? status;

  SignUpState(
      {this.fullName,
      this.email,
      this.regno,
      this.authRes,
      this.password,
      this.loading = false,
      this.confirmPassword,
      this.program,
      this.status = false});

  SignUpState copyWith({
    String? name,
    String? mail,
    String? res,
    String? reg,
    String? pass,
    bool? load,
    String? confirm,
    Program? prog,
    bool? stat,
  }) {
    return SignUpState(
        authRes: res ?? authRes,
        fullName: name ?? fullName,
        email: mail ?? email,
        regno: reg ?? regno,
        loading: load ?? loading,
        password: pass ?? password,
        confirmPassword: confirm ?? confirmPassword,
        status: stat ?? status,
        program: prog ?? program);
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        regno,
        loading,
        password,
        confirmPassword,
        status,
        authRes,
        program,
      ];
}
