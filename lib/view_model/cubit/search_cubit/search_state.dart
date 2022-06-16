part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Photo> photos;

  SearchLoaded(this.photos);
}

class SearchError extends SearchState {}
