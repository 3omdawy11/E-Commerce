import 'package:ecommerce/presentation/login/manager/google_login/google_login_bloc.dart';
import 'package:ecommerce/presentation/login/manager/login_account/login_account_bloc.dart';
import 'package:ecommerce/presentation/login/widgets/get_username_screen.dart';
import 'package:ecommerce/utilis/colors.dart';
import 'package:ecommerce/utilis/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../utilis/app_router.dart';
import '../../utilis/shared_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers
    emailController.dispose();
    passwordController.dispose();
    print("Done disposing the Login Screen");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextScaler textScaleFactor = MediaQuery.of(context).textScaler;

    return PageLayout(
      screenSize: screenSize,
      textScaleFactor: textScaleFactor,
      backButton: false,
      widgets: [
        Expanded(
          child: Column(
            children: [
              WelcomingMessage(
                screenSize: screenSize,
                welcomeMessage: 'Hello Again!',
                instructionMessage:
                    'Fill Your Details Or Continue With Social Media',
              ),
              SizedBox(height: screenSize.height * 0.05),
              CustomTextField(
                fieldLabel: 'Email Address',
                textEditingController: emailController,
                fieldHint: 'xyz@gmail.com',
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * 0.04),
              ObscureCustomTextField(
                fieldLabel: 'Password',
                fieldHint: '********',
                textEditingController: passwordController,
                screenSize: screenSize,
              ),
              SizedBox(height: screenSize.height * 0.02),
              const RecoveryPassword(),

              // Wrap the buttons with MultiBlocProvider
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => LoginAccountBloc(),
                  ),
                  BlocProvider(
                    create: (context) => GoogleLoginBloc(),
                  ),
                ],
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<LoginAccountBloc, LoginAccountState>(
                      listener: (context, state) {
                        if (state is LoginAccountSuccessful) {
                          GoRouter.of(context).go(AppRouter.kScreenManger);
                        }
                      },
                    ),
                    BlocListener<GoogleLoginBloc, GoogleLoginState>(
                      listener: (context, state) {
                        if (state is GoogleLoginSuccessful) {
                          GoRouter.of(context).go(AppRouter.kScreenManger);
                        } else if (state is GoogleLoginGetUsername) {

                          print('State now is trying to get Google Username');

                          GoRouter.of(context).push(AppRouter.kGetUsernameScreen);
                        }
                      },
                    ),
                  ],
                  child: Column(
                    children: [
                      // BlocBuilder for LoginAccountBloc (Normal sign-in)
                      BlocBuilder<LoginAccountBloc, LoginAccountState>(
                        builder: (context, loginState) {
                          return Builder(builder: (context) {
                            return Column(
                              children: [
                                if (loginState is LoginAccountFailure)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      loginState.error,
                                      style: Fonts.paragraph.copyWith(
                                        color: CustomColors.blue,
                                      ),
                                    ),
                                  ),
                                SizedBox(height: screenSize.height * 0.035),
                                ActionButton(
                                  screenSize: screenSize,
                                  message: 'Sign in',
                                  action: (loginState is LoginAccountSubmitting)
                                      ? () {}
                                      : () {
                                          context.read<LoginAccountBloc>().add(
                                                LoginAccountSubmitted(
                                                    email: emailController.text,
                                                    password: passwordController
                                                        .text),
                                              );
                                        },
                                ),
                                if (context.watch<LoginAccountBloc>().state
                                    is LoginAccountSubmitting)
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      color: CustomColors.blue,
                                    ),
                                  ),
                              ],
                            );
                          });
                        },
                      ),

                      SizedBox(height: screenSize.height * 0.015),

                      // BlocBuilder for GoogleLoginBloc (Sign in with Google)
                      BlocBuilder<GoogleLoginBloc, GoogleLoginState>(
                        builder: (context, googleState) {
                          return Builder(builder: (context) {
                            return Column(
                              children: [
                                SignWithGoogle(
                                  action: (googleState is GoogleLoginSubmitting)
                                      ? () {}
                                      : () {
                                          context
                                              .read<GoogleLoginBloc>()
                                              .add(GoogleLoginSubmitted(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              ));
                                        },
                                  screenSize: screenSize,
                                  message: 'Sign In',
                                  newUser: false,
                                ),
                                if (googleState is GoogleLoginSubmitting)
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      color: CustomColors.blue,
                                    ),
                                  ),
                                if (googleState is GoogleLoginFailed)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      googleState.error,
                                      style: Fonts.paragraph.copyWith(
                                        color: CustomColors.pink,
                                      ),
                                    ),
                                  ),
                                SizedBox(height: screenSize.height * 0.035),
                              ],
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenSize.height * 0.015),

              BottomAlternative(
                question: 'New User',
                message: 'Create Account',
                action: () {
                  GoRouter.of(context).go(AppRouter.kRegisterScreen);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
