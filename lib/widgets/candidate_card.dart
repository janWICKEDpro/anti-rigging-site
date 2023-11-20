import 'package:anti_rigging/user_dashboard/bloc/user_dashboard_bloc.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CandidateCard extends StatelessWidget {
  const CandidateCard(
      {super.key, this.name, this.description, this.imageUrl, required this.isVoted, required this.index});
  final String? name;
  final String? description;
  final String? imageUrl;
  final bool isVoted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lightColor, Colors.white, Colors.white, Colors.white],
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name!,
            style: AppTextStyles().headers.copyWith(color: darkColor, fontSize: 18),
          ),
          const Gap(15),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
                height: 100,
                width: 100,
                child: imageUrl!.isEmpty ? Image.asset('images/realmale.png') : Image.network(imageUrl!)),
          ),
          const Gap(15),
          Text(
            description!,
            textAlign: TextAlign.center,
            style: AppTextStyles().normal.copyWith(
                  color: primaryColor,
                ),
          ),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<UserDashboardBloc, UserDashboardState>(
                builder: (context, state) {
                  return ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(isVoted
                              ? Colors.greenAccent
                              : (state.voteList![index].$2.where((element) => element.isvoted == true).isNotEmpty)
                                  ? const Color.fromARGB(255, 233, 226, 226)
                                  : darkColor)),
                      onPressed: () {
                        if (state.voteList![index].$2.where((element) => element.isvoted == true).isNotEmpty) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Center(
                                  child: Text(
                                    "Already Voted For this role",
                                    style: AppTextStyles().normal.copyWith(color: Colors.white),
                                  ),
                                )));
                        } else {
                          context.read<UserDashboardBloc>().add(OnVote());
                        }
                      },
                      child: Text(
                        isVoted
                            ? 'Voted'
                            : (state.voteList![index].$2.where((element) => element.isvoted == true).isNotEmpty)
                                ? ''
                                : 'Vote',
                        style: AppTextStyles().normal.copyWith(color: lightColor),
                      ));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
