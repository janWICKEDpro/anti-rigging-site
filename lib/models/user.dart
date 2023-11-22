import 'package:anti_rigging/models/program_enum.dart';

class AppUser {
  final String? id;
  final String? fullNames;
  final String? regno;
  final String? email;
  final String? accountType;
  final Program? program;

  const AppUser({this.id, this.fullNames, this.regno, this.accountType = 'student', this.program, this.email});

  Map<String, dynamic> toJson() {
    return {
      'name': '$fullNames',
      'email': email,
      'accountType': accountType,
      'regno': regno,
      'program': program.toString(),
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> user) {
    return AppUser(
        fullNames: (user['name'] as String),
        regno: user['regno'],
        email: user['email'],
        accountType: user['accountType'],
        program: Program.values.where((element) => element.toString() == user['program']).first);
  }
}
