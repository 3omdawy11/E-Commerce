import 'package:ecommerce/manager/user_details/user_details_bloc.dart';
import 'package:ecommerce/presentation/forget_password/widgets/email_sent_pop_up_widget.dart';
import 'package:ecommerce/utilis/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../utilis/app_router.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextScaler textScaleFactor = MediaQuery.of(context).textScaler;
    TextEditingController emailController = TextEditingController();
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
              welcomeMessage: 'Forget Password',
              instructionMessage:
                  'Enter Your Email Account To Reset Your Password',
            ),
            SizedBox(height: screenSize.height * 0.04),
            CustomTextField(
              textEditingController: emailController,
              fieldLabel: 'Email Address',
              fieldHint: emailController.text == ''
                  ? 'xyz@gmail.com'
                  : emailController.text,
              screenSize: screenSize,
            ),
            SizedBox(height: screenSize.height * 0.04),
            BlocConsumer<UserDetailsBloc, UserDetailsState>(
              listener: (context, state) {
                if (state is EmailSentSuccess) {
                  // Navigate to OTP Verification Screen when email is successfully sent
                  GoRouter.of(context).push(AppRouter.kOTPVerificationScreen);
                } else if (state is EmailSentFail) {
                  // Optionally show a Snackbar or any other UI feedback
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ReceivingEmail) {
                  return Column(
                    children: [
                      ActionButton(
                        screenSize: screenSize,
                        message: 'Sending...',
                        action: () {}, // Disable action while sending email
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      ActionButton(
                        screenSize: screenSize,
                        message: 'Reset Password',
                        action: () {
                          context
                              .read<UserDetailsBloc>()
                              .add(RecoverPassword(emailController.text));
                        },
                      ),
                      if (state is EmailSentFail)
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          child: const Text(
                            'User not found. Please check your email.',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
