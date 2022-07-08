import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FindOutlierEvent>((event, emit) {
      emit(HomeLoadingState());
      final outlier = FindOutlier(event.array);
      emit(HomeLoadedState("pies"));
    });

    on<BackButtonPressedEvent>((event,emit){
      emit(HomeInitial());
    });
  }
}

String FindOutlier(String array){
  List<String> arrayWithOutlier = array.split(",");
  arrayWithOutlier.forEach((number) {
    print(number);
  });
  return "pies";
}