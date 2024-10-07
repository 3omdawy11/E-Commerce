import 'package:ecommerce/manager/user_details/user_details_bloc.dart';
import 'package:ecommerce/utilis/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../utilis/app_router.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextScaler textScaleFactor = MediaQuery.of(context).textScaler;
    TextEditingController changePasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return PageLayout(
      screenSize: screenSize,
      backButton: true,
      widgets: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenSize.height * 0.05),
            WelcomingMessage(
              screenSize: screenSize,
              welcomeMessage: 'Change Your Password',
              instructionMessage: 'Enter New Password',
            ),
            SizedBox(height: screenSize.height * 0.04),
            CustomTextField(
              textEditingController: changePasswordController,
              fieldLabel: 'Password',
              fieldHint: changePasswordController.text == ''
                  ? '******'
                  : changePasswordController.text,
              screenSize: screenSize,
            ),
            SizedBox(height: screenSize.height * 0.04),
            CustomTextField(
              textEditingController: confirmPasswordController,
              fieldLabel: 'Confirm Password',
              fieldHint: confirmPasswordController.text == ''
                  ? '******'
                  : confirmPasswordController.text,
              screenSize: screenSize,
            ),
            SizedBox(
              height: screenSize.height * 0.04,
            ),
            BlocConsumer<UserDetailsBloc, UserDetailsState>(
              listener: (context, state) {
                if (state is ChangePasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                  GoRouter.of(context).go(AppRouter.kLoginScreen);
                } else if (state is ChangePasswordFail) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return ActionButton(
                    screenSize: screenSize,
                    message: state is Loading ? 'Loading...' : 'Submit',
                    action: () => context.read<UserDetailsBloc>().add(
                        SubmittedNewPassword(changePasswordController.text,
                            confirmPasswordController.text)));
              },
            ),
          ],
        ),
      ],
      textScaleFactor: textScaleFactor,
    );
  }
}
