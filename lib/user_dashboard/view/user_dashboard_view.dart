import 'package:flutter/material.dart';

class UserDashBoard extends StatelessWidget {
  const UserDashBoard({super.key});

  factory UserDashBoard.routeBuilder(_, __) {
    return const UserDashBoard(
      key: Key('main menu'),
    );
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
