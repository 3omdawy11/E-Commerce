import 'package:ecommerce/presentation/forget_password/change_password_screen.dart';
import 'package:ecommerce/presentation/forget_password/forget_password_screen.dart';
import 'package:ecommerce/presentation/loading_screen.dart';
import 'package:ecommerce/presentation/login/login_screen.dart';
import 'package:ecommerce/presentation/login/widgets/get_username_screen.dart';
import 'package:ecommerce/presentation/onboarding/onboarding_screen.dart';
import 'package:ecommerce/presentation/forget_password/otp_verification_screen.dart';
import 'package:ecommerce/presentation/profile/edit_profile_screen.dart';
import 'package:ecommerce/presentation/register/register_screen.dart';
import 'package:ecommerce/presentation/screen_manager/screen_manager.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kLoadingScreen = '/';
  static const kOnBoardingScreen = '/OnBoardingScreen';
  static const kLoginScreen = '/LoginScreen';
  static const kRegisterScreen = '/RegisterScreen';
  static const kForgetPasswordScreen = '/ForgetPasswordScreen';
  static const kOTPVerificationScreen = '/OTPVerificationScreen';
  static const kExploreScreen = '/ExploreScreen';
  static const kScreenManger = '/ScreenManger';
  static const kProfileScreen = '/ProfileScreen';
  static const kEditProfileScreen = '/EditProfileScreen';
  static const kChangePasswordScreen = '/ChangePasswordScreen';
  static const kGetUsernameScreen = '/GetUsernameScreen';


  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: kLoadingScreen,
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: kOnBoardingScreen,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: kLoginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kRegisterScreen,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: kForgetPasswordScreen,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: kOTPVerificationScreen,
        builder: (context, state) => const OTPVerificationScreen(),
      ),
      GoRoute(
        path: kScreenManger,
        builder: (context, state) => const ScreenManager(),
      ),
      GoRoute(
        path: AppRouter.kEditProfileScreen,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRouter.kChangePasswordScreen,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: kGetUsernameScreen,
        builder: (context, state) => GetUsernameScreen(),
      ),
    ],
  );
}
