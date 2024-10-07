import 'package:ecommerce/manager/user_details/user_details_bloc.dart';
import 'package:ecommerce/utilis/app_router.dart';
import 'package:ecommerce/utilis/colors.dart';
import 'package:ecommerce/utilis/fonts.dart';
import 'package:ecommerce/utilis/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextScaler textScaleFactor = MediaQuery.of(context).textScaler;

    return PageLayout(
      screenSize: screenSize,
      textScaleFactor: textScaleFactor,
      backButton: true,
      widgets: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WelcomingMessage(
                screenSize: screenSize,
                welcomeMessage: 'OTP Verification',
                instructionMessage:
                    'Please Check Your Email To See the Verification Code',
              ),
              SizedBox(height: screenSize.height * 0.06),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OTP Code',
                    style: Fonts.h1.copyWith(
                      fontSize: textScaleFactor.scale(25),
                      color: CustomColors.brown,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  BlocConsumer<UserDetailsBloc, UserDetailsState>(
                    listener: (context, state) {
                      if (state is OTPEnteredSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                        GoRouter.of(context).go(AppRouter.kChangePasswordScreen);
                      } else if (state is OTPEnteredFail) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return OTPTextField(
                        length: 4,
                        fieldStyle: FieldStyle.box,
                        contentPadding: const EdgeInsets.all(18),
                        fieldWidth: 70,
                        otpFieldStyle: OtpFieldStyle(
                          backgroundColor: CustomColors.darkerWhite,
                          borderColor: CustomColors.darkerWhite,
                          focusBorderColor: CustomColors.darkerWhite,
                          disabledBorderColor: CustomColors.darkerWhite,
                          enabledBorderColor: CustomColors.darkerWhite,
                        ),
                        width: screenSize.width * 0.9,
                        style: Fonts.h2,
                        onChanged: (pin) {
                          // Handle the onChange event, if needed
                          print("Changed: $pin");
                        },
                        onCompleted: (pin) {
                          // Handle the completed event
                          print("Completed: $pin");
                          context
                              .read<UserDetailsBloc>()
                              .add(SubmittedOTP(pin));
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.045,
                  ),
                  // ActionButton(
                  //     screenSize: screenSize, message: 'Verify', action: () {}),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(color: CustomColors.brown),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
