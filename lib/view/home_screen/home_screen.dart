import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/constants/notifiers.dart';
import 'package:todo/view/authentication_screen/sign_in_screen.dart';
import 'package:todo/view/settings_screen/settings_screen.dart';
import 'package:todo/view/todo_screen/todo_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentSelectedPage,
        builder: ((context, value, child) => Scaffold(
              body: getHomePageBody(currentSelectedPage: value),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Todos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.money_off_csred),
                    label: 'Expenses',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
                currentIndex: currentSelectedPage.value,
                onTap: (int selectedIndex) =>
                    currentSelectedPage.value = selectedIndex,
                backgroundColor: AppColors.primaryDark,
                unselectedItemColor: Colors.white,
                unselectedLabelStyle:
                    TextStyle(color: AppColors.primaryDark, fontSize: 10.sp),
                unselectedIconTheme:
                    IconThemeData(color: Colors.white, size: 25.sp),
                selectedLabelStyle:
                    TextStyle(color: AppColors.primaryDark, fontSize: 13.sp),
                selectedItemColor: AppColors.primaryLight,
                selectedFontSize: 13.sp,
                selectedIconTheme:
                    IconThemeData(color: AppColors.primaryLight, size: 25.sp),
              ),
            )));
  }

  Widget getHomePageBody({required int currentSelectedPage}) {
    switch (currentSelectedPage) {
      case 0:
        return const TodoHomeScreen();
      case 1:
        return const SignInScreen();
      case 2:
        return const SettingsScreen();
      default:
        return const TodoHomeScreen();
    }
  }
}
