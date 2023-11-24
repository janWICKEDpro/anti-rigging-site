import 'package:anti_rigging/enums.dart';
import 'package:anti_rigging/user_dashboard/bloc/user_dashboard_bloc.dart';
import 'package:anti_rigging/user_dashboard/view/main_dashboard_view.dart';
import 'package:anti_rigging/user_dashboard/view/vote_view.dart';
import 'package:anti_rigging/user_session/bloc/user_session_bloc.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({super.key});

  factory UserDashBoard.routeBuilder(_, __) {
    return const UserDashBoard(
      key: Key('main menu'),
    );
  }

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      MainDashBoard(
        changeIndex: () {
          setState(() {
            selectedIndex = 1;
          });
        },
      ),
      VoteView(),
    ];
    return BlocProvider(
      lazy: false,
      create: (context) => UserDashboardBloc(BlocProvider.of<UserSessionBloc>(context))..add(OnFetchDashboardInfo()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserSessionBloc, UserSessionState>(
            listener: (context, state) {
              if (state is SessionDeleted) {
                context.read<UserDashboardBloc>().add(OnSignoutClicked());
              }
            },
          ),
          BlocListener<UserDashboardBloc, UserDashboardState>(
            listener: (context, state) {
              if (state.loginStatus == LoginStatus.signedOut) {
                GoRouter.of(context).pushReplacement('/login');
              }
            },
          )
        ],
        child: BlocBuilder<UserDashboardBloc, UserDashboardState>(
          builder: (context, state) {
            return LayoutBuilder(builder: (context, constraints) {
              return Scaffold(
                appBar: constraints.maxWidth < 600
                    ? AppBar(
                        backgroundColor: Colors.white,
                      )
                    : null,
                drawer: constraints.maxWidth < 600
                    ? SidebarX(
                        controller: SidebarXController(selectedIndex: selectedIndex, extended: true),
                        theme: SidebarXTheme(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: lightColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hoverColor: lightColor,
                          hoverTextStyle: AppTextStyles().normal,
                          textStyle: AppTextStyles().normal,
                          selectedTextStyle: const TextStyle(color: Colors.white),
                          itemTextPadding: const EdgeInsets.only(left: 30),
                          selectedItemTextPadding: const EdgeInsets.only(left: 30),
                          itemDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: lightColor),
                          ),
                          selectedItemDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: darkColor.withOpacity(0.37),
                            ),
                            gradient: const LinearGradient(
                              colors: [primaryColor, lightColor],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.28),
                                blurRadius: 20,
                              )
                            ],
                          ),
                          iconTheme: const IconThemeData(
                            color: primaryColor,
                            size: 20,
                          ),
                          selectedIconTheme: const IconThemeData(
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        extendedTheme: const SidebarXTheme(
                          width: 200,
                          decoration: BoxDecoration(
                            color: lightColor,
                          ),
                        ),
                        footerDivider: const Divider(),
                        headerBuilder: (context, extended) {
                          return Column(
                            children: [
                              extended
                                  ? SizedBox(
                                      height: 300,
                                      width: 300,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: lightColor,
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: AssetImage(
                                                'assets/images/kigali_bg.png',
                                              )),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                                        ),
                                      ))
                                  : Container(),
                              extended
                                  ? Center(
                                      child: Text(
                                        state.user != null ? state.user!.fullNames! : '',
                                        style: AppTextStyles().headers.copyWith(color: darkColor, fontSize: 16),
                                      ),
                                    )
                                  : Container()
                            ],
                          );
                        },
                        items: [
                          SidebarXItem(
                            icon: Icons.dashboard,
                            label: 'Dashboard',
                            onTap: () {
                              if (selectedIndex != 0) {
                                selectedIndex = 0;
                                setState(() {});
                              }
                            },
                          ),
                          SidebarXItem(
                            icon: Icons.card_membership,
                            label: 'Vote',
                            onTap: () {
                              if (selectedIndex != 1) {
                                selectedIndex = 1;
                                setState(() {});
                              }
                            },
                          ),
                          SidebarXItem(
                              label: 'logout',
                              icon: Icons.logout,
                              onTap: () {
                                context.read<UserDashboardBloc>().add(OnSignoutClicked());
                              })
                        ],
                      )
                    : null,
                body: Row(
                  children: [
                    constraints.maxWidth < 600
                        ? const SizedBox()
                        : SidebarX(
                            controller: SidebarXController(selectedIndex: selectedIndex, extended: true),
                            theme: SidebarXTheme(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: lightColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hoverColor: lightColor,
                              hoverTextStyle: AppTextStyles().normal,
                              textStyle: AppTextStyles().normal,
                              selectedTextStyle: const TextStyle(color: Colors.white),
                              itemTextPadding: const EdgeInsets.only(left: 30),
                              selectedItemTextPadding: const EdgeInsets.only(left: 30),
                              itemDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: lightColor),
                              ),
                              selectedItemDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: darkColor.withOpacity(0.37),
                                ),
                                gradient: const LinearGradient(
                                  colors: [primaryColor, lightColor],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.28),
                                    blurRadius: 20,
                                  )
                                ],
                              ),
                              iconTheme: const IconThemeData(
                                color: primaryColor,
                                size: 20,
                              ),
                              selectedIconTheme: const IconThemeData(
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            extendedTheme: const SidebarXTheme(
                              width: 200,
                              decoration: BoxDecoration(
                                color: lightColor,
                              ),
                            ),
                            footerDivider: const Divider(),
                            headerBuilder: (context, extended) {
                              return Column(
                                children: [
                                  extended
                                      ? SizedBox(
                                          height: 300,
                                          width: 300,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: lightColor,
                                              image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: AssetImage(
                                                    'assets/images/kigali_bg.png',
                                                  )),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                                            ),
                                          ))
                                      : Container(),
                                  extended
                                      ? Center(
                                          child: Text(
                                            state.user != null ? state.user!.fullNames! : '',
                                            style: AppTextStyles().headers.copyWith(color: darkColor, fontSize: 16),
                                          ),
                                        )
                                      : Container()
                                ],
                              );
                            },
                            items: [
                              SidebarXItem(
                                icon: Icons.dashboard,
                                label: 'Dashboard',
                                onTap: () {
                                  if (selectedIndex != 0) {
                                    selectedIndex = 0;
                                    setState(() {});
                                  }
                                },
                              ),
                              SidebarXItem(
                                icon: Icons.card_membership,
                                label: 'Vote',
                                onTap: () {
                                  if (selectedIndex != 1) {
                                    selectedIndex = 1;
                                    setState(() {});
                                  }
                                },
                              ),
                              SidebarXItem(
                                  label: 'logout',
                                  icon: Icons.logout,
                                  onTap: () {
                                    context.read<UserDashboardBloc>().add(OnSignoutClicked());
                                  })
                            ],
                          ),
                    Expanded(child: screens.elementAt(selectedIndex))
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
