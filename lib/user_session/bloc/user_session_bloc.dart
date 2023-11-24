import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_session_event.dart';
part 'user_session_state.dart';

class UserSessionBloc extends Bloc<UserSessionEvent, UserSessionState> {
  UserSessionBloc() : super(UserSessionInitial()) {
    on<UserSessionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
