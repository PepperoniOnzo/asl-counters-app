import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../data/models/content_response_dto.dart';
import 'app_service.dart';

class CachingService {
  CachingService({
    required AppService appService,
  }) : _appService = appService;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _savedFiles =
        _sharedPreferences.getStringList(SharedPrefs.savedFilesKey) ?? [];
    _savedContentResponses =
        _sharedPreferences.getStringList(SharedPrefs.savedContentResponses) ??
            [];
    _tmpDirectory = '${(await getTemporaryDirectory()).path}/';
  }

  final AppService _appService;
  late final SharedPreferences _sharedPreferences;
  late final String _tmpDirectory;
  List<String> _savedFiles = [];
  List<String> _savedContentResponses = [];

  Future<void> cacheImage({required String path, required String id}) async {
    if (_savedFiles.contains(id)) {
      return;
    }

    final response = await _appService.getImage(path: path);

    if (response.isSuccess()) {
      _savedFiles.add(id);
      _sharedPreferences.setStringList(SharedPrefs.savedFilesKey, _savedFiles);
      await File(_tmpDirectory + id).writeAsBytes(response.data as List<int>);
    }
  }

  Future<File?> getCachedImage({required String id}) async {
    if (_savedFiles.contains(id)) {
      return File(_tmpDirectory + id);
    }

    return null;
  }

  Future<void> putCachedContentResponse(
      {required ContentResponseDto response, required String id}) async {
    final formateId = id.replaceAll('/', '_');
    final file = File('$_tmpDirectory$formateId.json');
    await file.writeAsString(jsonEncode(response.toJson()));
  }

  Future<ContentResponseDto?> getCachedContentResponse(
      {required String id}) async {
    if (_savedContentResponses.contains(id)) {
      final formateId = id.replaceAll('/', '_');
      final file = File(_tmpDirectory + formateId);
      final response = await file.readAsString();

      if (response.isNotEmpty) {
        try {
          return ContentResponseDto.fromJson(
              jsonDecode(response) as Map<String, dynamic>);
        } catch (e) {
          _savedContentResponses.remove(formateId);
          _sharedPreferences.setStringList(
              SharedPrefs.savedContentResponses, _savedContentResponses);
          if (kDebugMode) {
            print('\u001b[32mFAILED TO GET SAVED RESPONSE: $id\u001b[0m');
          }
        }
      }
    }

    return null;
  }
}
