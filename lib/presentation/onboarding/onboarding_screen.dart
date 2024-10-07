import 'package:ecommerce/presentation/login/login_screen.dart';
import 'package:ecommerce/presentation/onboarding/widgets/navigation_button.dart';
import 'package:ecommerce/utilis/colors.dart';
import 'package:ecommerce/utilis/fonts.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utilis/on_board_constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../utilis/app_router.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0; // Start at the first index (0-based)
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue.shade500,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 3,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.1, // 10% of screen width
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          onBoardGreetings[index],
                          style: Fonts.h1.copyWith(color: CustomColors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      Image(
                          image: AssetImage('assets/images/onboard_screen${currentIndex + 1}.png'),
                          height: screenSize.height * 0.4,
                        ),
                      SizedBox(height: screenSize.height * 0.02),
                      Flexible(
                        child: Text(
                          onBoardDescription[index],
                          style: Fonts.paragraph.copyWith(
                            color: CustomColors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (currentIndex != 0)
                        SizedBox(height: screenSize.height * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                              (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: buildDot(index, context),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          NavigationButton(
            currentIndex: currentIndex,
            pageController: _pageController,
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 5,
      width: currentIndex == index ? 40 : 25,
      decoration: BoxDecoration(
        color: currentIndex == index
            ? CustomColors.white
            : Colors.orange.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
