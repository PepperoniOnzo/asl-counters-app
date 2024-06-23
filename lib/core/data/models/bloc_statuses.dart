enum BlocStatuses {
  initial,
  navigate,
  error,
  success,
  special;
}

final class BlocStatus {
  const BlocStatus({
    this.value = BlocStatuses.initial,
    this.errorMessage,
    this.specialDetails,
  });

  static const initial = BlocStatus();
  static const error = BlocStatus(value: BlocStatuses.error);
  static const success = BlocStatus(value: BlocStatuses.success);
  static const special = BlocStatus(value: BlocStatuses.special);

  factory BlocStatus.errorWithMessage(String errorMessage) =>
      BlocStatus(value: BlocStatuses.error, errorMessage: errorMessage);

  factory BlocStatus.specialWithDetails(String details) =>
      BlocStatus(value: BlocStatuses.special, specialDetails: details);

  Future<dynamic> callback({
    Function(String? error)? onError,
    Function()? onSuccess,
    Function(String? details)? onSpecial,
  }) async =>
      switch (value) {
        BlocStatuses.error => onError?.call(errorMessage),
        BlocStatuses.success => onSuccess?.call(),
        BlocStatuses.special => onSpecial?.call(specialDetails),
        _ => null,
      };

  final BlocStatuses value;
  final String? errorMessage;
  final String? specialDetails;
}

final class SearchSpecialDetails {
  static const String selectedFile = 'selected_file';
  static const String navigateOff = 'navigate_off';
}
