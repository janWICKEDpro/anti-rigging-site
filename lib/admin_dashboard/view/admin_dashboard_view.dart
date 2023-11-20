import 'dart:developer';

import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_events.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:anti_rigging/admin_dashboard/bloc/create_election_enum.dart';
import 'package:anti_rigging/admin_dashboard/view/indexed_stack_children/election_name.dart';
import 'package:anti_rigging/admin_dashboard/view/indexed_stack_children/roles.dart';
import 'package:anti_rigging/admin_dashboard/view/utils.dart';
import 'package:anti_rigging/enums.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/widgets/fade_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:side_navigation/side_navigation.dart';

class AdminDashboad extends StatelessWidget {
  const AdminDashboad({super.key});
  factory AdminDashboad.routeBuilder(_, __) {
    return const AdminDashboad(
      key: Key('admin dashboard'),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminDashboardBloc()..add(OnElectionFetchedEvent()),
      child: BlocListener<AdminDashboardBloc, AdminDashBoardState>(
        listener: (context, state) {
          if (state.loginStatus == LoginStatus.signedOut) {
            GoRouter.of(context).pushReplacement('/login');
          }
        },
        child: BlocBuilder<AdminDashboardBloc, AdminDashBoardState>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: state.sideBarNavigationIndex != 0
                  ? Container()
                  : state.noActiveElection! && state.fetchElection == Fetch.success
                      ? SizedBox(
                          width: 150,
                          child: FloatingActionButton(
                            backgroundColor: primaryColor,
                            onPressed: () {
                              final bloc = BlocProvider.of<AdminDashboardBloc>(context);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BlocProvider.value(
                                      value: bloc,
                                      child: BlocBuilder<AdminDashboardBloc, AdminDashBoardState>(
                                        builder: (context, state) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            child: FadeIndexedStack(
                                                index: state.stackedIndex, children: const [ElectionName(), Role()]),
                                          );
                                        },
                                      ),
                                    );
                                  });
                            },
                            child: Text(
                              'Create Election',
                              style: AppTextStyles().normal.copyWith(color: Colors.white),
                            ),
                          ),
                        )
                      : state.noActiveElection == false && state.fetchElection == Fetch.success
                          ? SizedBox(
                              width: 150,
                              child: FloatingActionButton(
                                backgroundColor: Colors.redAccent,
                                onPressed: () {
                                  log('Loading');
                                  context.read<AdminDashboardBloc>().add(OnEndElection());
                                },
                                child: state.createELectionEnum == CreateELectionEnum.loading
                                    ? LoadingAnimationWidget.hexagonDots(color: Colors.white, size: 50)
                                    : Text(
                                        'End Election',
                                        style: AppTextStyles().normal.copyWith(color: Colors.white),
                                      ),
                              ),
                            )
                          : Container(),
              body: Row(
                children: [
                  SideNavigationBar(
                    theme: SideNavigationBarTheme(
                        itemTheme: SideNavigationBarItemTheme(
                          unselectedItemColor: primaryColor,
                          selectedItemColor: Colors.white,
                          selectedBackgroundColor: darkColor,
                          labelTextStyle: AppTextStyles().normal.copyWith(color: Colors.black, fontSize: 20),
                        ),
                        togglerTheme: SideNavigationBarTogglerTheme(),
                        dividerTheme: const SideNavigationBarDividerTheme(
                            showHeaderDivider: true, showMainDivider: true, showFooterDivider: true),
                        backgroundColor: lightColor),
                    selectedIndex: state.sideBarNavigationIndex,
                    items: const [
                      SideNavigationBarItem(
                        icon: Icons.dashboard,
                        label: 'Dashboard',
                      ),
                      SideNavigationBarItem(
                        icon: Icons.person,
                        label: 'Elections',
                      ),
                      SideNavigationBarItem(
                        icon: Icons.logout,
                        label: 'Logout',
                      ),
                    ],
                    onTap: (index) {
                      if (index != 2) {
                        BlocProvider.of<AdminDashboardBloc>(context).add(OnSideBarNavigationIndexChanged(index));
                      } else {
                        BlocProvider.of<AdminDashboardBloc>(context).add(OnSignOutButtonClicked());
                      }
                    },
                  ),
                  Expanded(child: adminPages.elementAt(state.sideBarNavigationIndex))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
