import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchQueryNotifier extends ChangeNotifier {
  String query;

  SearchQueryNotifier({
    required this.query,
  });

  void changeQuery(String newQuery) {
    query = newQuery;
    notifyListeners();
  }
}

final searchQueryProvider = ChangeNotifierProvider<SearchQueryNotifier>((ref) {
  return SearchQueryNotifier(query: '');
});
