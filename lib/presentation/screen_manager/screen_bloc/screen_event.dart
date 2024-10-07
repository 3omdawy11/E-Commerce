part of 'screen_bloc.dart';

@immutable
abstract class ScreenEvent {}

// class SelectedHomeScreen extends ScreenEvent {}
// class SelectedFavoriteScreen extends ScreenEvent {}
// class SelectedNotificationScreen extends ScreenEvent {}
// class SelectedProfileScreen extends ScreenEvent {}
class ScreenIndexChanged extends ScreenEvent {
  int index;
  ScreenIndexChanged (this.index);
}