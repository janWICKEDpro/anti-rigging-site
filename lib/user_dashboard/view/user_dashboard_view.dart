import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/utils/dashboard_card.dart';
import 'package:anti_rigging/vote/view/vote_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
    return Scaffold(
      appBar: AppBar(),
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
          Expanded(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: screens.elementAt(selectedIndex),
          ))
        ],
      ),
    );
  }
}

class MainDashBoard extends StatelessWidget {
  const MainDashBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hello, John!',
              style: AppTextStyles().headers.copyWith(color: darkColor)),
          Text(
            'Welcome to the Anti-rigging online voting system',
            style: AppTextStyles().normal,
          ),
          StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: DashBoardCard(
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ongoing Elections',
                          style: AppTextStyles()
                              .normal
                              .copyWith(color: primaryColor),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                direction: Axis.vertical,
                                children: [
                                  Text(
                                    'President Students \nCouncil',
                                    style: AppTextStyles()
                                        .headers
                                        .copyWith(color: darkColor),
                                  ),
                                  OutlinedButton(
                                      onPressed: () {},
                                      child: Text(
                                        'vote now',
                                        style: AppTextStyles()
                                            .normal
                                            .copyWith(color: primaryColor),
                                      ))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                child: Image.asset('images/vote.png'),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: DashBoardCard(SfCalendar(
                  todayHighlightColor: primaryColor,
                  view: CalendarView.week,
                )),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 3,
                mainAxisCellCount: 1,
                child: DashBoardCard(
                  Center(
                    child: Text('hi'),
                  ),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 3,
                child: DashBoardCard(
                  Center(
                    child: Text('hi'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
