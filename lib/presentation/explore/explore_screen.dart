import 'package:ecommerce/presentation/explore/widgets/custom_tab.dart';
import 'package:ecommerce/presentation/explore/widgets/popular_shoes_container.dart';
import 'package:ecommerce/utilis/colors.dart';
import 'package:ecommerce/utilis/fonts.dart';
import 'package:ecommerce/utilis/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen(
      {super.key, required this.screenSize, required this.textScaleFactor});
  final Size screenSize;
  final TextScaler textScaleFactor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          screenSize: screenSize,
          leftIcon: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: SvgPicture.asset('assets/svgs/side_panel.svg'),
              );
            },
          ),
          leftIconAction: () {},
          appBarHeading: const Text(
            'Explore',
            style: Fonts.h1,
          ),
          rightIcon: SvgPicture.asset(
            'assets/svgs/shopping_bag.svg',
            height: screenSize.height * 0.03,
          ),
          rightIconAction: () {},
        ),
        SizedBox(
          height: screenSize.height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColors.grey,
                    size: screenSize.height * 0.030,
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: screenSize.width * 0.2,
                  ),
                  filled: true,
                  fillColor: CustomColors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.02,
                  ),
                  hintText: 'Search',
                  hintStyle: Fonts.paragraph.copyWith(
                    color: CustomColors.grey,
                    fontSize: screenSize.height * 0.025,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      screenSize.width * 0.05,
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SvgPicture.asset(
                  'assets/svgs/sliders.svg',
                  height: screenSize.height * 0.025,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Select Category',
            style: Fonts.h2.copyWith(
              fontSize: textScaleFactor.scale(20),
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.02),
        TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          indicator: BoxDecoration(
            color: CustomColors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: CustomColors.black,
          labelStyle: Fonts.h2.copyWith(fontSize: 20),
          unselectedLabelStyle: Fonts.paragraph,
          tabs: [
            CustomTab(screenSize: screenSize, tabText: 'All Shoes'),
            CustomTab(screenSize: screenSize, tabText: 'Outdoor'),
            CustomTab(screenSize: screenSize, tabText: 'Tennis'),
            CustomTab(screenSize: screenSize, tabText: 'Clothes'),
          ],
        ),
        const SizedBox(
          height: 35,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Shoes',
              style: Fonts.h2.copyWith(
                  fontSize: textScaleFactor.scale(20),
                  color: CustomColors.grey),
            ),
            Text(
              'See all',
              style: Fonts.paragraph.copyWith(
                color: CustomColors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: screenSize.height * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) =>
                PopularShoeContainer(screenSize: screenSize),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'New Arrivals',
              style: Fonts.h2.copyWith(
                fontSize: screenSize.height * 0.0225,
              ),
            ),
            Text(
              'See all',
              style: Fonts.paragraph.copyWith(
                color: CustomColors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: screenSize.height * 0.16,
          decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summer Sale',
                      style: Fonts.paragraph
                          .copyWith(fontSize: screenSize.height * 0.02),
                    ),
                    Text(
                      '15% OFF',
                      style: Fonts.paragraph.copyWith(
                        fontSize: screenSize.height * 0.04,
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/svgs/new_arrival_shoe.svg',
                height: screenSize.height * 0.18,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
