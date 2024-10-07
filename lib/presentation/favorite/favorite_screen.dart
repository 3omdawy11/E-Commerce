import 'package:ecommerce/utilis/colors.dart';
import 'package:ecommerce/utilis/fonts.dart';
import 'package:ecommerce/utilis/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key, required this.screenSize, required this.textScaleFactor});
  final Size screenSize;
  final TextScaler textScaleFactor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          screenSize: screenSize,
          appBarHeading: const Text(
            'Favorite',
            style: Fonts.h2,
          ),
          rightIcon: SvgPicture.asset(
            'assets/svgs/heart.svg',
            height: screenSize.height * 0.03,
            color: CustomColors.black,
          ),
        ),
        SizedBox(
          height: screenSize.height * 0.04,
        ),
        SizedBox(
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.72,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0, // Spacing between rows
              childAspectRatio:
              0.75, // Aspect ratio of each item (width/height)
            ),
            itemCount: 3, // Number of items in the grid
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
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
                            child: SvgPicture.asset(
                                'assets/svgs/new_arrival_shoe.svg'),
                          ),
                        ),
                        Text(
                          'BEST SELLER',
                          style: Fonts.paragraph
                              .copyWith(color: CustomColors.blue, fontSize: 12),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.002,
                        ),
                        Text(
                          'Nike Jordan',
                          style: Fonts.paragraph.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.009,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$ 302.00',
                              style: Fonts.paragraph.copyWith(fontSize: 14),
                            ),
                            SizedBox(
                              height: 15,
                              width: screenSize.width * 0.2,
                              child: ListView.builder(
                                reverse: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 2,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 1.5),
                                    width: 10,
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
