import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utilis/colors.dart';
import '../../../utilis/fonts.dart';
class EmailSentPopUp extends StatelessWidget {
  const EmailSentPopUp({
    super.key,
    required this.screenSize,
    required this.textScaleFactor,
  });

  final Size screenSize;
  final TextScaler textScaleFactor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenSize.width * 0.9,
          maxHeight: screenSize.height * 0.3,
        ),
        child: AlertDialog(
          backgroundColor: CustomColors.white,
          icon: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(
                'assets/svgs/email.svg',
                height: 25,
              ),
            ),
          ),
          title: Text(
            'Check Your Email',
            style: Fonts.paragraph.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: textScaleFactor.scale(16), // Responsive font size
            ),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                'We Have Sent a Password Recovery Code to Your Email',
                textAlign: TextAlign.center,
                style: Fonts.paragraph.copyWith(
                  color: CustomColors.brown,
                  fontSize: textScaleFactor.scale(16), // Responsive font size
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}