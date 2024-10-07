import 'package:ecommerce/manager/user_details/user_details_bloc.dart';
import 'package:ecommerce/presentation/profile/edit_profile_screen.dart';
import 'package:ecommerce/utilis/app_router.dart';
import 'package:ecommerce/utilis/fonts.dart';
import 'package:ecommerce/utilis/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../utilis/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen(
      {super.key, required this.screenSize, required this.textScaleFactor});
  final Size screenSize;
  final TextScaler textScaleFactor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<UserDetailsBloc, UserDetailsState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return Column(
                children: [
                  CustomAppBar(
                    screenSize: screenSize,
                    appBarHeading: const Text(
                      'Profile',
                      style: Fonts.h2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Stack(
                      children: [
                        ProfilePicture(
                          screenSize: screenSize,
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: CircleAvatar(
                            radius: screenSize.width *
                                0.03, // Size of the edit button
                            backgroundColor: CustomColors.blue,
                            child: GestureDetector(
                              onTap: () => GoRouter.of(context).push(
                                  AppRouter.kEditProfileScreen,
                                  extra: context.read<UserDetailsBloc>()),
                              child: Icon(
                                Icons.edit,
                                size: screenSize.width *
                                    0.04, // Adjust the size of the edit icon
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextField(
                    fieldLabel: 'Your Name',
                    fieldHint: state.username,
                    screenSize: screenSize,
                    fieldColor: CustomColors.darkerWhite,
                    hintColor: CustomColors.black,
                    labelColor: CustomColors.brown,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    fieldLabel: 'Email Address',
                    fieldHint: state.email,
                    screenSize: screenSize,
                    fieldColor: CustomColors.darkerWhite,
                    hintColor: CustomColors.black,
                    labelColor: CustomColors.brown,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    fieldLabel: 'Password',
                    fieldHint: '********',
                    screenSize: screenSize,
                    fieldColor: CustomColors.darkerWhite,
                    hintColor: CustomColors.black,
                    labelColor: CustomColors.brown,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const RecoveryPassword(),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              );
            }
            return Container();
          },
        )
      ],
    );
  }
}
