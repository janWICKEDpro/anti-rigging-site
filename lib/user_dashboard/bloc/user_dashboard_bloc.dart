import 'dart:developer';

import 'package:anti_rigging/enums.dart';
import 'package:anti_rigging/models/candidate.dart';
import 'package:anti_rigging/models/election.dart';
import 'package:anti_rigging/models/user.dart';
import 'package:anti_rigging/services/auth/auth.dart';
import 'package:anti_rigging/services/db/db.dart';
import 'package:anti_rigging/user_dashboard/bloc/enums.dart';
import 'package:anti_rigging/user_dashboard/view/data_source.dart';
import 'package:anti_rigging/user_session/bloc/user_session_bloc.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_dashboard_event.dart';
part 'user_dashboard_state.dart';

class UserDashboardBloc extends Bloc<UserDashboardEvent, UserDashboardState> {
  final auth = AuthenticationService();
  final db = DbService();
  final UserSessionBloc userSession;
  UserDashboardBloc(this.userSession) : super(UserDashboardState()) {
    on<OnFetchDashboardInfo>((event, emit) async {
      //get user
      emit(state.copyWith(fetchInfo: FetchInfo.loading, loginStatus: LoginStatus.signedIn));
      try {
        userSession.add(CreateSession());
        final user = await db.getUser(auth.status!.uid);

        final election = await db.getActiveElection();

        if (election != null) {
          final meetings = [Meeting('Vote Period', election.startDate, election.endDate!, darkColor, true)];
          emit(state.copyWith(user: user, election: election, fetchInfo: FetchInfo.success, mettings: meetings));
        } else {
          emit(state.copyWith(user: user, election: election, fetchInfo: FetchInfo.noElection));
        }
      } catch (e) {
        log('$e');
        emit(state.copyWith(fetchInfo: FetchInfo.failed));
      }
    });

    on<OnVoteListFetched>(_onVoteListFetched);
    on<OnVote>(_onVote);
    on<OnSignoutClicked>(
      (event, emit) async {
        await auth.signOut();
        emit(state.copyWith(loginStatus: LoginStatus.signedOut));
      },
    );
  }

  _onVoteListFetched(OnVoteListFetched event, Emitter<UserDashboardState> emit) async {
    emit(state.copyWith(fetchVoteList: FetchVoteList.loading));
    try {
      // final electionName = await db.getActiveElection(); redundancy
      final roles = await db.getActiveElectionInfo();

      final voted = await db.userVotes(auth.status!.uid);
      log('${voted.length}');
      final List<(String, List<Candidate>, bool)> finalVotedList = [];
      for (var role in roles) {
        if (voted.isNotEmpty) {
          final item = voted
              .where((vote) => vote.id.compareTo(auth.status!.uid + state.election!.electionName! + role.$1) == 0)
              .toList();
          if (item.isNotEmpty) {
            final candidateList = role.$2.map((element) {
              if (element.cid == (item[0].data() as Map<String, dynamic>)['candidateId']) {
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
          } else {
            finalVotedList.add((role.$1, role.$2, false));
          }
        } else {
          log('should run');
          finalVotedList.add((role.$1, role.$2, false));
        }
      }

      emit(state.copyWith(fetchVoteList: FetchVoteList.success, voteList: finalVotedList));
      log('${state.voteList!.length}');
    } catch (e) {
      log('$e');
      emit(state.copyWith(fetchVoteList: FetchVoteList.failed));
    }
  }

  _onVote(OnVote event, Emitter<UserDashboardState> emit) async {
    emit(state.copyWith(voteStatus: Vote.loading));
    try {
      await db.vote(state.election!.electionName!, event.role, event.candidateId, auth.status!.uid);

      emit(state.copyWith(voteStatus: Vote.success));
      add(OnVoteListFetched());
    } catch (e) {
      log('$e');
      emit(state.copyWith(voteStatus: Vote.failed));
    }
  }
}





// if (vote.id.compareTo(auth.status!.uid + state.election!.electionName! + role.$1) == 0) {
//               final candidateList = role.$2.map((element) {
//                 if (element.cid == (vote.data() as Map<String, dynamic>)['candidateId']) {
//                   return Candidate(
//                       candidateDescription: element.candidateDescription,
//                       candidateName: element.candidateName,
//                       imageUrl: element.imageUrl,
//                       cid: element.cid,
//                       votes: element.votes,
//                       isvoted: true,
//                       file: element.file);
//                 } else {
//                   return element;
//                 }
//               }).toList();
//               finalVotedList.add((role.$1, candidateList, true));
//             }