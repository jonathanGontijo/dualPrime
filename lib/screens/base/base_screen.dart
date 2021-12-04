import 'package:dual/common/custom_drawer/custom_drawer.dart';
import 'package:dual/models/page_manager.dart';
import 'package:dual/models/user_manager.dart';
import 'package:dual/screens/admin_users/admin_users_screen.dart';
import 'package:dual/screens/bonus/bonus_screen.dart';
import 'package:dual/screens/casualties/casualties_screen.dart';
import 'package:dual/screens/home/home_screen.dart';
import 'package:dual/screens/information/information_screen.dart';
import 'package:dual/screens/login/login_screen.dart';
import 'package:dual/screens/services/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              BonusScreen(),
              ClasualtiesScreen(),
              ServicesScreen(),
              InformationScreen(),
              if (userManager.adminEnable)
                ...[
                  AdminUsersScreen(),
                  Scaffold(
                    drawer: CustomDrawer(),
                    appBar: AppBar(
                      title: Text('Serviços'),
                    ),
                  ),
                ]

            ],
          );
        },
      ),
    );
  }
}
