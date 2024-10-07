

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'screen_event.dart';
part 'screen_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  int index = 0;
  ScreenBloc() : super(HomeScreenState(0)) {
    on<ScreenIndexChanged>((event, emit) {
      index = event.index;
      switch (index) {
        case 0:
          emit(HomeScreenState(0));
          break;
        case 1:
          emit(FavoriteScreenState(1));
          break;
        case 2:
          emit(NotificationScreenState(2));
          break;
        case 3:
          emit(ProfileScreenState(3));
          break;
        default:
          print("Error please check the number of screens");
      }
    });
    // on<SelectedHomeScreen>((event, emit) => emit(HomeScreenState(0)));
    // on<SelectedFavoriteScreen>((event, emit) => emit(FavoriteScreenState(1)));
    // on<SelectedNotificationScreen>((event, emit) => emit( NotificationScreenState(2)));
    // on<SelectedProfileScreen>((event, emit) => emit(ProfileScreenState(3)));
  }
}
