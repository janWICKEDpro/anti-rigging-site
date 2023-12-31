import 'dart:developer';

import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_events.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:anti_rigging/admin_dashboard/bloc/create_election_enum.dart';
import 'package:anti_rigging/enums.dart';
import 'package:anti_rigging/models/candidate.dart';
import 'package:anti_rigging/models/election.dart';
import 'package:anti_rigging/services/auth/auth.dart';
import 'package:anti_rigging/services/db/db.dart';
import 'package:anti_rigging/services/pick_file.dart';
import 'package:anti_rigging/user_dashboard/view/data_source.dart';
import 'package:anti_rigging/user_session/bloc/user_session_bloc.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvents, AdminDashBoardState> {
  final filepicker = FilePickerMethods();
  final db = DbService();
  final auth = AuthenticationService();
  final UserSessionBloc userSession;
  AdminDashboardBloc(this.userSession) : super(AdminDashBoardState(candidateRoles: [])) {
    on<OnElectionNameChanged>((event, emit) {
      emit(state.copyWith(
          elect: Election(
              startDate: DateTime.now(),
              isActive: true,
              electionName: event.electionName,
              endDate: DateTime.now().add(const Duration(days: 14)))));
    });
    on<OnAddRoleButtonClicked>((event, emitvalue) {
      final arr = [...state.candidateRoles!];
      arr.add(('1', []));
      log('$arr');
      // state.candidateRoles!.addAll([]);
      emitvalue(state.copyWith(candidates: arr, create: CreateELectionEnum.initial));
    });
    on<OnAddCandidateButtonClicked>((event, emit) {
      log('${state.candidateRoles![event.index].$2}');
      state.candidateRoles![event.index].$2.add(Candidate());
      emit(state.copyWith(
        candidates: state.candidateRoles,
      ));
    });
    on<OnRoleNameChanged>((event, emit) {
      state.candidateRoles![event.index] = (event.roleName!, state.candidateRoles![event.index].$2);
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
      emit(state.copyWith(index: ++state.stackedIndex));
    });
    on<OnCandidatePhotoChanged>(
      (event, emit) async {
        final photo = await filepicker.pickFile();
        state.candidateRoles![event.index].$2[event.index2].file = photo;
        emit(state.copyWith(candidates: state.candidateRoles));
      },
    );
    on<OnCandidateDescriptionChanged>((event, emit) {
      state.candidateRoles![event.index].$2[event.index2].candidateDescription = event.candidateDescription;
      emit(state.copyWith(candidates: state.candidateRoles));
    });
    on<OnCandidateNameChanged>((event, emit) {
      state.candidateRoles![event.index].$2[event.index2].candidateName = event.candidateName;
      emit(state.copyWith(candidates: state.candidateRoles));
    });

    on<OnLaunchElectionsClicked>(_onLaunchElectionsClicked);
    on<OnElectionFetchedEvent>(_onElectionFetched);
    on<OnElectionListFetched>(_onElectionListFetched);
    on<OnEndElection>(_onEndElection);
    on<OnSideBarNavigationIndexChanged>((event, emit) {
      state.sideBarNavigationIndex = event.index;
      emit(state.copyWith(sideBarNav: state.sideBarNavigationIndex));
    });
    on<OnSignOutButtonClicked>((event, emit) async {
      await auth.signOut();
      emit(state.copyWith(loginStatus: LoginStatus.signedOut));
    });
  }

  _onLaunchElectionsClicked(OnLaunchElectionsClicked event, Emitter<AdminDashBoardState> emit) async {
    emit(state.copyWith(create: CreateELectionEnum.loading));
    try {
      await db.createElection(state.candidateRoles!, state.election!);
      emit(state.copyWith(create: CreateELectionEnum.success));
    } catch (e) {
      emit(state.copyWith(create: CreateELectionEnum.failed));
    }
  }

  _onEndElection(OnEndElection event, Emitter<AdminDashBoardState> emit) async {
    emit(state.copyWith(create: CreateELectionEnum.loading));

    try {
      await db.endElection();
      emit(state.copyWith(create: CreateELectionEnum.success, candidates: []));
      add(OnElectionFetchedEvent());
    } catch (e) {
      log('$e');
      emit(state.copyWith(create: CreateELectionEnum.failed));
    }
  }

  _onElectionFetched(OnElectionFetchedEvent event, Emitter<AdminDashBoardState> emit) async {
    emit(state.copyWith(fetchElections: Fetch.loading, create: CreateELectionEnum.initial));
    try {
      userSession.add(CreateSession());
      final elec = await db.getActiveElection();
      final election = await db.getActiveElectionInfo();
      if (election.isEmpty) {
        emit(state.copyWith(fetchElections: Fetch.success, noActive: true));
        log('length of list is:${state.candidateRoles?.length}');
      } else {
        emit(state.copyWith(
            fetchElections: Fetch.success,
            noActive: false,
            candidates: election,
            meeting: [Meeting('Vote Period', elec!.startDate, elec.endDate!, primaryColor, true)]));
        log('length of list is :${state.candidateRoles?.length}');
      }
    } catch (e) {
      log('$e');
      emit(state.copyWith(fetchElections: Fetch.failed));
    }
  }

  _onElectionListFetched(OnElectionListFetched event, Emitter<AdminDashBoardState> emit) async {
    emit(state.copyWith(listFetch: FetchList.loading));
    try {
      final elections = await db.getElections();

      emit(state.copyWith(listFetch: FetchList.success, list: elections));
    } catch (e) {
      log('$e');
      emit(state.copyWith(listFetch: FetchList.failed));
    }
  }
}
