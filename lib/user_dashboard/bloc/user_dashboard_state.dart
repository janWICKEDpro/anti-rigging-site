part of 'user_dashboard_bloc.dart';

class UserDashboardState {
  final AppUser? user;
  final Election? election;
  final FetchInfo fetchInfo;
  final FetchVoteList fetchVoteList;
  final LoginStatus loginStatus;
  final Vote? voteStatus;
  final List<(String, List<Candidate>, bool)>? voteList;

  UserDashboardState({
    this.user,
    this.voteStatus,
    this.voteList,
    this.loginStatus = LoginStatus.signedIn,
    this.election,
    this.fetchInfo = FetchInfo.loading,
    this.fetchVoteList = FetchVoteList.loading,
  });

  UserDashboardState copyWith(
      {AppUser? user,
      FetchInfo? fetchInfo,
      FetchVoteList? fetchVoteList,
      LoginStatus? loginStatus,
      Vote? voteStatus,
      List<(String, List<Candidate>, bool)>? voteList,
      Election? election}) {
    return UserDashboardState(
        voteList: voteList ?? this.voteList,
        user: user ?? this.user,
        voteStatus: voteStatus ?? this.voteStatus,
        loginStatus: loginStatus ?? this.loginStatus,
        election: election ?? this.election,
        fetchInfo: fetchInfo ?? this.fetchInfo,
        fetchVoteList: fetchVoteList ?? this.fetchVoteList);
  }
}
