import 'package:anti_rigging/models/program_enum.dart';

class AppUser {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? regno;
  final String? email;
  final String? accountType;
  final Program? program;

  const AppUser(
      {this.id,
      this.firstName,
      this.lastName,
      this.regno,
      this.accountType = 'student',
      this.program,
      this.email});

  Map<String, dynamic> toJson() {
    return {
      'name': '$firstName $lastName',
      'email': email,
      'accountType': accountType,
      'regno': regno,
      'program': program.toString(),
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> user) {
    return AppUser(
        firstName: (user['name'] as String).split(' ').first,
        regno: user['regno'],
        email: user['email'],
        accountType: user['accountType'],
        program: Program.values
            .where((element) => element.toString() == user['program'])
            .first);
  }
}
