import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:anti_rigging/utils/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AdminDashBoardPage extends StatefulWidget {
  const AdminDashBoardPage({super.key});

  @override
  State<AdminDashBoardPage> createState() => _AdminDashBoardPageState();
}

class _AdminDashBoardPageState extends State<AdminDashBoardPage>
    with TickerProviderStateMixin {
  final List<String> pages = ['Page 1', 'Page 2', 'Page 3', 'Page 4'];
  final PageController _pageController = PageController(initialPage: 0);

  void nextPage() {
    if (_pageController.page! < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void previousPage() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, Admin!',
            style: AppTextStyles().headers.copyWith(color: darkColor),
          ),
          const Gap(10),
          Expanded(
            child: Container(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  DashBoardCard(
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            'Results',
                            style: AppTextStyles()
                                .normal
                                .copyWith(color: darkColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: previousPage,
                                  icon: Icon(Icons.arrow_back_ios)),
                              IconButton(
                                  onPressed: nextPage,
                                  icon: Icon(Icons.arrow_forward_ios)),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: pages.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    color: Colors.blue,
                                    child: Center(
                                      child: Text(
                                        pages[index],
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DashBoardCard(SfCalendar(
                    view: CalendarView.week,
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
