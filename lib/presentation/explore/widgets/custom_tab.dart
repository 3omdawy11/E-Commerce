import 'package:flutter/material.dart';
class CustomTab extends StatelessWidget {
  final String tabText;
  final Size screenSize;

  const CustomTab({super.key, required this.screenSize, required this.tabText});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        width: screenSize.width * 0.3, // Adjusted width to make tabs closer
        height: screenSize.height * 0.05, // Adjusted height slightly
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), // Reduced border radius
        ),
        child: Text(
          tabText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}