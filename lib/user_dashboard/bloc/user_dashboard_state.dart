part of 'user_dashboard_bloc.dart';

class UserDashboardState {
  final AppUser? user;
  final Election? election;
  final FetchInfo fetchInfo;
  final FetchVoteList fetchVoteList;

  UserDashboardState({
    this.user,
    this.election,
    this.fetchInfo = FetchInfo.loading,
    this.fetchVoteList = FetchVoteList.loading,
  });

  UserDashboardState copyWith(
      {AppUser? user,
      FetchInfo? fetchInfo,
      FetchVoteList? fetchVoteList,
      Election? election}) {
    return UserDashboardState(
        user: user ?? this.user,
        election: election ?? this.election,
        fetchInfo: fetchInfo ?? this.fetchInfo,
        fetchVoteList: fetchVoteList ?? this.fetchVoteList);
  }
}
