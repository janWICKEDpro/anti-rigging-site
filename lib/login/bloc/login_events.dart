sealed class LoginEvents {}

class OnEmailChanged extends LoginEvents {
  String email;
  OnEmailChanged(this.email);
}

class OnPasswordChanged extends LoginEvents {
  String password;
  OnPasswordChanged(this.password);
}

class OnLoginButtonClicked extends LoginEvents {}
