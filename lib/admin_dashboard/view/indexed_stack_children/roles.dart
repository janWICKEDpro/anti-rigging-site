import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_bloc.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_events.dart';
import 'package:anti_rigging/admin_dashboard/bloc/admin_dashboard_state.dart';
import 'package:anti_rigging/admin_dashboard/bloc/create_election_enum.dart';
import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Role extends StatefulWidget {
  const Role({super.key});

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  final roleFormKey = GlobalKey<FormState>();
  final candidateFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<AdminDashboardBloc, AdminDashBoardState>(
      builder: (context, state) {
        return SizedBox(
          height: height * 0.7,
          width: width * 0.6,
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
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Roles',
                            style: AppTextStyles().headers.copyWith(color: Colors.white),
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
                        BlocProvider.of<AdminDashboardBloc>(context).add(OnAddRoleButtonClicked());
                      },
                      child: Text(
                        'Add Role +',
                        style: AppTextStyles().normal,
                      ),
                    ),
                    Form(
                      key: roleFormKey,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.candidateRoles?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter A name for this role';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          BlocProvider.of<AdminDashboardBloc>(context)
                                              .add(OnRoleNameChanged(index, roleName: value));
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Role ${index + 1}',
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () {
                                        // setState(() {
                                        //   mainTextFieldValues.removeAt(index);
                                        //   associatedTextFieldValues.removeAt(index);
                                        // });

                                        BlocProvider.of<AdminDashboardBloc>(context).add(OnRoleFieldRemoved(index));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Form(
                                key: candidateFormKey,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.candidateRoles?[index].$2.length ?? 0,
                                  itemBuilder: (context, subIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter A name for candidate';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                // setState(() {
                                                //   associatedTextFieldValues[index][subIndex] = value;
                                                // });
                                                BlocProvider.of<AdminDashboardBloc>(context)
                                                    .add(OnCandidateNameChanged(index, subIndex, candidateName: value));
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Candidate Name ${subIndex + 1}',
                                                contentPadding: EdgeInsets.zero,
                                              ),
                                            ),
                                          ),
                                          const Gap(10),
                                          (state.candidateRoles![index].$2[subIndex].file == null)
                                              ? Expanded(
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        context
                                                            .read<AdminDashboardBloc>()
                                                            .add(OnCandidatePhotoChanged(index, subIndex));
                                                      },
                                                      child: Text(
                                                        'Pick Candidate Image',
                                                        style: AppTextStyles().normal,
                                                      )),
                                                )
                                              : Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                                  child: Image.memory(
                                                    state.candidateRoles![index].$2[subIndex].file!.bytes!,
                                                    scale: 4,
                                                  )),
                                          const Gap(10),
                                          Expanded(
                                            child: Container(
                                              width: width * 0.1,
                                              padding: const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please enter A Description for candidate';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (description) {
                                                    context.read<AdminDashboardBloc>().add(
                                                        OnCandidateDescriptionChanged(index, subIndex,
                                                            candidateDescription: description));
                                                  },
                                                  maxLength: 150,
                                                  maxLines: null, // Allows the text field to expand vertically
                                                  keyboardType: TextInputType.multiline,
                                                  decoration: const InputDecoration(
                                                    hintText: 'Candidate Description',
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              BlocProvider.of<AdminDashboardBloc>(context)
                                                  .add(OnCandidateFieldsRemoved(index, subIndex));
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Gap(5),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<AdminDashboardBloc>().add(OnAddCandidateButtonClicked(index));
                                },
                                child: Icon(Icons.add),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(55),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
                    onPressed: () {
                      if (state.createELectionEnum == CreateELectionEnum.success) {
                        Navigator.pop(context);
                        context.read<AdminDashboardBloc>().add(OnElectionFetchedEvent());
                      } else {
                        if (state.candidateRoles!.isEmpty) {
                          context.read<AdminDashboardBloc>().add(OnLaunchElectionsClicked());
                        } else {
                          if (roleFormKey.currentState!.validate() && candidateFormKey.currentState!.validate()) {
                            context.read<AdminDashboardBloc>().add(OnLaunchElectionsClicked());
                          }
                        }
                      }
                    },
                    child: state.createELectionEnum == CreateELectionEnum.loading
                        ? LoadingAnimationWidget.hexagonDots(color: const Color.fromARGB(255, 34, 20, 20), size: 25)
                        : Text(
                            state.createELectionEnum == CreateELectionEnum.success ? "Continue" : "Launch Elections",
                            style: AppTextStyles().normal.copyWith(color: Colors.white),
                          ),
                  ),
                ),
                Center(
                  child: state.createELectionEnum == CreateELectionEnum.failed
                      ? (state.candidateRoles!.isEmpty)
                          ? Text(
                              "Please Enter Roles and Candidate Information",
                              style: AppTextStyles().normal.copyWith(color: Colors.redAccent),
                            )
                          : Text(
                              "Failed To Create Elections",
                              style: AppTextStyles().normal.copyWith(color: Colors.redAccent),
                            )
                      : Container(),
                ),
                const Gap(10)
              ],
            ),
          ),
        );
      },
    );
  }
}
