import 'dart:developer';

import 'package:anti_rigging/services/auth/auth.dart';
import 'package:anti_rigging/services/db/db.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'user_session_event.dart';
part 'user_session_state.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  final auth = AuthenticationService();
  final db = DbService();
  UserSessionBloc() : super(UserSessionInitial()) {
    on<CreateSession>((event, emit) async {
      try {
        await db.deleteSession(auth.status!.uid);
        final docRef = await db.createSession(auth.status!.uid);
        emit(SessionCreated(docRef));
        add(ListenToSession());
      } catch (e) {
        log('$e');
      }
    });
    on<ListenToSession>((event, emit) {
      if (state is SessionCreated) {
        (state as SessionCreated).docRef.snapshots().listen((snapshots) {
          log('Got a snapshot');
          if (!snapshots.exists) {
            add(OnSessionDeleted());
          }
        });
      }
    });
    on<OnSessionDeleted>((event, emit) {
      emit(SessionDeleted());
    });
  }
}
