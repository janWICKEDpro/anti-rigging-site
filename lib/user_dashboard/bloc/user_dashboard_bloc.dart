import 'package:anti_rigging/models/user.dart';
import 'package:anti_rigging/services/auth/auth.dart';
import 'package:anti_rigging/user_dashboard/bloc/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_dashboard_event.dart';
part 'user_dashboard_state.dart';

class UserDashboardBloc extends Bloc<UserDashboardEvent, UserDashboardState> {
  final auth = AuthenticationService();
  UserDashboardBloc() : super(UserDashboardState()) {
    on<OnFetchDashboardInfo>((event, emit) {});
  }
}
