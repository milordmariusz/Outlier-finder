part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class OutlierFoundState extends HomeState{
  final String outlier;

  OutlierFoundState(this.outlier);

  @override
  List<Object?> get props => [outlier];
}

class OutlierNotFoundState extends HomeState{
  final String message;

  OutlierNotFoundState(this.message);

  @override
  List<Object?> get props => [message];
}
