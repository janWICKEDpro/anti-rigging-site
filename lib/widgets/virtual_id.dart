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
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.4,
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
              style: AppTextStyles().headers.copyWith(color: primaryColor),
            ),
            const Padding(
              padding: EdgeInsets.all(5),
              child: Divider(),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('NAME:', style: AppTextStyles().headers.copyWith(fontSize: 16, color: darkColor)),
                            const Gap(5),
                            Text(
                              name!,
                              style: AppTextStyles().normal.copyWith(),
                            ),
                          ],
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            Text('REGNO:', style: AppTextStyles().headers.copyWith(fontSize: 16, color: darkColor)),
                            const Gap(5),
                            Text(
                              regno!,
                              style: AppTextStyles().normal.copyWith(),
                            ),
                          ],
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            Text('PROGRAMME:', style: AppTextStyles().headers.copyWith(fontSize: 16, color: darkColor)),
                            const Gap(5),
                            Text(
                              programe!,
                              style: AppTextStyles().normal.copyWith(),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/9185570.png',
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/kigali_bg.png',
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.height * 0.3,
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
}
