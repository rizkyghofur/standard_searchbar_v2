import 'package:flutter/material.dart';
import 'package:standard_searchbar_v2/new/standard_search_anchor.dart';
import 'package:standard_searchbar_v2/new/standard_search_bar.dart';
import 'package:standard_searchbar_v2/new/standard_suggestions.dart';

class StandardSearchController extends TextEditingController {
  // Anchor attached to this controller
  StandardSearchAnchorState? _anchor;
  set anchor(StandardSearchAnchorState anchor) => _anchor = anchor;

  // SearchBar attached to this controller
  StandardSearchBarState? _searchBar;
  StandardSearchBarState get searchBar => _searchBar!;
  set searchBar(StandardSearchBarState searchBar) => _searchBar = searchBar;

  // Suggestions box attached to this controller
  StandardSuggestionsState? _suggestions;
  StandardSuggestionsState get suggestions => _suggestions!;
  set suggestions(StandardSuggestionsState suggestions) =>
      _suggestions = suggestions;

  bool get isOpen => _anchor?.isOpen ?? false;

  static final List<bool> unfocus = [false, false];

  void open() {
    _anchor?.open();
    // ignore: invalid_use_of_protected_member
    _searchBar?.setState(() {});
  }

  void requestClose() {
    if (unfocus[0] && unfocus[1]) {
      close();
      unfocus[0] = false;
      unfocus[1] = false;
    }
  }

  void close() {
    _anchor?.close();
    // ignore: invalid_use_of_protected_member
    _searchBar?.setState(() {});
  }

  @override
  void clear() {
    super.clear();
    _anchor?.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _anchor?.close();
  }
}
