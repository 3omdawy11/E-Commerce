part of 'screen_bloc.dart';

@immutable
abstract class ScreenState {
  int screenIndex;
  ScreenState(this.screenIndex);
}

class ScreenInitial extends ScreenState {
  ScreenInitial(super.screenIndex);
}

class HomeScreenState extends ScreenState {
  HomeScreenState(super.screenIndex);
}

class FavoriteScreenState extends ScreenState {
  FavoriteScreenState(super.screenIndex);
}

class NotificationScreenState extends ScreenState {
  NotificationScreenState(super.screenIndex);
}

class ProfileScreenState extends ScreenState {
  ProfileScreenState(super.screenIndex);
}
