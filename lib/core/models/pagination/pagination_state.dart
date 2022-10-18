import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_state.freezed.dart';

/// PaginationState class for pagination
@freezed
abstract class PaginationState<T> with _$PaginationState<T> {
  /// it is used to store list of items
  const factory PaginationState.data(List<T> items) = _Data;

  /// it is used for loading
  const factory PaginationState.loading() = _Loading;

  /// it is used for tracking error
  const factory PaginationState.error(Object? e, [StackTrace? stk]) = _Error;

  /// it is used to show onGoingLoading
  const factory PaginationState.onGoingLoading(List<T> items) = _OnGoingLoading;

  /// it is used to show onGoingError
  const factory PaginationState.onGoingError(
    List<T> items,
    Object? e, [
    StackTrace? stk,
  ]) = _OnGoingError;
}
