import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_events.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvents, AdminDashBoardState> {
  AdminDashboardBloc() : super(AdminDashBoardState()) {}
}
