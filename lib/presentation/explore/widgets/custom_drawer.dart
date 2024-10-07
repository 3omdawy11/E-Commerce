import 'package:ecommerce/manager/user_details/user_details_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../utilis/app_router.dart';
import '../../../utilis/colors.dart';
import '../../../utilis/constants.dart';
import '../../../utilis/fonts.dart';
import '../../screen_manager/screen_bloc/screen_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    List<Function()> actions = [
      () {
      GoRouter.of(context).pop();
      context.read<ScreenBloc>().add(ScreenIndexChanged(3));
      },
      () {
        GoRouter.of(context).pop();
      },
      () {
        GoRouter.of(context).pop();
        context.read<ScreenBloc>().add(ScreenIndexChanged(1));
      },
      () {
        GoRouter.of(context).pop();
      },
      () {
        GoRouter.of(context).pop();
        context.read<ScreenBloc>().add(ScreenIndexChanged(2));
      },
      () {
        GoRouter.of(context).pop();
      },
      () {
        GoRouter.of(context).pop();
        FirebaseAuth.instance.signOut();
        GoRouter.of(context).go(AppRouter.kLoginScreen);
      },
    ];

    return Drawer(
      backgroundColor: CustomColors.darkerWhite,
      width: screenSize.width * 0.8, // Adjusted width to 80% of the screen size
      child: Container(
        decoration: const BoxDecoration(color: Colors.blue),
        child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return Container(
                margin: EdgeInsets.symmetric(
                    vertical: screenSize.height *
                        0.05, // Reduced margin for smaller screens
                    horizontal: screenSize.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: CustomColors.white,
                      radius: screenSize.width * 0.12,
                      child: SvgPicture.asset(
                        'assets/svgs/profile.svg',
                        fit: BoxFit.cover,
                        height: screenSize.width *
                            0.2, // Adjusted to be proportional to screen width
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.username,
                      style: Fonts.h2.copyWith(
                        fontSize: screenSize.width * 0.05, // Adjusted font size
                        color: CustomColors.darkerWhite,
                      ),
                      overflow:
                          TextOverflow.ellipsis, // Added to prevent overflow
                      maxLines: 1, // Ensures single-line overflow handling
                    ),
                    SizedBox(
                      height: screenSize.height *
                          0.04, // Adjusted spacing between elements
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: drawerItems.length,
                        itemBuilder: (context, index) {
                          final item = drawerItems[index];
                          return DrawerOption(
                            screenSize: screenSize,
                            icon: SvgPicture.asset(
                              item['icon']!,
                              height: screenSize.height * 0.025,
                              color: CustomColors.darkerWhite,
                            ),
                            label: item['label']!,
                            goTo: actions[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: GestureDetector(
                  onTap: actions[6],
                  child: Text('Log out')),
            );
          },
        ),
      ),
    );
  }
}

class DrawerOption extends StatelessWidget {
  const DrawerOption({
    super.key,
    required this.screenSize,
    required this.icon,
    required this.label,
    required this.goTo,
  });

  final Size screenSize;
  final SvgPicture icon;
  final String label;
  final Function() goTo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: screenSize.height * 0.025), // Adjusted padding
      child: GestureDetector(
        onTap: goTo,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                SizedBox(
                    width: screenSize.width *
                        0.04), // Adjusted spacing between icon and text
                Text(
                  label,
                  style: Fonts.paragraph.copyWith(
                    color: CustomColors.white,
                    fontSize: screenSize.width * 0.045, // Adjusted font size
                  ),
                  overflow: TextOverflow
                      .ellipsis, // Prevent overflow in smaller screens
                  maxLines: 1, // Ensures single-line overflow handling
                ),
              ],
            ),
            Icon(
              CupertinoIcons.right_chevron,
              color: CustomColors.darkerWhite,
              size: screenSize.height * 0.025,
            ),
          ],
        ),
      ),
    );
  }
}
