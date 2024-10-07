import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utilis/app_router.dart';
import '../../../utilis/colors.dart';
import '../../../utilis/fonts.dart';
import '../../../utilis/on_board_constants.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    super.key,
    required this.currentIndex,
    required this.pageController,
  });

  final int currentIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.02, // 2% of screen height
        horizontal: screenSize.width * 0.05, // 5% of screen width
      ),
      child: GestureDetector(
        onTap: () {
          if (currentIndex == 2) {
            GoRouter.of(context).go(AppRouter.kLoginScreen);
          } else {
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          }
        },
        child: Container(
          width: double.infinity,
          height: screenSize.height * 0.08, // 8% of screen height
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              onBoardButtonText[currentIndex],
              style: Fonts.paragraph.copyWith(
                color: CustomColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
