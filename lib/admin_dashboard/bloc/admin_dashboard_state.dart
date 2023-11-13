import 'package:anti_rigging/admin_dashboard/bloc/create_election_enum.dart';
import 'package:anti_rigging/models/candidate.dart';
import 'package:anti_rigging/models/election.dart';

class AdminDashBoardState {
  final Election? election;

  final List<(String, List<Candidate>)>? candidateRoles;
  final CreateELectionEnum createELectionEnum;
  final bool? loadingElection;
  int stackedIndex;
  int sideBarNavigationIndex;

  AdminDashBoardState(
      {this.election,
      this.sideBarNavigationIndex = 0,
      this.createELectionEnum = CreateELectionEnum.initial,
      this.stackedIndex = 0,
      this.candidateRoles,
      this.loadingElection});

  AdminDashBoardState copyWith(
      {Election? elect,
      List<(String, List<Candidate>)>? candidates,
      int? index,
      int? sideBarNav,
      CreateELectionEnum? create,
      bool? loadElection}) {
    return AdminDashBoardState(
        createELectionEnum: create ?? createELectionEnum,
        stackedIndex: index ?? stackedIndex,
        election: elect ?? election,
        sideBarNavigationIndex: sideBarNav ?? sideBarNavigationIndex,
        candidateRoles: candidates ?? candidateRoles);
  }
}
