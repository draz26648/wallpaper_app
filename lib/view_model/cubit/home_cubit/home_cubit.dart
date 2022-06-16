import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper/model/models/photos_model.dart';
import 'package:wallpaper/model/repository/photos_repo.dart';

import '../../../model/models/base_models/photos.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

// Get all photos cubit method to get all photos from the repository
  void getPhotos({
    int? page,
    int? perPage,
  }) async {
    emit(HomeLoading());
    PhotosModel _res = await PhotosRepo.getAllPhotos(
      page: page,
      perPage: perPage,
    );
    if (_res.totalResults != null) {
      emit(HomeLoaded(photos: _res.photos!));
    } else {
      emit(HomeError());
    }
  }
}
