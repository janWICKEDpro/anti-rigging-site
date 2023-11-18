import 'package:anti_rigging/user_dashboard/bloc/user_dashboard_bloc.dart';
import 'package:anti_rigging/user_dashboard/view/main_dashboard_view.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/vote/view/vote_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  List<Widget> screens = [
    MainDashBoard(),
    VoteView(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDashboardBloc()..add(OnFetchDashboardInfo()),
      child: Scaffold(
        body: Row(
          children: [
            SidebarX(
              controller: SidebarXController(
                  selectedIndex: selectedIndex, extended: true),
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
              footerDivider: Divider(),
              headerBuilder: (context, extended) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 100,
                      width: 100,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        //    child: Image.asset('assets/images/avatar.png'),
                        // child: SvgPicture.asset('icons/male.svg',
                        //     semanticsLabel: 'Acme Logo'),
                      ),
                    ),
                    extended
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'John Doe',
                                style: AppTextStyles()
                                    .headers
                                    .copyWith(color: darkColor),
                              ),
                            ),
                          )
                        : Container()
                  ],
                );
              },
              items: [
                SidebarXItem(
                  icon: Icons.dashboard,
                  label: 'Dashbaord',
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
                SidebarXItem(label: 'logout', icon: Icons.logout, onTap: () {})
              ],
            ),
            Expanded(child: screens.elementAt(selectedIndex))
          ],
        ),
      ),
    );
  }
}
