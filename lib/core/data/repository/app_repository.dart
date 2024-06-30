
import 'package:dio/dio.dart';

import '../../network/api_constants.dart';
import '../../network/api_service.dart';
import '../../network/network_response.dart';
import '../models/content_response_dto.dart';

class AppRepository {
  AppRepository({required ApiService apiService}) : _apiService = apiService;

  final ApiService _apiService;

  Future<NetworkResponse<List<int>>> getImage({required String path}) =>
      _apiService.request(
        query: {'path': path},
        ApiConstants.image,
        type: ApiRequestType.get,
        options: Options(responseType: ResponseType.bytes),
      );

  Future<NetworkResponse<ContentResponseDto>> getContent(
          {required String path}) =>
      _apiService.request(ApiConstants.content,
          type: ApiRequestType.get,
          query: {'path': path},
          mapToJson: (json) =>
              ContentResponseDto.fromJson(json as Map<String, dynamic>));
}
