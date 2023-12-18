import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_events.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ElectionName extends StatefulWidget {
  const ElectionName({super.key});

  @override
  State<ElectionName> createState() => _ElectionNameState();
}

class _ElectionNameState extends State<ElectionName> {
  GlobalKey<FormState>? formKey;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    formKey!.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<AdminDashboardBloc, AdminDashBoardState>(
      builder: (context, state) {
        return SizedBox(
          height: height * 0.7,
          width: width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Election Name',
                          style: AppTextStyles().headers.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 50,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: const Color.fromARGB(255, 214, 210, 210)),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an election Title';
                          } else if (value.length < 3) {
                            return 'Election Name should be atleast 3 characters';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          context.read<AdminDashboardBloc>().add(OnElectionNameChanged(electionName: text));
                        },
                        decoration: const InputDecoration(
                            hintText: 'Election name', border: OutlineInputBorder(borderSide: BorderSide.none)),
                      ),
                    )),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel')),
                    const Gap(5),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey!.currentState!.validate()) {
                          context.read<AdminDashboardBloc>().add(OnIndexIncremented());
                        }
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
                      child: Text(
                        'Next',
                        style: AppTextStyles().normal.copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
