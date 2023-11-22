import 'package:anti_rigging/user_dashboard/bloc/enums.dart';
import 'package:anti_rigging/user_dashboard/bloc/user_dashboard_bloc.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/widgets/candidate_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VoteView extends StatefulWidget {
  const VoteView({super.key});

  @override
  State<VoteView> createState() => _VoteViewState();
}

class _VoteViewState extends State<VoteView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<UserDashboardBloc>(context)..add(OnVoteListFetched()),
      child: BlocBuilder<UserDashboardBloc, UserDashboardState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(builder: ((context, constraints) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'You May Now Cast Your Votes',
                    style: AppTextStyles()
                        .headers
                        .copyWith(fontSize: constraints.maxWidth < 600 ? 14 : null, color: primaryColor),
                  ),
                );
              })),
              Builder(builder: (context) {
                if (state.fetchVoteList == FetchVoteList.loading) {
                  return Expanded(
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Loading Votes'),
                          LoadingAnimationWidget.hexagonDots(color: primaryColor, size: 60)
                        ],
                      ),
                    ),
                  );
                } else if (state.fetchVoteList == FetchVoteList.failed) {
                  return Expanded(
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Error Occured',
                            style: AppTextStyles().normal.copyWith(color: Colors.redAccent),
                          ),
                          OutlinedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
                              onPressed: () {
                                context.read<UserDashboardBloc>().add(OnVoteListFetched());
                              },
                              child: Text(
                                'Retry',
                                style: AppTextStyles().normal.copyWith(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  );
                } else if (state.voteList!.isEmpty) {
                  return Expanded(
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No Ongoing Election. Contact your admin to create one',
                              style: AppTextStyles().headers.copyWith(fontSize: 16, color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: state.voteList!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 238, 238, 238),
                                    borderRadius: BorderRadiusDirectional.circular(15)),
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.voteList![index].$1,
                                        style: AppTextStyles().normal,
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        child: ListView.separated(
                                            separatorBuilder: (context, index) => const Gap(10),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.voteList![index].$2.length,
                                            itemBuilder: (context, subIndex) {
                                              return CandidateCard(
                                                index: index,
                                                cid: state.voteList![index].$2[subIndex].cid!,
                                                role: state.voteList![index].$1,
                                                isVoted: state.voteList![index].$2[subIndex].isvoted,
                                                name: state.voteList![index].$2[subIndex].candidateName,
                                                description: state.voteList![index].$2[subIndex].candidateDescription,
                                                imageUrl: state.voteList![index].$2[subIndex].imageUrl,
                                              );
                                            }),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }
              })
            ],
          );
        },
      ),
    );
  }
}
