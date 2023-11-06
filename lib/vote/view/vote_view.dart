import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/widgets/candidate_card.dart';
import 'package:flutter/material.dart';

class VoteView extends StatefulWidget {
  const VoteView({super.key});

  @override
  State<VoteView> createState() => _VoteViewState();
}

class _VoteViewState extends State<VoteView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You May Now Cast Your Votes',
          style: AppTextStyles().headers.copyWith(color: primaryColor),
        ),
        CandidateCard()
      ],
    );
  }
}
