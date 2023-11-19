import 'package:anti_rigging/user_dashboard/bloc/user_dashboard_bloc.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          ],
        );
      },
    );
  }
}
