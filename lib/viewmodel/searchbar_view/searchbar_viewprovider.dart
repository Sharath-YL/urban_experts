import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mychoice/data/models/recentworkmodel.dart';
import 'package:mychoice/viewmodel/homescreenview_model/homescreenview_provider.dart';

class SearchHit {
  final String serviceId;
  final String title;
  final String imageUrl;

  const SearchHit({
    required this.serviceId,
    required this.title,
    required this.imageUrl,
  });
}

class SearchProvider with ChangeNotifier {
  final HomescreenviewProvider _home;
  Timer? _debounce;

  SearchProvider(this._home) {
    _home.addListener(_reindexFromHome);
    _reindexFromHome();
  }

  List<SearchHit> _index = [];
  List<SearchHit> _results = [];
  String _query = '';

  List<SearchHit> get results => _results;
  String get query => _query;
  bool get isActive => _query.trim().isNotEmpty;

  void _reindexFromHome() {
    final List<SearchHit> next = [];
    for (final item in _home.recentworkmodel) {
      next.add(SearchHit(
        serviceId: item.id,
        title: item.title,
        imageUrl: item.imageurl,
      ));
    }
    _index = next;
    _filter(_query);
  }

  void setQuery(String q) {
    _query = q;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      _filter(_query);
    });
  }

  void clear() {
    _query = '';
    _results = [];
    notifyListeners();
  }

  void _filter(String q) {
    final needle = _norm(q);
    if (needle.isEmpty) {
      _results = [];
    } else {
      _results = _index.where((hit) => _norm(hit.title).contains(needle)).toList();
    }
    notifyListeners();
  }

  String _norm(String s) => s.toLowerCase().trim();

  @override
  void dispose() {
    _debounce?.cancel();
    _home.removeListener(_reindexFromHome);
    super.dispose();
  }
}
