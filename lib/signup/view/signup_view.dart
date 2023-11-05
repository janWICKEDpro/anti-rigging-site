import 'dart:developer';

import 'package:anti_rigging/models/program_enum.dart';
import 'package:anti_rigging/signup/bloc/signup_bloc.dart';
import 'package:anti_rigging/signup/bloc/signup_events.dart';
import 'package:anti_rigging/signup/bloc/signup_state.dart';
import 'package:anti_rigging/signup/formkey.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  factory SignUp.routeBuilder(_, __) {
    return const SignUp(
      key: Key('signup'),
    );
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Form(
                key: signUpKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFormField(
                        'Full Names',
                        (validator) {
                          if (validator!.isEmpty) {
                            return 'Please Enter your full Names';
                          } else if (validator.length < 3) {
                            return 'Enter a name greater than 3 characters';
                          } else {
                            return null;
                          }
                        },
                        false,
                        (names) {
                          context
                              .read<SignUpBloc>()
                              .add(OnFullNameChanged(names));
                        }),
                    const Gap(10),
                    CustomFormField(
                        'Email ',
                        (validator) {
                          if (validator!.isEmpty) {
                            return 'Please enter Your Email';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(validator)) {
                            return 'Please enter a valid Email';
                          } else {
                            return null;
                          }
                        },
                        false,
                        (email) {
                          context.read<SignUpBloc>().add(OnEmailChanged(email));
                        }),
                    const Gap(10),
                    CustomFormField(
                        'RegNo',
                        (validator) {
                          if (validator!.isEmpty) {
                            return 'Please Enter your full Names';
                          } else if (validator.length < 3) {
                            return 'Enter a name greater than 3 characters';
                          } else {
                            return null;
                          }
                        },
                        false,
                        (regNo) {
                          context.read<SignUpBloc>().add(OnRegNoChanged(regNo));
                        }),
                    const Gap(10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.3,
                      ),
                      child: DropdownButtonFormField(
                        onChanged: (val) {
                          context.read<SignUpBloc>().add(OnProgramChanged(val));
                        },
                        value: Program.none,
                        validator: (text) {
                          if (text == Program.none) {
                            return 'Please Select a Program';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            label: Text(
                              'Program',
                              style: AppTextStyles().normal,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor))),
                        items: [
                          ...Program.values
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.toString().split('.').last)))
                              .toList()
                        ],
                      ),
                    ),
                    const Gap(10),
                    CustomFormField(
                        'Password',
                        (validator) {
                          if (validator!.isEmpty) {
                            return 'Please Enter a password';
                          } else if (validator.length < 8) {
                            return 'Enter a password greater than 8 characters';
                          } else {
                            return null;
                          }
                        },
                        true,
                        (password) {
                          context
                              .read<SignUpBloc>()
                              .add(OnPasswordChanged(password));
                        }),
                    const Gap(10),
                    CustomFormField(
                        'ConfirmPassword',
                        (validator) {
                          if (validator != state.password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        true,
                        (confirmPassword) {
                          context
                              .read<SignUpBloc>()
                              .add(OnConfirmPasswordChanged(confirmPassword));
                        }),
                    const Gap(10),
                    Center(
                      child: ElevatedButton(
                        child: state.loading!
                            ? CircularProgressIndicator()
                            : Text(
                                'Signup',
                                style: AppTextStyles().normal,
                              ),
                        onPressed: () {
                          if (signUpKey.currentState!.validate()) {
                            context
                                .read<SignUpBloc>()
                                .add(OnSignUpButtonClicked());
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
