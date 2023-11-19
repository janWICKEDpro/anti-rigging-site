import 'dart:developer';

import 'package:anti_rigging/models/candidate.dart';
import 'package:anti_rigging/models/election.dart';
import 'package:anti_rigging/models/user.dart';
import 'package:anti_rigging/services/auth/auth.dart';
import 'package:anti_rigging/services/db/db.dart';
import 'package:anti_rigging/user_dashboard/bloc/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_dashboard_event.dart';
part 'user_dashboard_state.dart';

class UserDashboardBloc extends Bloc<UserDashboardEvent, UserDashboardState> {
  final auth = AuthenticationService();
  final db = DbService();
  UserDashboardBloc() : super(UserDashboardState()) {
    on<OnFetchDashboardInfo>((event, emit) async {
      //get user
      emit(state.copyWith(fetchInfo: FetchInfo.loading));
      try {
        final user = await db.getUser(auth.status!.uid);

        final election = await db.getActiveElection();
        if (election != null) {
          emit(state.copyWith(
              user: user, election: election, fetchInfo: FetchInfo.success));
        } else {
          emit(state.copyWith(
              user: user, election: election, fetchInfo: FetchInfo.noElection));
        }
      } catch (e) {
        log('$e');
        emit(state.copyWith(fetchInfo: FetchInfo.failed));
      }
    });

    on<OnVoteListFetched>(_onVoteListFetched);
  }

  _onVoteListFetched(
      OnVoteListFetched event, Emitter<UserDashboardState> emit) async {
    emit(state.copyWith(fetchVoteList: FetchVoteList.loading));
    try {
      // final electionName = await db.getActiveElection(); redundancy
      final roles = await db.getActiveElectionInfo();

      final voted = await db.userVotes(auth.status!.uid);
      final List<(String, List<Candidate>, bool)> finalVotedList = [];
      for (var role in roles) {
        for (var vote in voted) {
          if (vote.id.compareTo(
                  auth.status!.uid + state.election!.electionName! + role.$1) ==
              0) {
            final candidateList = role.$2.map((element) {
              if (element.cid ==
                  (vote.data() as Map<String, dynamic>)['candidateId']) {
                return Candidate(
                    candidateDescription: element.candidateDescription,
                    candidateName: element.candidateName,
                    imageUrl: element.imageUrl,
                    cid: element.cid,
                    votes: element.votes,
                    isvoted: true,
                    file: element.file);
              } else {
                return element;
              }
            }).toList();
            finalVotedList.add((role.$1, candidateList, true));
          }
        }
      }
      emit(state.copyWith(fetchVoteList: FetchVoteList.success));
    } catch (e) {
      emit(state.copyWith(fetchVoteList: FetchVoteList.failed));
    }
  }
}
