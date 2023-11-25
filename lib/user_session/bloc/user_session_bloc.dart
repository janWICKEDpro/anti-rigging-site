import 'dart:developer';

import 'package:anti_rigging/services/auth/auth.dart';
import 'package:anti_rigging/services/db/db.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'user_session_event.dart';
part 'user_session_state.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  final auth = AuthenticationService();
  final db = DbService();
  UserSessionBloc() : super(UserSessionInitial()) {
    on<CreateSession>((event, emit) async {
      log('Creating Session');
      try {
        final String? device;
        if (kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
          device = TargetPlatform.iOS.toString();
        } else if (kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
          device = TargetPlatform.android.toString();
        } else {
          final deviceInfoPlugin = DeviceInfoPlugin();
          final deviceInfo = await deviceInfoPlugin.webBrowserInfo;
          device = deviceInfo.browserName.toString();
        }
        final deleteRes = await db.deleteSession(auth.status!.uid, device);
        if (deleteRes != null) {
          emit(SessionCreated(deleteRes));
          log('No new session');
          add(ListenToSession());
        } else {
          final docRef = await db.createSession(auth.status!.uid, device);
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
