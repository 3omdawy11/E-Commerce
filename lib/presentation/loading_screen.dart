import 'package:ecommerce/utilis/app_router.dart';
import 'package:ecommerce/utilis/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 3));

    // Check for authentication state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      // Ensure the widget is still mounted before accessing context
      if (!mounted) return;

      if (user == null) {
        GoRouter.of(context).go(AppRouter.kOnBoardingScreen);
      } else {
        GoRouter.of(context).go(AppRouter.kScreenManger);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svgs/Nike_Logo.svg',
            ),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset(
              'assets/svgs/Nike.svg',
            ),
          ],
        ),
      ),
    );
  }
}
