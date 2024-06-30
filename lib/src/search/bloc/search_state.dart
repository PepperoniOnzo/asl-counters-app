part of 'search_bloc.dart';

@immutable
final class SearchState {
  const SearchState({
    this.files = const [],
    this.requestInProcess = false,
    this.currentDirectory = '/',
    this.status = BlocStatus.initial,
  });

  final List<FileStructureDto> files;
  final String currentDirectory;
  final bool requestInProcess;
  final BlocStatus status;

  SearchState copyWith({
    List<FileStructureDto>? files,
    bool? requestInProcess,
    String? currentDirectory,
    BlocStatus status = BlocStatus.initial,
  }) =>
      SearchState(
        status: status,
        files: files ?? this.files,
        currentDirectory: currentDirectory ?? this.currentDirectory,
        requestInProcess: requestInProcess ?? this.requestInProcess,
      );
}
