import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_events.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Role extends StatefulWidget {
  const Role({super.key});

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  List<String> mainTextFieldValues = [];
  List<List<String>> associatedTextFieldValues = [];

  List<bool> mainFieldValidations = [];
  List<List<bool>> associatedFieldValidations = [];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<AdminDashboardBloc, AdminDashBoardState>(
      builder: (context, state) {
        return SizedBox(
          height: height * 0.4,
          width: width * 0.4,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Roles',
                            style: AppTextStyles()
                                .headers
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // mainTextFieldValues.add('');
                        // associatedTextFieldValues.add([]);
                        // setState(() {});
                        BlocProvider.of<AdminDashboardBloc>(context)
                            .add(OnAddRoleButtonClicked());
                      },
                      child: Icon(Icons.add),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.candidateRoles!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        BlocProvider.of<AdminDashboardBloc>(
                                                context)
                                            .add(OnRoleNameChanged(index,
                                                roleName: value));
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Text Field ${index + 1}',
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      // setState(() {
                                      //   mainTextFieldValues.removeAt(index);
                                      //   associatedTextFieldValues.removeAt(index);
                                      // });

                                      BlocProvider.of<AdminDashboardBloc>(
                                              context)
                                          .add(OnRoleFieldRemoved(index));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.candidateRoles![index].$2.length,
                              itemBuilder: (context, subIndex) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(left: 16.0, right: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          onChanged: (value) {
                                            // setState(() {
                                            //   associatedTextFieldValues[index][subIndex] = value;
                                            // });
                                            BlocProvider.of<AdminDashboardBloc>(
                                                    context)
                                                .add(OnCandidateNameChanged(
                                                    candidateName: value));
                                          },
                                          decoration: InputDecoration(
                                            labelText:
                                                'Sub Field ${subIndex + 1}',
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          // setState(() {
                                          //   associatedTextFieldValues[index].removeAt(subIndex);
                                          // });
                                          BlocProvider.of<AdminDashboardBloc>(
                                                  context)
                                              .add(OnCandidateFieldsRemoved(
                                                  index, subIndex));
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // setState(() {
                                //   associatedTextFieldValues[index].add('');
                                // });
                                context
                                    .read<AdminDashboardBloc>()
                                    .add(OnAddCandidateButtonClicked(index));
                              },
                              child: Icon(Icons.add),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
