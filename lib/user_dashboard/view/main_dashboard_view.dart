import 'package:anti_rigging/user_dashboard/bloc/enums.dart';
import 'package:anti_rigging/user_dashboard/bloc/user_dashboard_bloc.dart';
import 'package:anti_rigging/user_dashboard/view/data_source.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/dashboard_card.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/widgets/virtual_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MainDashBoard extends StatelessWidget {
  const MainDashBoard({super.key, this.changeIndex});
  final Function()? changeIndex;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDashboardBloc, UserDashboardState>(
      builder: (context, state) {
        if (state.fetchInfo == FetchInfo.loading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Loading Info',
                  style: AppTextStyles().normal.copyWith(color: darkColor),
                ),
                LoadingAnimationWidget.hexagonDots(color: primaryColor, size: 60)
              ],
            ),
          );
        } else if (state.fetchInfo == FetchInfo.noElection) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, ${state.user!.fullNames!.split(' ').first}',
                  style: AppTextStyles().headers.copyWith(color: darkColor)),
              Text(
                'Welcome to the Anti-rigging online voting system',
                style: AppTextStyles().normal,
              ),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No Election info',
                          style: AppTextStyles().normal.copyWith(color: Colors.redAccent),
                        ),
                        const Gap(20),
                        VirtualId(
                          name: state.user!.fullNames!,
                          programe: state.user!.program!.toString(),
                          regno: state.user!.regno,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state.fetchInfo == FetchInfo.failed) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Failed to fetch Info',
                style: AppTextStyles().normal.copyWith(color: Colors.redAccent),
              ),
              OutlinedButton(
                  onPressed: () {
                    context.read<UserDashboardBloc>().add(OnFetchDashboardInfo());
                  },
                  child: Text(
                    'Retry',
                    style: AppTextStyles().normal.copyWith(color: Colors.redAccent),
                  ))
            ],
          ));
        }

        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Hello, ${state.user!.fullNames!.split(' ').first}',
                          style: AppTextStyles().headers.copyWith(color: darkColor)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome to the Anti-rigging online voting system',
                        style: AppTextStyles().normal,
                      ),
                    ),
                  ),
                  const Gap(20),
                  DashBoardCard(
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ongoing Elections',
                            style: AppTextStyles().normal.copyWith(fontSize: 10, color: primaryColor),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      '${state.election!.electionName}',
                                      style: AppTextStyles().headers.copyWith(fontSize: 14, color: darkColor),
                                    ),
                                    const Gap(20),
                                    OutlinedButton(
                                        onPressed: changeIndex,
                                        child: Text(
                                          'vote now',
                                          style: AppTextStyles().normal.copyWith(color: primaryColor),
                                        ))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: MediaQuery.of(context).size.width * 0.25,
                                  child: Image.asset('assets/images/vote.png'),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  DashBoardCard(
                    Center(
                      child: VirtualId(
                        name: state.user!.fullNames,
                        regno: state.user!.regno,
                        programe: state.user!.program.toString().split('.').last.toUpperCase(),
                      ),
                    ),
                  ),
                  const Gap(20),
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
                  )),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello, ${state.user!.fullNames!.split(' ').first}',
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
                                  style: AppTextStyles().normal.copyWith(color: primaryColor),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Wrap(
                                        direction: Axis.vertical,
                                        children: [
                                          Text(
                                            '${state.election!.electionName}',
                                            style: AppTextStyles().headers.copyWith(fontSize: 18, color: darkColor),
                                          ),
                                          Gap(10),
                                          OutlinedButton(
                                              onPressed: changeIndex,
                                              child: Text(
                                                'vote now',
                                                style: AppTextStyles().normal.copyWith(color: primaryColor),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: MediaQuery.of(context).size.width * 0.15,
                                        child: Image.asset('assets/images/vote.png'),
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
                          selectionDecoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: primaryColor, width: 2),
                            borderRadius: const BorderRadius.all(Radius.circular(4)),
                            shape: BoxShape.rectangle,
                          ),
                          dataSource: MeetingDataSource(state.meetings!),
                          todayHighlightColor: primaryColor,
                          view: CalendarView.month,
                        )),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 1,
                        child: DashBoardCard(
                          Center(
                            child: VirtualId(
                              name: state.user!.fullNames,
                              regno: state.user!.regno,
                              programe: state.user!.program.toString(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
