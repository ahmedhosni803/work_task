import 'package:dio/dio.dart';
import 'package:task/constants/api_constant.dart';
import 'package:task/models/image_response.dart';
import 'package:task/models/persone_response.dart';

class DetailsPopularApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstant.baseUrl,
    headers: {
      "accept": "application/json",
      "Authorization": "Bearer ${ApiConstant.apiKey}",
    },
    validateStatus: (status) => true,
  ));

  static Future<PersonResponse> getPopularDetails(String id) async {
    Response response = await _dio.get(ApiConstant.personDetails(id));
    if (response.statusCode == 200) {
      return PersonResponse.fromJson(response.data);
    } else {
      throw response.statusCode.toString();
    }
  }

  static Future<ImageResponse> getPopularImage(String id) async {
    Response response = await _dio.get(ApiConstant.images(id));
    if (response.statusCode == 200) {
      return ImageResponse.fromJson(response.data);
    } else {
      throw response.statusCode.toString();
    }
  }
}
