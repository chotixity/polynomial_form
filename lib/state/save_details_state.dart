part of 'save_details_cubit.dart';

@freezed
class SaveDetailsState with _$SaveDetailsState {
  const factory SaveDetailsState.initial() = _Initial;
  const factory SaveDetailsState.loading() = _Loading;
  const factory SaveDetailsState.loaded({
    required String derivative,
  }) = _Loaded;
  const factory SaveDetailsState.error({
    required String message,
  }) = _Error;
}
