part of 'user_session_bloc.dart';

sealed class UserSessionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateSession extends UserSessionEvent {}

class ListenToSession extends UserSessionEvent {}

class OnSessionDeleted extends UserSessionEvent {}
