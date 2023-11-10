import 'package:anti_rigging/models/candidate.dart';
import 'package:anti_rigging/models/election.dart';

class AdminDashBoardState {
  final Election? election;

  final List<(String, List<Candidate>)>? candidateRoles;
  final bool? loadinSave;
  final bool? loadingElection;
  final int? stackedIndex;

  const AdminDashBoardState(
      {this.election,
      this.stackedIndex = 0,
      this.candidateRoles,
      this.loadinSave = false,
      this.loadingElection});

  AdminDashBoardState copyWith(
      {Election? elect,
      List<(String, List<Candidate>)>? candidates,
      bool? loadSave,
      int? index,
      bool? loadElection}) {
    return AdminDashBoardState(
        loadinSave: loadinSave,
        stackedIndex: index,
        election: elect ?? election,
        candidateRoles: candidates ?? candidateRoles);
  }
}
