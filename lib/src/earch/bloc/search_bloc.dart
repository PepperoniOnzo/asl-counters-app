import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/data/models/bloc_statuses.dart';
import '../../../core/data/models/content_response_dto.dart';
import '../../../core/data/models/file_structure_dto.dart';
import '../../../core/services/app_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required AppService appService})
      : _appService = appService,
        super(const SearchState()) {
    on<GetInitialContent>(_getInitialContent);
    on<OnFilePressed>(_onFilePressed);
    on<PopContent>(_popContent);

    add(GetInitialContent());
  }

  final AppService _appService;

  FutureOr<void> _getInitialContent(
      GetInitialContent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(requestInProcess: true));

    final response = await _appService.getContent();

    if (response.isSuccess()) {
      emit(state.copyWith(
          requestInProcess: false,
          files: (response.data as ContentResponseDto).content));
      return;
    }

    emit(state.copyWith(requestInProcess: false, status: BlocStatus.error));
  }

  FutureOr<void> _onFilePressed(
      OnFilePressed event, Emitter<SearchState> emit) async {
    if (!event.file.isDirectory) {
      emit(state.copyWith(
          status: BlocStatus.specialWithDetails(
              SearchSpecialDetails.selectedFile)));
      return;
    }

    emit(state.copyWith(requestInProcess: true));
    final String newContentPath = '${state.currentDirectory}${event.file.id}/';
    final response = await _appService.getContent(path: newContentPath);
    if (response.isSuccess()) {
      emit(state.copyWith(
          requestInProcess: false,
          currentDirectory: newContentPath,
          files: (response.data as ContentResponseDto).content));
      return;
    }

    emit(state.copyWith(requestInProcess: false, status: BlocStatus.error));
  }

  FutureOr<void> _popContent(
      PopContent event, Emitter<SearchState> emit) async {
    if (state.currentDirectory == '/') {
      emit(state.copyWith(
          status:
              BlocStatus.specialWithDetails(SearchSpecialDetails.navigateOff)));
      return;
    }
    String newContentPath = '/${(state.currentDirectory.split('/')
      ..removeWhere((element) => element.isEmpty)
      ..removeLast()).join('/')}/';

    if (newContentPath == '//') {
      newContentPath = '/';
    }

    final response = await _appService.getContent(path: newContentPath);
    if (response.isSuccess()) {
      emit(state.copyWith(
          requestInProcess: false,
          currentDirectory: newContentPath,
          files: (response.data as ContentResponseDto).content));
      return;
    }

    emit(state.copyWith(requestInProcess: false, status: BlocStatus.error));
  }
}
