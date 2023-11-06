import 'package:anti_rigging/utils/colors.dart';
import 'package:anti_rigging/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

class AdminDashboad extends StatelessWidget {
  const AdminDashboad({super.key});
  factory AdminDashboad.routeBuilder(_, __) {
    return const AdminDashboad(
      key: Key('admin dashboard'),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 150,
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {},
          child: Text(
            'Create Election',
            style: AppTextStyles().normal.copyWith(color: Colors.white),
          ),
        ),
      ),
      body: Row(
        children: [
          SideNavigationBar(
            theme: SideNavigationBarTheme(
                itemTheme: SideNavigationBarItemTheme(
                  unselectedItemColor: primaryColor,
                  selectedItemColor: Colors.white,
                  selectedBackgroundColor: darkColor,
                  labelTextStyle: AppTextStyles()
                      .normal
                      .copyWith(color: Colors.black, fontSize: 20),
                ),
                togglerTheme: SideNavigationBarTogglerTheme(),
                dividerTheme: const SideNavigationBarDividerTheme(
                    showHeaderDivider: true,
                    showMainDivider: true,
                    showFooterDivider: true),
                backgroundColor: lightColor),
            selectedIndex: 0,
            items: const [
              SideNavigationBarItem(
                icon: Icons.dashboard,
                label: 'Dashboard',
              ),
              SideNavigationBarItem(
                icon: Icons.person,
                label: 'Elections',
              ),
              SideNavigationBarItem(
                icon: Icons.logout,
                label: 'Logout',
              ),
            ],
            onTap: (index) {},
          ),
          Expanded(
            child: Column(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
