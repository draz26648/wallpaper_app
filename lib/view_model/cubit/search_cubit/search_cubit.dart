import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/models/base_models/photos.dart';
import '../../../model/models/photos_model.dart';
import '../../../model/repository/photos_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);

  void getResult({
    required String searchText,
  }) async {
    emit(SearchLoading());
    PhotosModel _res = await PhotosRepo.searchRepo(searchText);
    if (_res.totalResults != null) {
      emit(SearchLoaded(_res.photos!));
    } else {
      emit(SearchError());
    }
  }
}
