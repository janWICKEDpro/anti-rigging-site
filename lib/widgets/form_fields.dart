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
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth < 600 ? width * 0.8 : width * 0.5,
        decoration: BoxDecoration(color: Color.fromARGB(255, 226, 221, 221), borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: TextFormField(
              onChanged: onChanged,
              obscureText: obscureText,
              validator: validator,
              decoration: InputDecoration(
                  label: Text(
                    name,
                    style: AppTextStyles().normal.copyWith(fontSize: 14),
                  ),
                  border: const OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ),
      );
    });
  }
}
