import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_events.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:anti_rigging/admin_dashboard/bloc/create_election_enum.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/utils/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AdminDashBoardPage extends StatefulWidget {
  const AdminDashBoardPage({super.key});

  @override
  State<AdminDashBoardPage> createState() => _AdminDashBoardPageState();
}

class _AdminDashBoardPageState extends State<AdminDashBoardPage>
    with TickerProviderStateMixin {
  final List<String> pages = ['Page 1', 'Page 2', 'Page 3', 'Page 4'];
  final PageController _pageController = PageController(initialPage: 0);

  void nextPage() {
    if (_pageController.page! < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void previousPage() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, Admin!',
            style: AppTextStyles().headers.copyWith(color: darkColor),
          ),
          const Gap(10),
          BlocBuilder<AdminDashboardBloc, AdminDashBoardState>(
            builder: (context, state) {
              if (state.fetchElection == Fetch.loading) {
                return Expanded(
                    child: Center(
                  child: LoadingAnimationWidget.newtonCradle(
                      color: darkColor, size: 100),
                ));
              } else if (state.fetchElection == Fetch.failed) {
                return Expanded(
                    child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Failed to Fetch Active election Info",
                        style: AppTextStyles()
                            .normal
                            .copyWith(color: Colors.redAccent),
                      ),
                      OutlinedButton(
                          onPressed: () {
                            context
                                .read<AdminDashboardBloc>()
                                .add(OnElectionFetchedEvent());
                          },
                          child: Text(
                            'Retry',
                            style: AppTextStyles()
                                .normal
                                .copyWith(color: primaryColor),
                          ))
                    ],
                  ),
                ));
              } else if (state.fetchElection == Fetch.success &&
                  state.noActiveElection == true) {
                return Expanded(
                    child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      'images/no_data.jpg',
                    ))),
                  ),
                ));
              } else {
                return Expanded(
                  child: Container(
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        DashBoardCard(
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  'Results',
                                  style: AppTextStyles()
                                      .normal
                                      .copyWith(color: darkColor),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: previousPage,
                                        icon: Icon(Icons.arrow_back_ios)),
                                    IconButton(
                                        onPressed: nextPage,
                                        icon: Icon(Icons.arrow_forward_ios)),
                                  ],
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: PageView.builder(
                                      controller: _pageController,
                                      itemCount: pages.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: Colors.blue,
                                          child: Center(
                                            child: Text(
                                              pages[index],
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DashBoardCard(SfCalendar(
                          view: CalendarView.week,
                        ))
                      ],
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
