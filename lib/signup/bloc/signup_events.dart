import 'package:anti_rigging/models/program_enum.dart';

sealed class SignUpEvents {}

class OnFullNameChanged extends SignUpEvents {
  String? name;
  OnFullNameChanged(this.name);
}

class OnEmailChanged extends SignUpEvents {
  String? email;
  OnEmailChanged(this.email);
}

class OnProgramChanged extends SignUpEvents {
  Program? program;
  OnProgramChanged(this.program);
}

class OnRegNoChanged extends SignUpEvents {
  String? regNo;
  OnRegNoChanged(this.regNo);
}

class OnPasswordChanged extends SignUpEvents {
  String? password;
  OnPasswordChanged(this.password);
}

class OnConfirmPasswordChanged extends SignUpEvents {
  String? confirmPassword;
  OnConfirmPasswordChanged(this.confirmPassword);
}

class OnSignUpButtonClicked extends SignUpEvents {}
