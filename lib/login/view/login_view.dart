import 'package:anti_rigging/login/bloc/login_bloc.dart';
import 'package:anti_rigging/login/bloc/login_events.dart';
import 'package:anti_rigging/login/bloc/login_state.dart';
import 'package:anti_rigging/login/form_key.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  factory Login.routeBuilder(_, __) {
    return const Login(
      key: Key('login'),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
                child: Form(
              key: loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                      (password) => context
                          .read<LoginBloc>()
                          .add(OnEmailChanged(password!))),
                  const Gap(30),
                  ElevatedButton(
                      onPressed: () {
                        if (loginKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(OnLoginButtonClicked());
                        }
                      },
                      child: state.loading!
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                            )
                          : Text(
                              'Login',
                              style: AppTextStyles().normal,
                            ))
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
