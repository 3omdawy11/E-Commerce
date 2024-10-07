import 'package:flutter/material.dart';

import '../../utilis/shared_widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key, required this.screenSize, required this.textScaleFactor});
  final Size screenSize;
  final TextScaler textScaleFactor;
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: Text('Notification Screen'),
        ),
      ],
    );
  }
}
