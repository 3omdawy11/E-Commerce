import 'package:ecommerce/utilis/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utilis/colors.dart';

class PopularShoeContainer extends StatelessWidget {
  const PopularShoeContainer({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(CupertinoIcons.heart),
                  Container(
                    height: screenSize.height * 0.12,
                    width: screenSize.width * 0.38,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SvgPicture.asset('assets/svgs/new_arrival_shoe.svg'),
                    ),
                  ),
                  Text(
                    'BEST SELLER',
                    style: Fonts.paragraph
                        .copyWith(color: CustomColors.blue, fontSize: screenSize.height * 0.015),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.002,
                  ),
                  Text(
                    'Nike Jordan',
                    style: Fonts.paragraph.copyWith(
                      fontSize: screenSize.height * 0.02,
                    ),
                  ),
                  Text(
                    '\$ 302.00',
                    style: Fonts.paragraph.copyWith(fontSize: screenSize.height * 0.015),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                    color: CustomColors.blue, // Adjust color as needed
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      CupertinoIcons.plus,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
