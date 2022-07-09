import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FindOutlierEvent>((event, emit) {
      emit(HomeLoadingState());
      final result = findOutlier(event.array);

      if (int.tryParse(result) is int) {
        emit(OutlierFoundState(result));
      } else {
        emit(OutlierNotFoundState(result));
      }
    });

    on<BackButtonPressedEvent>((event, emit) {
      emit(HomeInitial());
    });
  }
}

String findOutlier(String array) {
  List<String> arrayWithOutlier = array.split(",");
  int? number;
  int numberOfEven = 0;
  int? evenOutlier;
  int numberOfOdd = 0;
  int? oddOutlier;
  for (var arrayNumber in arrayWithOutlier) {
    number = int.tryParse(arrayNumber);
    if (number == null) {
      return "Nieprawidłowe dane";
    }

    if (number % 2 == 0) {
      numberOfEven += 1;
      evenOutlier = number;
    } else {
      numberOfOdd += 1;
      oddOutlier = number;
    }

    if (numberOfEven > 1 && numberOfOdd > 1) {
      return "Istnieje więcej niż jedna odstająca wartość";
    }
  }

  if ((numberOfEven == 0 || numberOfOdd == 0) || numberOfEven == numberOfOdd) {
    return "Wartość odstająca nie istnieje";
  }

  if (numberOfEven < numberOfOdd) {
    return evenOutlier.toString();
  } else {
    return oddOutlier.toString();
  }
}
