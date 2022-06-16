import 'package:dio/dio.dart';
import 'package:wallpaper/constants/end_points.dart';

import 'mapper.dart';

class NetworkHelper {
  static NetworkHelper? _instance;
  static late Dio _dio;

  NetworkHelper._internal();

  factory NetworkHelper() {
    if (_instance == null) {
      _dio = Dio();
      _dio.options.baseUrl = baseUrl;
      _instance = NetworkHelper._internal();
    }
    return _instance!;
  }

// get method to get data from the API i use this case better than call every end point separately
  Future<dynamic> get(
      {required String url,
      Mapper? model,
      Map<String, dynamic>? query,
      var headers}) async {
    Response _res;
    if (headers != null) {
      _dio.options.headers = headers;
    } else {
      _dio.options.headers = {
        'Authorization': '$apiKey',
        'Accept': 'application/json'
      };
    }
    print('End point: => $url');
    try {
      _res = await _dio.get(url, queryParameters: query);
    } on DioError catch (e) {
      print('Exception in $url: => ${e.response.toString()}');
      _res = e.response!;
    }
    print('Response of $url: => ${_res.toString()}');
    if (model == null) {
      return _res;
    } else {
      return Mapper(model, _res.data);
    }
  }
}
