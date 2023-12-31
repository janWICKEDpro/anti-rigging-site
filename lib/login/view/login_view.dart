import 'package:anti_rigging/login/bloc/login_bloc.dart';
import 'package:anti_rigging/login/bloc/login_events.dart';
import 'package:anti_rigging/login/bloc/login_state.dart';
import 'package:anti_rigging/login/form_key.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  factory Login.routeBuilder(_, __) {
    return const Login(
      key: Key('login'),
    );
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.loginResult == 'Success' && state.user!.accountType == 'student') {
            GoRouter.of(context).go('/');
          } else if (state.loginResult == 'Success' && state.user!.accountType == 'admin') {
            GoRouter.of(context).go('/admin');
          } else if (state.loginResult != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  elevation: 5,
                  duration: const Duration(seconds: 3),
                  content: Text(
                    state.loginResult!,
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
                    key: loginKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: constraints.maxWidth * 0.3,
                          width: constraints.maxWidth * 0.4,
                          decoration: const BoxDecoration(
                            image:
                                DecorationImage(fit: BoxFit.contain, image: AssetImage('assets/images/signup_bg.png')),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          'Welcome Back!',
                          style: AppTextStyles().headers.copyWith(color: darkColor),
                        ),
                        const Gap(30),
                        CustomFormField(
                          'Email',
                          (text) {
                            if (text!.isEmpty) {
                              return 'Please enter You email';
                            } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text)) {
                              return 'Please Enter a valid email';
                            }
                            return null;
                          },
                          false,
                          (email) => context.read<LoginBloc>().add(
                                OnEmailChanged(email!),
                              ),
                        ),
                        const Gap(10),
                        CustomFormField('Password', (text) {
                          if (text!.isEmpty) {
                            return 'Please enter Your Password';
                          }
                          return null;
                        }, true, (password) => context.read<LoginBloc>().add(OnPasswordChanged(password!))),
                        const Gap(30),
                        Center(
                          child: Container(
                            width: 100,
                            height: 40,
                            child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
                              child: state.loading!
                                  ? LoadingAnimationWidget.hexagonDots(color: Colors.white, size: 20)
                                  : Text(
                                      'login',
                                      style: AppTextStyles().normal.copyWith(color: Colors.white),
                                    ),
                              onPressed: () {
                                if (loginKey.currentState!.validate()) {
                                  context.read<LoginBloc>().add(OnLoginButtonClicked());
                                }
                              },
                            ),
                          ),
                        ),
                        const Gap(20),
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).go('/signup');
                          },
                          child: Text(
                            'Don\'t have an account? signup for one',
                            style: AppTextStyles().normal.copyWith(color: primaryColor),
                          ),
                        )
                      ],
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
                    color: Color.fromARGB(255, 228, 226, 226),
                  )),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: height * 0.85,
                      child: Card(
                        elevation: 5,
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
                                      key: loginKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Welcome Back!',
                                              style: AppTextStyles().headers.copyWith(color: darkColor),
                                            ),
                                            const Gap(10),
                                            CustomFormField(
                                              'Email',
                                              (text) {
                                                if (text!.isEmpty) {
                                                  return 'Please enter You email';
                                                } else if (!RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(text)) {
                                                  return 'Please Enter a valid email';
                                                }
                                                return null;
                                              },
                                              false,
                                              (email) => context.read<LoginBloc>().add(
                                                    OnEmailChanged(email!),
                                                  ),
                                            ),
                                            const Gap(10),
                                            CustomFormField('Password', (text) {
                                              if (text!.isEmpty) {
                                                return 'Please enter Your Password';
                                              }
                                              return null;
                                            },
                                                true,
                                                (password) =>
                                                    context.read<LoginBloc>().add(OnPasswordChanged(password!))),
                                            const Gap(30),
                                            Center(
                                              child: Container(
                                                width: 400,
                                                height: 40,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(primaryColor)),
                                                  child: state.loading!
                                                      ? LoadingAnimationWidget.hexagonDots(
                                                          color: Colors.white, size: 20)
                                                      : Text(
                                                          'login',
                                                          style: AppTextStyles().normal.copyWith(color: Colors.white),
                                                        ),
                                                  onPressed: () {
                                                    if (loginKey.currentState!.validate()) {
                                                      context.read<LoginBloc>().add(OnLoginButtonClicked());
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            const Gap(20),
                                            TextButton(
                                              onPressed: () {
                                                GoRouter.of(context).go('/signup');
                                              },
                                              child: Text(
                                                'Don\'t have an account? signup for one',
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
                                    fit: BoxFit.contain, image: AssetImage('assets/images/signup_bg.png')),
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
              ),
            ]));
          });
        },
      ),
    );
  }
}
