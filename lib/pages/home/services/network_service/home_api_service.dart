import 'package:dio/dio.dart';
import 'package:task/constants/api_constant.dart';
import 'package:task/models/popular_response.dart';

class HomeApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstant.baseUrl,
    headers: {
      "accept": "application/json",
      "Authorization": "Bearer ${ApiConstant.apiKey}",
    },
    validateStatus: (status) => true,
  ));

  static Future<PopularResponse> getPopular(int page) async {
    Response response =
        await _dio.get(ApiConstant.popular, queryParameters: {"page": "$page"});
    if (response.statusCode == 200) {
      return PopularResponse.fromJson(response.data);
    } else {
      throw response.statusCode.toString();
    }
  }
}
