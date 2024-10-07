import 'package:ecommerce/presentation/register/manager/register_account/register_account_bloc.dart';
import 'package:ecommerce/utilis/app_router.dart';
import 'package:ecommerce/utilis/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../utilis/shared_widgets.dart';
import '../forget_password/widgets/email_sent_pop_up_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late RegisterAccountBloc registerAccountBloc;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    registerAccountBloc = RegisterAccountBloc(); // Initialize the Bloc
  }

  @override
  void dispose() {
    // Dispose of the text controllers
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    // Dispose the Bloc
    registerAccountBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextScaler textScaleFactor = MediaQuery.of(context).textScaler;

    return PageLayout(
      backButton: false,
      screenSize: screenSize,
      textScaleFactor: textScaleFactor,
      widgets: [
        Expanded(
          child: Column(
            children: [
              WelcomingMessage(
                screenSize: screenSize,
                welcomeMessage: 'Register Account',
                instructionMessage:
                    'Fill Your Details Or Continue With Social Media',
              ),
              SizedBox(height: screenSize.height * 0.03),
              CustomTextField(
                textEditingController: usernameController,
                fieldLabel: 'Your Name',
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * 0.02),
              CustomTextField(
                fieldLabel: 'Email Address',
                textEditingController: emailController,
                fieldHint: 'xyz@gmail.com',
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * 0.02),
              ObscureCustomTextField(
                textEditingController: passwordController,
                fieldLabel: 'Password',
                fieldHint: '********',
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * 0.04),

              // Wrap the BlocProvider around the ActionButton only
              BlocProvider<RegisterAccountBloc>(
                create: (context) =>
                    registerAccountBloc, // Provide the created Bloc
                child: BlocListener<RegisterAccountBloc, RegisterAccountState>(
                  listener: (context, state) {
                    if (state is RegisterAccountSuccess) {
                      GoRouter.of(context).go(AppRouter.kScreenManger);
                    } else if (state is RegisterAccountFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.error),
                      ));
                    } else if (state is RegisterAccountVerifying) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EmailSentPopUp(
                            screenSize: screenSize,
                            textScaleFactor: textScaleFactor,
                          );
                        },
                      );
                    }
                  },
                  child: BlocBuilder<RegisterAccountBloc, RegisterAccountState>(
                    builder: (context, state) {
                      return ActionButton(
                        screenSize: screenSize,
                        message: state is RegisterAccountSubmitting
                            ? 'Loading...'
                            : 'Sign Up',
                        color: state is RegisterAccountSubmitting
                            ? Colors.grey
                            : CustomColors.blue,
                        action: state is RegisterAccountSubmitting
                            ? () {}
                            : () async {
                                context.read<RegisterAccountBloc>().add(
                                      RegisterAccountSubmitted(
                                          username: usernameController.text,
                                          email: emailController.text,
                                          password: passwordController.text),
                                    );
                              },
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: screenSize.height * 0.015),
              BottomAlternative(
                question: 'Already Have an Account?',
                message: 'Log In',
                action: () {
                  GoRouter.of(context).go(AppRouter.kLoginScreen);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
