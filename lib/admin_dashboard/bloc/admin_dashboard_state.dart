import 'package:anti_rigging/admin_dashboard/bloc/create_election_enum.dart';
import 'package:anti_rigging/enums.dart';
import 'package:anti_rigging/models/candidate.dart';
import 'package:anti_rigging/models/election.dart';

class AdminDashBoardState {
  final Election? election;

  final List<(String, List<Candidate>)>? candidateRoles;
  final List<Election>? electionsList;
  final CreateELectionEnum createELectionEnum;
  final bool? loadingElection;
  final bool? noActiveElection;
  int stackedIndex;
  int sideBarNavigationIndex;
  Fetch fetchElection;
  FetchList fetchList;
  LoginStatus loginStatus;

  AdminDashBoardState(
      {this.election,
      this.electionsList,
      this.loginStatus = LoginStatus.signedIn,
      this.fetchList = FetchList.loading,
      this.noActiveElection = false,
      this.sideBarNavigationIndex = 0,
      this.fetchElection = Fetch.loading,
      this.createELectionEnum = CreateELectionEnum.initial,
      this.stackedIndex = 0,
      this.candidateRoles,
      this.loadingElection});

  AdminDashBoardState copyWith(
      {Election? elect,
      List<(String, List<Candidate>)>? candidates,
      int? index,
      List<Election>? list,
      int? sideBarNav,
      bool? noActive,
      LoginStatus? loginStatus,
      Fetch? fetchElections,
      FetchList? listFetch,
      CreateELectionEnum? create,
      bool? loadElection}) {
    return AdminDashBoardState(
        fetchList: listFetch ?? fetchList,
        noActiveElection: noActive ?? noActiveElection,
        fetchElection: fetchElections ?? fetchElection,
        electionsList: list ?? electionsList,
        createELectionEnum: create ?? createELectionEnum,
        stackedIndex: index ?? stackedIndex,
        election: elect ?? election,
        loginStatus: loginStatus ?? this.loginStatus,
        sideBarNavigationIndex: sideBarNav ?? sideBarNavigationIndex,
        candidateRoles: candidates ?? candidateRoles);
  }
}
