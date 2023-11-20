part of 'user_dashboard_bloc.dart';

sealed class UserDashboardEvent extends Equatable {
  const UserDashboardEvent();

  @override
  List<Object> get props => [];
}

class OnFetchDashboardInfo extends UserDashboardEvent {}

class OnVoteListFetched extends UserDashboardEvent {}

class OnSignoutClicked extends UserDashboardEvent {}

class OnVote extends UserDashboardEvent {
  final String candidateId;
  final String role;
  OnVote(this.candidateId, this.role);
}
