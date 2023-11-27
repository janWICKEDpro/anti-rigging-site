import 'dart:async';
import 'dart:developer';

import 'package:anti_rigging/services/auth/auth.dart';
import 'package:anti_rigging/services/db/db.dart';
import 'package:anti_rigging/services/storage/storage.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'user_session_event.dart';
part 'user_session_state.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  final auth = AuthenticationService();
  final db = DbService();
  final storage = Storage();
  StreamSubscription? subscription;
  UserSessionBloc() : super(UserSessionInitial()) {
    on<CreateSession>((event, emit) async {
      try {
        int? sessionId = await storage.getCachedSession();
        if (sessionId != null) {
          final doc = await db.getSession(auth.status!.uid);
          if (doc!.data()!['sessionId'] != sessionId) {
            await db.deleteSession(auth.status!.uid);

            final docRef = await db.createSession(auth.status!.uid, sessionId);
            emit(SessionCreated(docRef));
            log('New Session Created');
            add(ListenToSession());
          } else {
            emit(SessionCreated(doc.reference));
            log('No new session');
            add(ListenToSession());
          }
        } else {
          await db.deleteSession(auth.status!.uid);
          final newSessionId = await storage.cacheSession();
          final docRef = await db.createSession(auth.status!.uid, newSessionId);
          emit(SessionCreated(docRef));
          log('New Session Created');
          add(ListenToSession());
        }
      } catch (e) {
        log('$e');
        emit(FailedToEstablishSession());
      }
    });
    on<ListenToSession>((event, emit) {
      if (state is SessionCreated) {
        subscription = (state as SessionCreated).docRef.snapshots().listen((snapshots) {
          if (!snapshots.exists) {
            log('something got deleted');
            subscription?.cancel();
            add(OnSessionDeleted());
          }
        });
      }
    });
    on<OnSessionDeleted>((event, emit) {
      subscription?.cancel();
      emit(SessionDeleted());
    });
  }
}
