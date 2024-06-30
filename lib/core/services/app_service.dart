
import '../data/models/content_response_dto.dart';
import '../data/repository/app_repository.dart';
import '../network/network_response.dart';

class AppService {
  AppService({required AppRepository appRepository})
      : _appRepository = appRepository;

  final AppRepository _appRepository;

  Future<NetworkResponse<ContentResponseDto>> getContent({String path = '/'}) =>
      _appRepository.getContent(path: path);

  Future<NetworkResponse<List<int>>> getImage({required String path}) =>
      _appRepository.getImage(path: path);
}
