import 'package:dio/dio.dart';
import 'package:task/constant/constant_api.dart';
import 'package:task/constant/end_point.dart';
import 'package:task/model/image_response.dart';
import 'package:task/model/persone_response.dart';
import 'package:task/model/popular_response.dart';

class ApiManger {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConst.baseUrl,
    headers: {
      "accept": "application/json",
      "Authorization": "Bearer ${ApiConst.apiKey}",
    },
    validateStatus: (status) => true,
  ));

// get Popular
  static Future<PopularResponse> getPopular(int page) async {
    Response response =
        await _dio.get(EndPoint.popular, queryParameters: {"page": "$page"});
    if (response.statusCode == 200) {
      return PopularResponse.fromJson(response.data);
    } else {
      throw response.statusCode.toString();
    }
  }

// get Popular details
  static Future<PersonResponse> getPopularDetails(String id) async {
    Response response = await _dio.get(EndPoint.personDetails(id));
    if (response.statusCode == 200) {
      return PersonResponse.fromJson(response.data);
    } else {
      throw response.statusCode.toString();
    }
  }

  // get Popular details
  static Future<ImageResponse> getPopularImage(String id) async {
    Response response = await _dio.get(EndPoint.images(id));
    if (response.statusCode == 200) {
      return ImageResponse.fromJson(response.data);
    } else {
      throw response.statusCode.toString();
    }
  }
}
