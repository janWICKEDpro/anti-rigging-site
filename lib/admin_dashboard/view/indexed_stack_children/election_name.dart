import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_events.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElectionName extends StatelessWidget {
  const ElectionName({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<AdminDashboardBloc, AdminDashBoardState>(
      builder: (context, state) {
        return SizedBox(
          height: height * 0.4,
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
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Election Name',
                          style: AppTextStyles()
                              .headers
                              .copyWith(color: Colors.white),
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
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 214, 210, 210)),
                    child: TextField(
                      onChanged: (text) {},
                      decoration: const InputDecoration(
                          hintText: 'Election name',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    )),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel')),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<AdminDashboardBloc>()
                            .add(OnIndexIncremented());
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor)),
                      child: Text(
                        'Next',
                        style: AppTextStyles()
                            .normal
                            .copyWith(color: Colors.white),
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
