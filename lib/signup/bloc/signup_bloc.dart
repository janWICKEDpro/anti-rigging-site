import 'dart:developer';

import 'package:anti_rigging/models/user.dart';
import 'package:anti_rigging/services/auth/auth.dart';
import 'package:anti_rigging/signup/bloc/signup_events.dart';
import 'package:anti_rigging/signup/bloc/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpState> {
  final auth = AuthenticationService();
  SignUpBloc() : super(SignUpState()) {
    on<OnFullNameChanged>(onFullNameChanged);
    on<OnEmailChanged>(onEmailChanged);
    on<OnRegNoChanged>(onRegNoChanged);
    on<OnProgramChanged>(onProgramChanged);
    on<OnPasswordChanged>(onPasswordChanged);
    on<OnConfirmPasswordChanged>(onConfirmPasswordChanged);
    on<OnSignUpButtonClicked>(onSignUpButtonClicked);
  }

  onFullNameChanged(OnFullNameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(name: event.name));
  }

  onEmailChanged(OnEmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(mail: event.email));
  }

  onRegNoChanged(OnRegNoChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(reg: event.regNo));
  }

  onProgramChanged(OnProgramChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(prog: event.program));
  }

  onPasswordChanged(OnPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(pass: event.password));
  }

  onConfirmPasswordChanged(
      OnConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(confirm: event.confirmPassword));
  }

  onSignUpButtonClicked(
      OnSignUpButtonClicked event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(load: true, stat: false));
    final user = AppUser(
      fullNames: state.fullName,
      email: state.email,
      regno: state.regno,
      program: state.program,
    );

    final result = await auth.signup(user, state.confirmPassword!);
    log(result);
    emit(state.copyWith(load: false, stat: true, res: result));
  }
}
