import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_constants.dart';
import 'network_response.dart';

enum ApiRequestType {
  get,
  post,
  put,
  delete,
  patch;
}

class ApiService {
  ApiService();

  final String _baseUrl = ApiConstants.baseUrl;
  final _dio = Dio(BaseOptions(receiveDataWhenStatusError: true))
    ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  Future<NetworkResponse<T>> request<T>(
    String path, {
    required ApiRequestType type,
    Map<dynamic, dynamic>? body,
    Object? data,
    Map<String, dynamic>? query,
    bool isFromRefresh = false,
    T Function(dynamic)? mapToJson,
    Options? options,
  }) async {
    Response<dynamic>? response;

    try {
      switch (type) {
        case ApiRequestType.get:
          response = await _dio.get('$_baseUrl$path',
              queryParameters: query,
              options: options ?? Options(responseType: ResponseType.json));
        case ApiRequestType.post:
          response = await _dio.post('$_baseUrl$path',
              queryParameters: query,
              data: jsonEncode(body),
              options: Options(responseType: ResponseType.json));
        case ApiRequestType.put:
          response = await _dio.put('$_baseUrl$path',
              queryParameters: query,
              data: data ?? jsonEncode(body),
              options: Options(responseType: ResponseType.json));
        case ApiRequestType.delete:
          response = await _dio.delete('$_baseUrl$path',
              queryParameters: query,
              data: data ?? jsonEncode(body),
              options: Options(responseType: ResponseType.json));
        case ApiRequestType.patch:
          response = await _dio.patch('$_baseUrl$path',
              queryParameters: query,
              data: jsonEncode(body),
              options: Options(responseType: ResponseType.json));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Token refreshment

        if (!isFromRefresh) {
          return request(path,
              type: type,
              body: body,
              data: data,
              isFromRefresh: true,
              mapToJson: mapToJson,
              query: query);
        }

        return NetworkResponse.error(401, e.toString());
      }

      return handleResponseError(e);
    }

    if (response.data == null) {
      return NetworkResponse.error(500, null);
    }

    dynamic mappedObj;
    try {
      if (mapToJson != null) {
        mappedObj = mapToJson(response.data);
      }
    } on Exception {
      if (kDebugMode) {
        print('\u001b[31mERROR: parsing error(ApiService)\u001b[0m');
      }
    }

    return NetworkResponse(mapToJson != null ? mappedObj : response.data,
        response.statusCode ?? 500, null);
  }

  NetworkResponse<T> handleResponseError<T>(DioException e) {
    if (e.response == null &&
        e.response?.statusCode == null &&
        e.response?.statusMessage == null) {
      return NetworkResponse.error(500, e.toString());
    }

    if (kDebugMode &&
        (e.response?.data as Map<String, dynamic>).containsKey('message')) {
      // ignore: avoid_print
      print(
          '\u001b[31mERROR: ${(e.response?.data as Map<String, dynamic>)['message'] as String}\nStatus message: ${e.response!.statusMessage}\u001b[0m');
    }

    return NetworkResponse.error(
        e.response!.statusCode!, e.response!.statusMessage);
  }
}
