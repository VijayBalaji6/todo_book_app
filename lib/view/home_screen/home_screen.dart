import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/constants/notifiers.dart';
import 'package:todo/model/user.dart';
import 'package:todo/view/home_screen/account_screen/account_screen.dart';
import 'package:todo/view/home_screen/dashboard_screen/dasrhboard_sceen.dart';
import 'package:todo/view/home_screen/expense_screen/expernse_screen.dart';
import 'package:todo/view/home_screen/todo_screen/todo_home_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentSelectedPage,
        builder: ((context, value, child) => Scaffold(
              body: getHomePageBody(currentSelectedPage: value),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month),
                    label: 'Todos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.monetization_on),
                    label: 'Expenses',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Account',
                  ),
                ],
                currentIndex: currentSelectedPage.value,
                onTap: (int selectedIndex) =>
                    currentSelectedPage.value = selectedIndex,
                backgroundColor: AppColors.primaryDark,
                unselectedItemColor: Colors.white,
                unselectedLabelStyle:
                    TextStyle(color: AppColors.primaryDark, fontSize: 8.sp),
                selectedLabelStyle:
                    TextStyle(color: AppColors.primaryDark, fontSize: 13.sp),
                unselectedIconTheme:
                    IconThemeData(color: Colors.white, size: 25.sp),
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
        return const DashboardScreen();
      case 1:
        return TodoHomeScreen(
          userData: user,
        );
      case 2:
        return const ExpenseScreen();
      case 3:
        return const AccountScreen();
      default:
        return const DashboardScreen();
    }
  }
}
