import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
    this.name,
    this.validator,
    this.obscureText,
    this.onChanged, {
    super.key,
  });
  final String name;
  final String? Function(String?) validator;
  final Function(String?) onChanged;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.3,
      ),
      child: TextFormField(
        onChanged: onChanged,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
            label: Text(
              name,
              style: AppTextStyles().normal,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor))),
      ),
    );
  }
}
