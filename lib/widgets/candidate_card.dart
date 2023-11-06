import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CandidateCard extends StatelessWidget {
  const CandidateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lightColor, Colors.white, Colors.white, Colors.white],
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
                height: 100, width: 100, child: Image.asset('images/vote.png')),
          ),
          const Gap(15),
          Text(
            'Jan Royal',
            style: AppTextStyles()
                .headers
                .copyWith(color: darkColor, fontSize: 18),
          ),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(darkColor)),
                  onPressed: () {},
                  child: Text(
                    'Vote',
                    style: AppTextStyles().normal.copyWith(color: lightColor),
                  )),
              OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        BorderSide(color: primaryColor))),
                child: Text(
                  'View more',
                  style: AppTextStyles().normal.copyWith(color: primaryColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
