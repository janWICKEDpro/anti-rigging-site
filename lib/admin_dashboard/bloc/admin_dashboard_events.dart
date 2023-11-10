sealed class AdminDashboardEvents {}

class OnElectionFetchedEvent extends AdminDashboardEvents {}

class OnElectionNameChanged extends AdminDashboardEvents {
  final String? electionName;
  OnElectionNameChanged({this.electionName});
}

class OnEndDateFieldChanged extends AdminDashboardEvents {}

class OnAddRoleButtonClicked extends AdminDashboardEvents {}

class OnAddCandidateButtonClicked extends AdminDashboardEvents {}

class OnRoleNameChanged extends AdminDashboardEvents {
  final String? roleName;
  OnRoleNameChanged({this.roleName});
}

class OnCandidateNameChanged extends AdminDashboardEvents {
  final String? candidateName;
  OnCandidateNameChanged({this.candidateName});
}

class OnCandidateDescriptionChanged extends AdminDashboardEvents {
  final String? candidateDescription;
  OnCandidateDescriptionChanged({this.candidateDescription});
}

class OnCandidatePhotoChanged extends AdminDashboardEvents {
  final XFile? photo;
  OnCandidatePhotoChanged({this.photo});
}

class OnIndexIncremented extends AdminDashboardEvents {}
