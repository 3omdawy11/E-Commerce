import 'package:ecommerce/presentation/explore/explore_screen.dart';
import 'package:ecommerce/presentation/notification/notification_screen.dart';
import 'package:ecommerce/presentation/profile/profile_screen.dart';
import 'package:ecommerce/presentation/screen_manager/screen_bloc/screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/user_details/user_details_bloc.dart';
import '../../utilis/shared_widgets.dart';
import '../favorite/favorite_screen.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  @override
  void initState() {
    context.read<UserDetailsBloc>().add(LoadUserData());
    print("Entered the screen manager screen");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextScaler textScaleFactor = MediaQuery.of(context).textScaler;
    return ScreenManagerLayout(
      screenSize: screenSize,
      textScaleFactor: textScaleFactor,
      widgets: [
        BlocBuilder<ScreenBloc, ScreenState>(
          builder: (context, state) {
            if (state is HomeScreenState) {
              return ExploreScreen(
                screenSize: screenSize,
                textScaleFactor: textScaleFactor,
              );
            } else if (state is FavoriteScreenState) {
              return FavoriteScreen(
                screenSize: screenSize,
                textScaleFactor: textScaleFactor,
              );
            } else if (state is NotificationScreenState) {
              return NotificationScreen(
                screenSize: screenSize,
                textScaleFactor: textScaleFactor,
              );
            } else if (state is ProfileScreenState) {
              return ProfileScreen(
                screenSize: screenSize,
                textScaleFactor: textScaleFactor,
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
