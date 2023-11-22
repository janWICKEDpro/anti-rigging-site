import 'package:anti_rigging/user_dashboard/bloc/enums.dart';
import 'package:anti_rigging/user_dashboard/bloc/user_dashboard_bloc.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CandidateCard extends StatefulWidget {
  const CandidateCard(
      {super.key,
      this.name,
      this.description,
      this.imageUrl,
      required this.isVoted,
      required this.index,
      required this.cid,
      required this.role});
  final String? name;
  final String? description;
  final String? imageUrl;
  final bool isVoted;
  final String cid;
  final String role;
  final int index;

  @override
  State<CandidateCard> createState() => _CandidateCardState();
}

class _CandidateCardState extends State<CandidateCard> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
            widget.name!,
            style: AppTextStyles().headers.copyWith(color: darkColor, fontSize: 18),
          ),
          const Gap(10),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
                height: 100,
                width: 100,
                child: widget.imageUrl!.isEmpty
                    ? Image.asset('images/realmale.png', fit: BoxFit.none)
                    : Image.network(
                        widget.imageUrl!,
                        fit: BoxFit.cover,
                      )),
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              widget.description!,
              textAlign: TextAlign.center,
              style: AppTextStyles().normal.copyWith(
                    color: primaryColor,
                  ),
            ),
          ),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocListener<UserDashboardBloc, UserDashboardState>(
                listener: (context, state) {
                  if (state.voteStatus != Vote.loading) {
                    setState(() {
                      loading = false;
                    });
                  }
                },
                child: BlocBuilder<UserDashboardBloc, UserDashboardState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(widget.isVoted
                                ? Colors.greenAccent
                                : (state.voteList![widget.index].$2
                                        .where((element) => element.isvoted == true)
                                        .isNotEmpty)
                                    ? const Color.fromARGB(255, 233, 226, 226)
                                    : darkColor)),
                        onPressed: () {
                          if (state.voteList![widget.index].$2.where((element) => element.isvoted == true).isNotEmpty) {
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
                            setState(() {
                              loading = true;
                            });
                            context.read<UserDashboardBloc>().add(OnVote(widget.cid, widget.role));
                          }
                        },
                        child: loading
                            ? LoadingAnimationWidget.hexagonDots(color: Colors.white, size: 15)
                            : Text(
                                widget.isVoted
                                    ? 'Voted'
                                    : (state.voteList![widget.index].$2
                                            .where((element) => element.isvoted == true)
                                            .isNotEmpty)
                                        ? 'No vote'
                                        : 'Vote',
                                style: AppTextStyles().normal.copyWith(color: Colors.white),
                              ));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
