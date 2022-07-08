part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FindOutlierEvent extends HomeEvent{
  final String array;

  FindOutlierEvent(this.array);

  @override
  List<Object?> get props => [];
}

class BackButtonPressedEvent extends HomeEvent{
  @override
  List<Object?> get props => [];
}
