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
  final int index;
  OnRoleNameChanged(this.index, {this.roleName});
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

class OnRoleFieldRemoved extends AdminDashboardEvents {
  int index;
  OnRoleFieldRemoved(this.index);
}

class OnCandidateFieldsRemoved extends AdminDashboardEvents {
  int index;
  int index2;
  OnCandidateFieldsRemoved(this.index, this.index2);
}

class OnIndexIncremented extends AdminDashboardEvents {}
