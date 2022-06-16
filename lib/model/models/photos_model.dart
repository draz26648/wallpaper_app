import 'package:wallpaper/model/api/mapper.dart';

import 'base_models/photos.dart';

class PhotosModel extends SingleMapper {
  PhotosModel({
    this.page,
    this.perPage,
    this.photos,
    this.totalResults,
    this.nextPage,
  });
  int? page;
  int? perPage;
  List<Photo>? photos;
  int? totalResults;
  String? nextPage;
  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return PhotosModel(
      page: json["page"] == null ? null : json["page"],
      perPage: json["per_page"] == null ? null : json["per_page"],
      photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      totalResults:
          json["total_results"] == null ? null : json["total_results"],
      nextPage: json["next_page"] == null ? null : json["next_page"],
    );
  }
}
