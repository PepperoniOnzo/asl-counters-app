part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class OnFilePressed extends SearchEvent {
  OnFilePressed({required this.file});
  final FileStructureDto file;
}

class PopContent extends SearchEvent {}

class GetInitialContent extends SearchEvent {}
