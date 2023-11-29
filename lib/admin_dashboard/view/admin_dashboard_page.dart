import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_events.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:anti_rigging/admin_dashboard/bloc/create_election_enum.dart';
import 'package:anti_rigging/models/candidate.dart';
import 'package:anti_rigging/user_dashboard/view/data_source.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/utils/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AdminDashBoardPage extends StatefulWidget {
  const AdminDashBoardPage({super.key});

  @override
  State<AdminDashBoardPage> createState() => _AdminDashBoardPageState();
}

class _AdminDashBoardPageState extends State<AdminDashBoardPage> with TickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  late TooltipBehavior _tooltip;
  late List<Candidate> data = [];

  int index = 0;
  void nextPage(int length) {
    index = (index + 1) % length;
    setState(() {});
    data = context.read<AdminDashboardBloc>().state.candidateRoles![index].$2;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void previousPage(int length) {
    index = (index - 1) % length;
    setState(() {});
    data = context.read<AdminDashboardBloc>().state.candidateRoles![index].$2;
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final candidateListLength = context.read<AdminDashboardBloc>().state.candidateRoles!.length;
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
                  child: LoadingAnimationWidget.newtonCradle(color: darkColor, size: 100),
                ));
              } else if (state.fetchElection == Fetch.failed) {
                return Expanded(
                    child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Failed to Fetch Active election Info",
                        style: AppTextStyles().normal.copyWith(color: Colors.redAccent),
                      ),
                      OutlinedButton(
                          onPressed: () {
                            context.read<AdminDashboardBloc>().add(OnElectionFetchedEvent());
                          },
                          child: Text(
                            'Retry',
                            style: AppTextStyles().normal.copyWith(color: primaryColor),
                          ))
                    ],
                  ),
                ));
              } else if (state.fetchElection == Fetch.success && state.noActiveElection == true) {
                return Expanded(
                    child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      'assets/images/no_data.jpg',
                    ))),
                  ),
                ));
              } else {
                data = context.read<AdminDashboardBloc>().state.candidateRoles![index].$2;
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Live Results',
                                  style: AppTextStyles().headers.copyWith(color: primaryColor, fontSize: 18),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () => previousPage(candidateListLength),
                                        icon: Icon(Icons.arrow_back_ios_new_outlined)),
                                    Text(
                                      state.candidateRoles![index].$1,
                                      style: AppTextStyles().normal.copyWith(color: darkColor),
                                    ),
                                    IconButton(
                                        splashColor: lightColor,
                                        onPressed: () => nextPage(candidateListLength),
                                        icon: Icon(Icons.arrow_forward_ios_outlined)),
                                  ],
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: PageView.builder(
                                      controller: _pageController,
                                      itemCount: state.candidateRoles!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: lightColor,
                                          child: Center(
                                            child: SfCartesianChart(
                                              primaryXAxis: CategoryAxis(),
                                              primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
                                              tooltipBehavior: _tooltip,
                                              series: <ChartSeries<Candidate, String>>[
                                                BarSeries<Candidate, String>(
                                                    dataSource: data,
                                                    xValueMapper: (Candidate data, _) => data.candidateName,
                                                    yValueMapper: (Candidate data, _) => data.votes,
                                                    name: 'Votes',
                                                    color: primaryColor),
                                              ],
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
                          selectionDecoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: primaryColor, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(4)),
                            shape: BoxShape.rectangle,
                          ),
                          dataSource: MeetingDataSource(state.meetings!),
                          todayHighlightColor: primaryColor,
                          view: CalendarView.month,
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
