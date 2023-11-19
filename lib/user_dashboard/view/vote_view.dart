import 'package:anti_rigging/user_dashboard/bloc/enums.dart';
import 'package:anti_rigging/user_dashboard/bloc/user_dashboard_bloc.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/widgets/candidate_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VoteView extends StatefulWidget {
  const VoteView({super.key});

  @override
  State<VoteView> createState() => _VoteViewState();
}

class _VoteViewState extends State<VoteView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDashboardBloc, UserDashboardState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You May Now Cast Your Votes',
              style: AppTextStyles().headers.copyWith(color: primaryColor),
            ),
            Builder(builder: (context) {
              if (state.fetchVoteList == FetchVoteList.loading) {
                return Expanded(
                  child: SizedBox(
                    child: Center(
                      child: Column(
                        children: [
                          const Text('Loading Votes'),
                          LoadingAnimationWidget.hexagonDots(
                              color: primaryColor, size: 60)
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state.fetchVoteList == FetchVoteList.failed) {
                return Expanded(
                  child: SizedBox(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Loading Votes',
                            style: AppTextStyles()
                                .normal
                                .copyWith(color: Colors.redAccent),
                          ),
                          OutlinedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryColor)),
                              onPressed: () {
                                context
                                    .read<UserDashboardBloc>()
                                    .add(OnVoteListFetched());
                              },
                              child: Text(
                                'Retry',
                                style: AppTextStyles()
                                    .normal
                                    .copyWith(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Expanded(
                  child: SizedBox(
                child: ListView.builder(
                    itemCount: state.voteList!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  state.voteList![index].$1,
                                  style: AppTextStyles().normal,
                                ),
                                Expanded(
                                    child: SizedBox(
                                  child: ListView.builder(
                                      itemCount:
                                          state.voteList![index].$2.length,
                                      itemBuilder: (context, subIndex) {
                                        return CandidateCard(
                                          name: state.voteList![index]
                                              .$2[subIndex].candidateName,
                                          description: state
                                              .voteList![index]
                                              .$2[subIndex]
                                              .candidateDescription,
                                          imageUrl: state.voteList![index]
                                              .$2[subIndex].imageUrl,
                                        );
                                      }),
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ));
            })
          ],
        );
      },
    );
  }
}
