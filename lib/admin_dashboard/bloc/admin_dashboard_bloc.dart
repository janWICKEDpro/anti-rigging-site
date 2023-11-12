import 'dart:developer';

import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_events.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:anti_rigging/models/candidate.dart';
import 'package:anti_rigging/models/election.dart';
import 'package:anti_rigging/services/pick_file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvents, AdminDashBoardState> {
  final filepicker = FilePickerMethods();
  AdminDashboardBloc() : super(AdminDashBoardState(candidateRoles: [])) {
    on<OnElectionNameChanged>((event, emit) {
      emit(state.copyWith(
          elect: Election(
              startDate: DateTime.now(),
              electionName: event.electionName,
              endDate: DateTime.now().add(const Duration(days: 7)))));
    });
    on<OnAddRoleButtonClicked>((event, emitvalue) {
      final arr = [...state.candidateRoles!];
      arr.add(('1', []));
      log('$arr');
      // state.candidateRoles!.addAll([]);
      emitvalue(state.copyWith(candidates: arr));
    });
    on<OnAddCandidateButtonClicked>((event, emit) {
      log('${state.candidateRoles![event.index].$2}');
      state.candidateRoles![event.index].$2.add(Candidate());
      emit(state.copyWith(candidates: state.candidateRoles));
    });
    on<OnRoleNameChanged>((event, emit) {
      state.candidateRoles![event.index] =
          (event.roleName!, state.candidateRoles![event.index].$2);
      emit(state.copyWith(candidates: state.candidateRoles));
    });
    on<OnRoleFieldRemoved>((event, emit) {
      state.candidateRoles!.removeAt(event.index);
      emit(state.copyWith(candidates: state.candidateRoles));
    });
    on<OnCandidateFieldsRemoved>((event, emit) {
      state.candidateRoles![event.index].$2.removeAt(event.index2);
      emit(state.copyWith(candidates: state.candidateRoles));
    });
    on<OnIndexIncremented>((event, emit) {
      state.stackedIndex++;
      emit(state.copyWith(index: state.stackedIndex));
    });
    on<OnCandidatePhotoChanged>(
      (event, emit) async {
        final photo = await filepicker.pickFile();
        state.candidateRoles![event.index].$2[event.index2].file = photo;
        emit(state.copyWith(candidates: state.candidateRoles));
      },
    );
    on<OnCandidateDescriptionChanged>((event, emit) {
      state.candidateRoles![event.index].$2[event.index2].candidateDescription =
          event.candidateDescription;
      emit(state.copyWith(candidates: state.candidateRoles));
    });
    on<OnCandidateNameChanged>((event, emit) {
      state.candidateRoles![event.index].$2[event.index2].candidateDescription =
          event.candidateName;
      emit(state.copyWith(candidates: state.candidateRoles));
    });
  }
}
