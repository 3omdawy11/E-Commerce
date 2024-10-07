import 'package:ecommerce/presentation/screen_manager/screen_bloc/screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utilis/colors.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    List<NavItem> navItems = [
      NavItem('assets/svgs/home.svg', "Home"),
      NavItem('assets/svgs/heart.svg', "Favorite"),
      NavItem('assets/svgs/notification.svg', "Notification"),
      NavItem('assets/svgs/profile.svg', "Profile"),
    ];

    return SizedBox(
      width: double.infinity, // Ensures the BottomAppBar takes up the full width
      child: BottomAppBar(
        color: CustomColors.white,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: navItems.map((item) {
            int index = navItems.indexOf(item);
            return Flexible( // Ensures the icons adjust to available space
              child: IconButton(
                onPressed: () => context.read<ScreenBloc>().add(ScreenIndexChanged(index)),
                icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: BlocBuilder<ScreenBloc, ScreenState>(
                    builder: (context, state) {
                      return SvgPicture.asset(
                        item.iconPath,
                        fit: BoxFit.fill,
                        color: index == state.screenIndex
                            ? CustomColors.blue
                            : CustomColors.grey,
                      );
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NavItem {
  final String iconPath;
  final String title;

  NavItem(this.iconPath, this.title);
}
