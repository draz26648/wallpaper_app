import 'package:wallpaper/constants/end_points.dart';
import 'package:wallpaper/model/api/network.dart';
import 'package:wallpaper/model/models/photos_model.dart';

import '../models/base_models/photos.dart';

abstract class PhotosRepo {
  // Get all photos repository method to get all photos from the API and return a list of photos
  static Future<dynamic> getAllPhotos({
    int? page,
    int? perPage,
  }) async {
    Map<String, dynamic> queryParams = {
      "page": page,
      "per_page": perPage,
    };
    return await NetworkHelper()
        .get(url: homeItems, query: queryParams, model: PhotosModel());
  }

  // search photos repository method to get search result from the API and return a list of photos
  static Future<dynamic> searchRepo(String query) async {
    Map<String, dynamic> queryParams = {
      "query": query,
      "per_page": 10,
    };
    return await NetworkHelper()
        .get(url: search, query: queryParams, model: PhotosModel());
  }
}
