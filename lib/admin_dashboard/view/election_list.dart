import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:anti_rigging/admin_dashboard/bloc/create_election_enum.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ElectionList extends StatefulWidget {
  const ElectionList({super.key});

  @override
  State<ElectionList> createState() => _ElectionListState();
}

class _ElectionListState extends State<ElectionList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AdminDashboardBloc>(context),
      child: Column(
        children: [
          Center(
              child: Text(
            'List Of Elections',
            style: AppTextStyles().headers.copyWith(color: darkColor),
          )),
          BlocBuilder<AdminDashboardBloc, AdminDashBoardState>(
            builder: (context, state) {
              if (state.fetchElectionList == FetchElectionList.loading) {
                return LoadingAnimationWidget.newtonCradle(
                    color: darkColor, size: 100);
              } else if (state.fetchElectionList == FetchElectionList.failed) {
                return Center(
                  child: Text(
                    'Failed to fetch elections',
                    style: AppTextStyles()
                        .normal
                        .copyWith(color: Colors.redAccent),
                  ),
                );
              }
              return ListView.builder(
                  itemCount: state.electionsList!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'ElectionName: ',
                                style: AppTextStyles().normal,
                              ),
                              Text(
                                state.election!.electionName!,
                                style: AppTextStyles()
                                    .normal
                                    .copyWith(color: primaryColor),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Status: ',
                                style: AppTextStyles().normal,
                              ),
                              Text(
                                state.election!.isActive! ? 'Active' : "Ended",
                                style: AppTextStyles().normal.copyWith(
                                    color: state.election!.isActive!
                                        ? primaryColor
                                        : Colors.redAccent),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
