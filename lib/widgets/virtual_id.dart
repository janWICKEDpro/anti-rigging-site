import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class VirtualId extends StatelessWidget {
  const VirtualId({super.key, this.name, this.programe, this.regno});
  final String? name;
  final String? regno;
  final String? programe;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return Container(
          height: 300,
          width: width * 0.4,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 238, 236, 236),
                  Color.fromARGB(255, 233, 232, 232),
                  Color.fromARGB(255, 226, 226, 226),
                  Color.fromARGB(255, 177, 175, 175),
                  Color.fromARGB(255, 161, 159, 159),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              color: const Color.fromARGB(255, 221, 216, 216),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Student Card',
                  style: AppTextStyles().headers.copyWith(fontSize: 20, color: primaryColor),
                ),
                const Padding(
                  padding: EdgeInsets.all(2),
                  child: Divider(),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('NAME:', style: AppTextStyles().headers.copyWith(fontSize: 16, color: darkColor)),
                                Gap(15),
                                Text(
                                  name!,
                                  style:
                                      AppTextStyles().normal.copyWith(fontSize: constraints.maxWidth < 600 ? 12 : null),
                                ),
                              ],
                            ),
                            const Gap(15),
                            Row(
                              children: [
                                Text('REGNO:',
                                    style: AppTextStyles()
                                        .headers
                                        .copyWith(fontSize: constraints.maxWidth < 600 ? 10 : 16, color: darkColor)),
                                const Gap(5),
                                Text(
                                  regno!,
                                  style:
                                      AppTextStyles().normal.copyWith(fontSize: constraints.maxWidth < 600 ? 12 : null),
                                ),
                              ],
                            ),
                            Gap(constraints.maxWidth < 600 ? 10 : 15),
                            Row(
                              children: [
                                Text('PROGRAMME:',
                                    style: AppTextStyles()
                                        .headers
                                        .copyWith(fontSize: constraints.maxWidth < 600 ? 10 : 16, color: darkColor)),
                                const Gap(5),
                                Wrap(children: [
                                  Container(
                                    child: Text(
                                      programe!,
                                      softWrap: true,
                                      style: AppTextStyles()
                                          .normal
                                          .copyWith(fontSize: constraints.maxWidth < 600 ? 12 : null),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                            const Gap(30),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                'assets/images/9185570.png',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/kigali_bg.png',
                                height: constraints.maxWidth < 600
                                    ? MediaQuery.of(context).size.height * 0.2
                                    : MediaQuery.of(context).size.height * 0.25,
                                width: constraints.maxWidth < 600
                                    ? MediaQuery.of(context).size.height * 0.25
                                    : MediaQuery.of(context).size.height * 0.3,
                              ),
                              const Gap(4),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      }
      return Container(
        height: width * 0.6,
        width: width * 0.87,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 238, 236, 236),
                Color.fromARGB(255, 233, 232, 232),
                Color.fromARGB(255, 226, 226, 226),
                Color.fromARGB(255, 177, 175, 175),
                Color.fromARGB(255, 161, 159, 159),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            color: const Color.fromARGB(255, 221, 216, 216),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Student Card',
                style: AppTextStyles()
                    .headers
                    .copyWith(fontSize: constraints.maxWidth < 600 ? 15 : 20, color: primaryColor),
              ),
              const Padding(
                padding: EdgeInsets.all(2),
                child: Divider(),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('NAME:',
                                  style: AppTextStyles()
                                      .headers
                                      .copyWith(fontSize: constraints.maxWidth < 600 ? 10 : 16, color: darkColor)),
                              Gap(constraints.maxWidth < 600 ? 10 : 15),
                              Text(
                                name!,
                                style:
                                    AppTextStyles().normal.copyWith(fontSize: constraints.maxWidth < 600 ? 12 : null),
                              ),
                            ],
                          ),
                          Gap(constraints.maxWidth < 600 ? 10 : 15),
                          Row(
                            children: [
                              Text('REGNO:',
                                  style: AppTextStyles()
                                      .headers
                                      .copyWith(fontSize: constraints.maxWidth < 600 ? 10 : 16, color: darkColor)),
                              const Gap(5),
                              Text(
                                regno!,
                                style:
                                    AppTextStyles().normal.copyWith(fontSize: constraints.maxWidth < 600 ? 12 : null),
                              ),
                            ],
                          ),
                          Gap(constraints.maxWidth < 600 ? 10 : 15),
                          Row(
                            children: [
                              Text('PROGRAMME:',
                                  style: AppTextStyles()
                                      .headers
                                      .copyWith(fontSize: constraints.maxWidth < 600 ? 10 : 16, color: darkColor)),
                              const Gap(5),
                              Wrap(children: [
                                Container(
                                  child: Text(
                                    programe!,
                                    softWrap: true,
                                    style: AppTextStyles()
                                        .normal
                                        .copyWith(fontSize: constraints.maxWidth < 600 ? 12 : null),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          const Gap(30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              'assets/images/9185570.png',
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * 0.02,
                              width: MediaQuery.of(context).size.height * 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/kigali_bg.png',
                              height: constraints.maxWidth < 600
                                  ? MediaQuery.of(context).size.height * 0.2
                                  : MediaQuery.of(context).size.height * 0.25,
                              width: constraints.maxWidth < 600
                                  ? MediaQuery.of(context).size.height * 0.25
                                  : MediaQuery.of(context).size.height * 0.3,
                            ),
                            const Gap(4),
                          ],
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
