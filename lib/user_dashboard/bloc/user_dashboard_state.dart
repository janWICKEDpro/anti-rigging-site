part of 'user_dashboard_bloc.dart';

class UserDashboardState {
  final AppUser? user;
  final FetchInfo fetchInfo;
  final FetchVoteList fetchVoteList;

  UserDashboardState({
    this.user,
    this.fetchInfo = FetchInfo.loading,
    this.fetchVoteList = FetchVoteList.loading,
  });

  UserDashboardState copyWith(
      {AppUser? user, FetchInfo? fetchInfo, FetchVoteList? fetchVoteList}) {
    return UserDashboardState(
        user: user ?? this.user,
        fetchInfo: fetchInfo ?? this.fetchInfo,
        fetchVoteList: fetchVoteList ?? this.fetchVoteList);
  }
}
