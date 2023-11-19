import 'dart:developer';

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
      emit(state.copyWith(fetchVoteList: FetchVoteList.success));
    } catch (e) {
      emit(state.copyWith(fetchVoteList: FetchVoteList.failed));
    }
  }
}
