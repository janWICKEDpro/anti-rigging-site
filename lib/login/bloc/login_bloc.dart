import 'package:anti_rigging/login/bloc/login_events.dart';
import 'package:anti_rigging/login/bloc/login_state.dart';
import 'package:anti_rigging/services/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final auth = AuthenticationService();
  LoginBloc() : super(LoginState()) {
    on<OnEmailChanged>((OnEmailChanged event, Emitter<LoginState> emit) {
      emit(state.copyWith(mail: event.email));
    });
    on<OnPasswordChanged>((OnPasswordChanged event, Emitter<LoginState> emit) {
      emit(state.copyWith(pass: event.password));
    });
    on<OnLoginButtonClicked>(onLoginButtonClicked);
  }

  onLoginButtonClicked(
      OnLoginButtonClicked event, Emitter<LoginState> emit) async {
    emit(state.copyWith(load: true));
    final res = await auth.login(state.email!, state.password!);
    emit(state.copyWith(load: false, us: res.$1, result: res.$2));
  }
}
