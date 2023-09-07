import 'package:bmi/news/constats/constants.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: MyConst.baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
    String url,
    Map<String, dynamic> query,
  ) async {
    return await dio!.get(url, queryParameters: query);
  }
}
