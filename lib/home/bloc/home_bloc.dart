import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FindOutlierEvent>((event, emit) {
      emit(HomeLoadingState());
      //TODO funkcja szukająca
      emit(HomeLoadedState(5));
    });

    on<BackButtonPressedEvent>((event,emit){
      emit(HomeInitial());
    });
  }
}
