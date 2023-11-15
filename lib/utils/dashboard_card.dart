import 'package:flutter/material.dart';

class DashBoardCard extends StatelessWidget {
  const DashBoardCard(this.child, {super.key, this.onTap});
  final Widget child;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              offset: Offset(-6.0, -6.0),
              blurRadius: 16.0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(6.0, 6.0),
              blurRadius: 16.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: child,
      ),
    );
  }
}
