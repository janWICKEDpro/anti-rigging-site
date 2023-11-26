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
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  factory SignUp.routeBuilder(_, __) {
    return const SignUp(
      key: Key('signup'),
    );
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.authRes == 'Success') {
            log('Success');
            GoRouter.of(context).go('/');
          } else if (state.authRes != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  elevation: 5,
                  duration: const Duration(seconds: 3),
                  content: Text(
                    state.authRes!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles().normal.copyWith(color: Colors.white),
                  )));
          }
        },
        builder: (context, state) {
          return LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return Scaffold(
                body: Container(
                  child: Form(
                    key: signUpKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: constraints.maxWidth * 0.3,
                            width: constraints.maxWidth * 0.4,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain, image: AssetImage('assets/images/signup_bg.png')),
                            ),
                          ),
                          const Gap(10),
                          Text(
                            'Create An Account',
                            style: AppTextStyles().headers.copyWith(color: darkColor),
                          ),
                          const Gap(10),
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
                                context.read<SignUpBloc>().add(OnFullNameChanged(names));
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
                          const Gap(20),
                          Container(
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 226, 221, 221), borderRadius: BorderRadius.circular(5)),
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
                                  border: const OutlineInputBorder(borderSide: BorderSide.none)),
                              items: [
                                ...Program.values
                                    .map((e) => DropdownMenuItem(value: e, child: Text(e.toString().split('.').last)))
                                    .toList()
                              ],
                            ),
                          ),
                          const Gap(20),
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
                                context.read<SignUpBloc>().add(OnPasswordChanged(password));
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
                                context.read<SignUpBloc>().add(OnConfirmPasswordChanged(confirmPassword));
                              }),
                          const Gap(20),
                          Center(
                            child: SizedBox(
                              width: 150,
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
                                child: state.loading!
                                    ? LoadingAnimationWidget.hexagonDots(color: Colors.white, size: 20)
                                    : Text(
                                        'Signup',
                                        style: AppTextStyles().normal.copyWith(color: Colors.white),
                                      ),
                                onPressed: () {
                                  if (signUpKey.currentState!.validate()) {
                                    context.read<SignUpBloc>().add(OnSignUpButtonClicked());
                                  }
                                },
                              ),
                            ),
                          ),
                          const Gap(15),
                          TextButton(
                            onPressed: () {
                              GoRouter.of(context).go('/login');
                            },
                            child: Text(
                              'Have an account? Login',
                              style: AppTextStyles().normal.copyWith(color: primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Scaffold(
              body: Stack(children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: const Color.fromARGB(255, 228, 226, 226),
                    )),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: SizedBox(
                      height: height * 0.85,
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Form(
                                      key: signUpKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Create An Account',
                                              style: AppTextStyles().headers.copyWith(color: darkColor),
                                            ),
                                            const Gap(10),
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
                                                  context.read<SignUpBloc>().add(OnFullNameChanged(names));
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
                                            const Gap(20),
                                            DropdownButtonFormField(
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
                                                  border: const OutlineInputBorder(
                                                      borderSide: BorderSide(color: primaryColor))),
                                              items: [
                                                ...Program.values
                                                    .map((e) => DropdownMenuItem(
                                                        value: e, child: Text(e.toString().split('.').last)))
                                                    .toList()
                                              ],
                                            ),
                                            const Gap(20),
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
                                                  context.read<SignUpBloc>().add(OnPasswordChanged(password));
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
                                            const Gap(20),
                                            Center(
                                              child: SizedBox(
                                                width: 400,
                                                height: 40,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(primaryColor)),
                                                  child: state.loading!
                                                      ? LoadingAnimationWidget.hexagonDots(
                                                          color: Colors.white, size: 20)
                                                      : Text(
                                                          'Signup',
                                                          style: AppTextStyles().normal.copyWith(color: Colors.white),
                                                        ),
                                                  onPressed: () {
                                                    if (signUpKey.currentState!.validate()) {
                                                      context.read<SignUpBloc>().add(OnSignUpButtonClicked());
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            const Gap(15),
                                            TextButton(
                                              onPressed: () {
                                                GoRouter.of(context).go('/login');
                                              },
                                              child: Text(
                                                'Have an account? Login',
                                                style: AppTextStyles().normal.copyWith(color: primaryColor),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              decoration: const BoxDecoration(
                                color: lightColor,
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                      'assets/images/signup_bg.png',
                                    )),
                                borderRadius:
                                    BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            );
          });
        },
      ),
    );
  }
}
