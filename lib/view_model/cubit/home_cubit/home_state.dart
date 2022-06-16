part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Photo> photos;

  HomeLoaded({required this.photos});
}

class HomeError extends HomeState {}
