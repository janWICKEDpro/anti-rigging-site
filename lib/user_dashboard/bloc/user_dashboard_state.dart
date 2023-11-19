part of 'user_dashboard_bloc.dart';

class UserDashboardState {
  final AppUser? user;
  final Election? election;
  final FetchInfo fetchInfo;
  final FetchVoteList fetchVoteList;
  final List<(String, List<Candidate>, bool)>? voteList;

  UserDashboardState({
    this.user,
    this.voteList,
    this.election,
    this.fetchInfo = FetchInfo.loading,
    this.fetchVoteList = FetchVoteList.loading,
  });

  UserDashboardState copyWith(
      {AppUser? user,
      FetchInfo? fetchInfo,
      FetchVoteList? fetchVoteList,
      List<(String, List<Candidate>, bool)>? voteList,
      Election? election}) {
    return UserDashboardState(
        voteList: voteList ?? this.voteList,
        user: user ?? this.user,
        election: election ?? this.election,
        fetchInfo: fetchInfo ?? this.fetchInfo,
        fetchVoteList: fetchVoteList ?? this.fetchVoteList);
  }
}
