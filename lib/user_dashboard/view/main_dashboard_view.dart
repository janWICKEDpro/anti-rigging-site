import 'package:anti_rigging/user_dashboard/bloc/enums.dart';
import 'package:anti_rigging/user_dashboard/bloc/user_dashboard_bloc.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/dashboard_card.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MainDashBoard extends StatelessWidget {
  const MainDashBoard({
    super.key,
  });

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
                LoadingAnimationWidget.hexagonDots(
                    color: primaryColor, size: 60)
              ],
            ),
          );
        } else if (state.fetchInfo == FetchInfo.noElection) {
          return const Center(
            child: Text('No Election infor'),
          );
        } else if (state.fetchInfo == FetchInfo.failed) {
          return Center(
            child: Container(
                child: Column(
              children: [
                Text(
                  'Loading Info',
                  style:
                      AppTextStyles().normal.copyWith(color: Colors.redAccent),
                ),
                OutlinedButton(
                    onPressed: () {
                      context
                          .read<UserDashboardBloc>()
                          .add(OnFetchDashboardInfo());
                    },
                    child: Text(
                      'Retry',
                      style: AppTextStyles()
                          .normal
                          .copyWith(color: Colors.redAccent),
                    ))
              ],
            )),
          );
        }

        return SingleChildScrollView(
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
                                        '${state.election!.electionName}',
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
                                    height: MediaQuery.of(context).size.width *
                                        0.15,
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
                  const StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: 1,
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
      },
    );
  }
}
