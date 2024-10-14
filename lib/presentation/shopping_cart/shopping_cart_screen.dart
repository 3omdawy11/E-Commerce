import 'dart:math';

import 'package:ecommerce/utilis/colors.dart';
import 'package:ecommerce/utilis/fonts.dart';
import 'package:ecommerce/utilis/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:go_router/go_router.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Map<String, dynamic>> shoes = [
    {'name': 'Shoe 1', 'count': 1},
    {'name': 'Shoe 2', 'count': 1},
    {'name': 'Shoe 3', 'count': 1},
    {'name': 'Shoe 3', 'count': 1},
    {'name': 'Shoe 3', 'count': 1},
  ];

  void _incrementCount(int index) {
    setState(() {
      shoes[index]['count']++;
    });
  }

  void _decrementCount(int index) {
    if (shoes[index]['count'] > 1) {
      setState(() {
        shoes[index]['count']--;
      });
    }
  }

  void _deleteShoe(int index) {
    setState(() {
      shoes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.darkerWhite,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: CustomAppBar(
                screenSize: screenSize,
                appBarHeading: Text(
                  'My Cart',
                  style: Fonts.h2.copyWith(fontSize: screenSize.height * 0.022),
                ),
                leftIcon: const Icon(CupertinoIcons.back),
                leftIconAction: () => GoRouter.of(context).pop(),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${shoes.length} Item${shoes.length > 1 ? 's' : ''}',
                  style: Fonts.paragraph,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: shoes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: Slidable(
                      key: ValueKey(index),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.25,
                        children: [
                          _buildVerticalActions(
                            context,
                            index,
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.25,
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.03,
                          ),
                          _buildDeleteAction(context, index, screenSize),
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: CustomColors.darkerWhite,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Image.asset(
                                'assets/images/onboard_screen2.png',
                                height: screenSize.height * 0.1,
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 0.03,
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Nike Club Max',
                                  style: Fonts.paragraph.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: const Text('\$584.95'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: screenSize.height * 0.28,
              color: CustomColors.white,
              child: Container(
                margin: const EdgeInsets.only(top: 15, left: 25, right: 25),
                child: Column(
                  children: [
                    ReceiptLine(
                      label: 'Subtotal',
                      cost: '\$753.95',
                      labelColor: CustomColors.grey,
                      screenSize: screenSize,
                    ),
                    ReceiptLine(
                      label: 'Delivery',
                      cost: '\$60.20',
                      labelColor: CustomColors.grey,
                      screenSize: screenSize,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const DottedLine(
                      lineThickness: 3,
                      dashLength: 8,
                      dashGapLength: 5,
                      dashColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ReceiptLine(
                      label: 'Subtotal',
                      cost: '\$814.15',
                      costColor: CustomColors.blue,
                      screenSize: screenSize,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ActionButton(
                        screenSize: screenSize,
                        message: 'Checkout',
                        action: () {})
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalActions(BuildContext context, int index) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          Expanded(
            child: _buildCustomAction(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              context,
              onPressed: () => _incrementCount(index),
              color: CustomColors.blue,
              icon: Icons.add,
            ),
          ),
          Container(
            color: CustomColors.blue,
            width: 70,
            child: Center(
                child: Text(
              '${shoes[index]['count']}',
              style: Fonts.h2.copyWith(
                color: CustomColors.darkerWhite,
              ),
            )),
          ),
          Expanded(
            child: _buildCustomAction(
              context,
              onPressed: () => _decrementCount(index),
              color: CustomColors.blue,
              icon: Icons.remove,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteAction(BuildContext context, int index, Size screenSize) {
    return GestureDetector(
      onTap: () => _deleteShoe(index),
      child: Container(
        height: screenSize.height * 0.125,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
    );
  }

  Widget _buildCustomAction(
    BuildContext context, {
    required VoidCallback onPressed,
    required Color color,
    IconData? icon,
    BorderRadius? borderRadius,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: double.infinity,
        width: 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class ReceiptLine extends StatelessWidget {
  const ReceiptLine({
    super.key,
    required this.label,
    required this.cost,
    this.labelColor,
    this.costColor,
    required this.screenSize,
  });
  final String label;
  final String cost;
  final Color? labelColor;
  final Color? costColor;
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Fonts.h2.copyWith(
                fontSize: screenSize.height * 0.02,
                color: labelColor ?? CustomColors.black),
          ),
          Text(
            cost,
            style: Fonts.paragraph.copyWith(fontSize: screenSize.height * 0.02),
          )
        ],
      ),
    );
  }
}
