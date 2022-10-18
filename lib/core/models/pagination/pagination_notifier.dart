import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallabox/core/models/pagination/pagination_state.dart';

/// Notifier for Pagination
class PaginationNotifier<T> extends StateNotifier<PaginationState<T>> {
  /// Creates a instances for [PaginationNotifier]
  PaginationNotifier({
    required this.fetchNextItems,
    required this.limit,
  }) : super(const PaginationState.loading());

  /// Call back function to fetch Next set of items
  final Future<List<T>> Function(int page) fetchNextItems;

  /// total limit per request
  final int limit;

  final List<T> _items = [];

  /// Pagination page
  int page = 1;

  Timer _timer = Timer(Duration.zero, () {});

  /// to check the pagination ends
  bool noMoreItems = false;

  /// init function
  void init() {
    if (_items.isEmpty) {
      fetchFirstPage();
    }
  }

  /// fetch first page
  Future<void> fetchFirstPage() async {
    try {
      state = const PaginationState.loading();
      //ignore: lines_longer_than_80_chars
      final result = _items.isEmpty ? await fetchNextItems(page) : await fetchNextItems(page);
      updateData(result);
    } catch (e, stk) {
      state = PaginationState.error(e, stk);
    }
  }

  /// update items in notifier
  void updateData(List<T> result) {
    debugPrint(' ... [paginationNotifier] => updateData => $page ... ');
    noMoreItems = result.length < limit;
    page = page + 1;
    debugPrint(' ... $page ... ');
    if (result.isEmpty) {
      state = PaginationState.data(_items);
    } else {
      state = PaginationState.data(_items..addAll(result));
    }
  }

  ///
  Future<void> fetchNextPage() async {
    if (_timer.isActive && _items.isNotEmpty) {
      return;
    }
    _timer = Timer(const Duration(milliseconds: 1000), () {});

    if (noMoreItems) {
      return;
    }

    if (state == PaginationState<T>.onGoingLoading(_items)) {
      debugPrint('Rejected');
      return;
    }

    debugPrint('Fetching next batch of items');

    state = PaginationState.onGoingLoading(_items);

    try {
      await Future.delayed(const Duration(seconds: 1), () {});
      final result = await fetchNextItems(page);
      debugPrint(result.length.toString());
      updateData(result);
    } catch (e, stk) {
      debugPrint('Error fetching next page ERROR: $e');
      state = PaginationState.onGoingError(_items, e, stk);
    }
  }
}
