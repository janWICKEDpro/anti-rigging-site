part of 'user_session_bloc.dart';

sealed class UserSessionState extends Equatable {
  const UserSessionState();

  @override
  List<Object> get props => [];
}

final class UserSessionInitial extends UserSessionState {}

final class SessionCreated extends UserSessionState {
  final DocumentReference<Map<String, dynamic>> docRef;
  const SessionCreated(this.docRef);
}

final class SessionDeleted extends UserSessionState {}

final class FailedToEstablishSession extends UserSessionState {}
