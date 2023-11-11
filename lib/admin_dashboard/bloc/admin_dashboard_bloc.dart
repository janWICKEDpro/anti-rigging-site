import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_events.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvents, AdminDashBoardState> {
  AdminDashboardBloc() : super(const AdminDashBoardState()) {
    on<OnAddRoleButtonClicked>((event, emitvalue) {
      state.candidateRoles!.add(('', []));
      emitvalue(state.copyWith(candidates: state.candidateRoles));
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
    on<OnCandidateFieldsRemoved>((event, emit) => null);
  }
}
