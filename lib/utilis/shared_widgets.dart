import 'package:ecommerce/presentation/register/manager/register_account/register_account_bloc.dart';
import 'package:ecommerce/presentation/register/register_screen.dart';
import 'package:ecommerce/utilis/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../presentation/explore/widgets/custom_drawer.dart';
import '../presentation/explore/widgets/custom_navigation_bar.dart';
import '../presentation/explore/widgets/custom_tab.dart';
import '../presentation/explore/widgets/popular_shoes_container.dart';
import 'colors.dart';
import 'fonts.dart';

class PageLayout extends StatelessWidget {
  const PageLayout(
      {super.key,
      required this.screenSize,
      this.textScaleFactor,
      required this.widgets,
      required this.backButton});

  final Size screenSize;
  final TextScaler? textScaleFactor;
  final List<Widget> widgets;
  final bool backButton;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.white,
          leading: backButton ? goBackButton(context) : null,
        ),
        backgroundColor: CustomColors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            child: Container(
              height: screenSize.height * 0.9,
              margin: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.width * 0.1),
              child: Column(
                children: widgets,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String fieldLabel;
  final String? fieldHint;
  final Size screenSize;
  final Function(String)? onChanged;
  final Color? fieldColor;
  final Color? hintColor;
  final Color? labelColor;
  final bool? enabled;
  final TextEditingController? textEditingController;

  const CustomTextField({
    super.key,
    required this.fieldLabel,
    this.fieldHint,
    required this.screenSize,
    this.onChanged,
    this.fieldColor,
    this.hintColor,
    this.labelColor,
    this.enabled,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldLabel,
          style:
              Fonts.paragraph.copyWith(color: labelColor ?? CustomColors.black),
        ),
        SizedBox(height: screenSize.height * 0.015),
        TextField(
          controller: textEditingController, // Use the passed controller
          enabled: enabled,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: fieldHint, // Set hint text directly
            hintStyle: Fonts.paragraph.copyWith(
              color: hintColor ?? CustomColors.brown,
              fontSize: screenSize.height * 0.018,
            ),
            filled: true,
            fillColor: fieldColor ?? CustomColors.darkerWhite,
            contentPadding: EdgeInsets.symmetric(
              vertical: screenSize.height * 0.02,
              horizontal: screenSize.width * 0.05,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenSize.width * 0.05),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class ObscureCustomTextField extends StatelessWidget {
  final String fieldLabel;
  final String fieldHint;
  final TextEditingController? textEditingController;
  final Size screenSize;

  const ObscureCustomTextField({
    super.key,
    required this.fieldLabel,
    required this.fieldHint,
    required this.screenSize,
    this.textEditingController, // Pass the notifier from the parent widget
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> obscureTextNotifier = ValueNotifier<bool>(true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldLabel, style: Fonts.paragraph),
        SizedBox(height: screenSize.height * 0.015),
        ValueListenableBuilder<bool>(
          valueListenable: obscureTextNotifier, // Listen to the ValueNotifier
          builder: (context, isObscured, child) {
            return TextField(
              controller: textEditingController,
              obscureText: isObscured, // Use the value from the notifier
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    // Toggle the eye icon state
                    obscureTextNotifier.value = !obscureTextNotifier.value;
                  },
                  child: Icon(
                    isObscured ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                    size: screenSize.height * 0.025,
                  ),
                ),
                filled: true,
                fillColor: CustomColors.darkerWhite,
                contentPadding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.02,
                  horizontal: screenSize.width * 0.05,
                ),
                hintText: fieldHint,
                hintStyle: Fonts.paragraph.copyWith(
                  color: CustomColors.brown,
                  fontSize: screenSize.height * 0.018,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenSize.width * 0.05),
                  borderSide: BorderSide.none,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class WelcomingMessage extends StatelessWidget {
  const WelcomingMessage({
    super.key,
    required this.screenSize,
    required this.welcomeMessage,
    required this.instructionMessage,
  });
  final String welcomeMessage;
  final String instructionMessage;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            welcomeMessage,
            style: Fonts.h1.copyWith(
                fontSize:
                    screenSize.height * 0.04), // Adjust font size dynamically
          ),
          SizedBox(
              height: screenSize.height * 0.02), // Adjust spacing dynamically
          Text(
            instructionMessage,
            style: Fonts.paragraph.copyWith(
              color: CustomColors.grey,
              fontSize:
                  screenSize.height * 0.02, // Adjust font size dynamically
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class BottomAlternative extends StatelessWidget {
  const BottomAlternative({
    super.key,
    required this.question,
    required this.message,
    required this.action,
  });
  final String question;
  final String message;
  final Function() action;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$question? ',
          style: Fonts.paragraph.copyWith(color: CustomColors.brown),
        ),
        GestureDetector(
          onTap: action,
          child: Text(
            message,
            style: Fonts.paragraph,
          ),
        )
      ],
    );
  }
}

class RecoveryPassword extends StatelessWidget {
  const RecoveryPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).push(AppRouter.kForgetPasswordScreen);
        },
        child: Text(
          'Recovery Password',
          style:
              Fonts.paragraph.copyWith(fontSize: 12, color: CustomColors.brown),
        ),
      ),
    );
  }
}

class SignWithGoogle extends StatelessWidget {
  const SignWithGoogle({
    super.key,
    required this.screenSize,
    required this.message,
    required this.newUser,
    required this.action,
  });

  final Size screenSize;
  final String message;
  final bool newUser;
  final Function() action;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        height: screenSize.height * 0.07, // Adjust button height dynamically
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomColors.darkerWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svgs/google_icon.svg'),
            SizedBox(
              width: screenSize.width * 0.03,
            ),
            Text(
              '$message With Google',
              style: Fonts.paragraph,
            )
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.screenSize,
    required this.message,
    required this.action,
    this.color,
  });

  final Size screenSize;
  final String message;
  final Function() action;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        height: screenSize.height * 0.07, // Adjust button height dynamically
        width: double.infinity,
        decoration: BoxDecoration(
          color: color ?? CustomColors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            message,
            style: Fonts.paragraph.copyWith(
              color: CustomColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

Widget goBackButton(BuildContext context) {
  return GestureDetector(
    onTap: GoRouter.of(context).pop,
    child: const Icon(
      CupertinoIcons.back,
      color: Colors.black,
    ),
  );
}

class ScreenManagerLayout extends StatelessWidget {
  const ScreenManagerLayout(
      {super.key,
      required this.screenSize,
      required this.textScaleFactor,
      required this.widgets,
      this.backgroundColor});
  final Size screenSize;
  final TextScaler textScaleFactor;
  final List<Widget> widgets;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: CustomColors.blue,
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kShoppingCartScreen);
            },
            shape: const CircleBorder(),
            child: SvgPicture.asset(
              'assets/svgs/shopping_bag.svg',
              color: CustomColors.white,
            ),
          ),
          bottomNavigationBar: const CustomNavigationBar(),
          drawer: CustomDrawer(screenSize: screenSize),
          backgroundColor: backgroundColor ?? CustomColors.darkerWhite,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.05,
                left: screenSize.width * 0.05,
                right: screenSize.width * 0.05,
              ),
              child: Column(
                children: widgets,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IconCircularAvatar extends StatelessWidget {
  const IconCircularAvatar({
    super.key,
    required this.screenSize,
    required this.icon,
    required this.action,
  });

  final Size screenSize;
  final Widget icon;
  final Function() action;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: CircleAvatar(
        backgroundColor: CustomColors.white,
        radius: screenSize.height * 0.025,
        child: icon,
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.screenSize,
    this.leftIcon,
    required this.appBarHeading,
    this.rightIcon,
    this.leftIconAction,
    this.rightIconAction,
  });

  final Size screenSize;
  final Widget? leftIcon;
  final Function()? leftIconAction;
  final Text appBarHeading;
  final Widget? rightIcon;
  final Function()? rightIconAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconCircularAvatar(
          screenSize: screenSize,
          icon: leftIcon ?? Container(),
          action: leftIconAction ?? () {},
        ),
        appBarHeading,
        IconCircularAvatar(
            screenSize: screenSize,
            icon: rightIcon ?? Container(),
            action: rightIconAction ?? () {}),
      ],
    );
  }
}
