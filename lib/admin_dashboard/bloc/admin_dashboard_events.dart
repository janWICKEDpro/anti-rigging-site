sealed class AdminDashboardEvents {}

class OnElectionFetchedEvent extends AdminDashboardEvents {}

class OnElectionNameChanged extends AdminDashboardEvents {
  final String? electionName;
  OnElectionNameChanged({this.electionName});
}

class OnEndDateFieldChanged extends AdminDashboardEvents {}

class OnAddRoleButtonClicked extends AdminDashboardEvents {}

class OnAddCandidateButtonClicked extends AdminDashboardEvents {
  int index;
  OnAddCandidateButtonClicked(this.index);
}

class OnRoleNameChanged extends AdminDashboardEvents {
  final String? roleName;
  final int index;
  OnRoleNameChanged(this.index, {this.roleName});
}

class OnCandidateNameChanged extends AdminDashboardEvents {
  final String? candidateName;
  int index;
  int index2;
  OnCandidateNameChanged(this.index, this.index2, {this.candidateName});
}

class OnCandidateDescriptionChanged extends AdminDashboardEvents {
  final String? candidateDescription;
  int index;
  int index2;
  OnCandidateDescriptionChanged(this.index, this.index2,
      {this.candidateDescription});
}

class OnCandidatePhotoChanged extends AdminDashboardEvents {
  int index;
  int index2;

  OnCandidatePhotoChanged(this.index, this.index2);
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

class OnLaunchElectionsClicked extends AdminDashboardEvents {}

class OnSideBarNavigationIndexChanged extends AdminDashboardEvents {
  int index;
  OnSideBarNavigationIndexChanged(this.index);
}
