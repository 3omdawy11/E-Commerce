import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilis/shared_widgets.dart';
import '../manager/google_login/google_login_bloc.dart';

class GetUsernameScreen extends StatelessWidget {
  GetUsernameScreen({
    super.key,
  });

  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextScaler textScaleFactor = MediaQuery.of(context).textScaler;
    return PageLayout(
      screenSize: screenSize,
      textScaleFactor: textScaleFactor,
      backButton: false,
      widgets: [
        WelcomingMessage(
          screenSize: screenSize,
          welcomeMessage: 'Add Username',
          instructionMessage:
              'Enter your account username for more app features',
        ),
        CustomTextField(
          fieldLabel: 'Username',
          fieldHint: 'username',
          screenSize: screenSize,
          textEditingController: usernameController,
        ),
        BlocProvider(
          create: (context) => GoogleLoginBloc(),
          child: BlocBuilder<GoogleLoginBloc, GoogleLoginState>(
            builder: (context, state) {
              return ActionButton(
                screenSize: screenSize,
                message: 'Submit',
                color: state is GoogleLoginSubmitting ? Colors.redAccent : Colors.blue,
                action: state is GoogleLoginSubmitting
                    ? () {}
                    : () {
                      print("Clicking");
                      print(usernameController.text);
                        context.read<GoogleLoginBloc>().add(
                              GoogleLoginUsernameSubmitted(
                                username: usernameController.text,
                              ),
                            );
                        Navigator.pop(context);
                      },
              );
            },
          ),
        ),
      ],
    );
  }
}
