import 'package:marathondujeu/src/data/data.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final SearchCriteria searchCriteria;
  final Function(SearchCriteria)? onSearchCriteriaChanged;

  const SearchWidget({
    SearchCriteria? searchCriteria,
    this.onSearchCriteriaChanged,
    super.key,
  }) :
    searchCriteria = searchCriteria ?? const SearchCriteria();

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  SearchCriteria _searchCriteria = const SearchCriteria();
  final _searchController = SearchController();

  @override
  void initState() {
    super.initState();
    _searchCriteria = widget.searchCriteria;
    _searchController.text = _searchCriteria.keyword;
    _searchController.addListener(() {
      if(_searchController.text == _searchCriteria.keyword) return;
      _searchCriteria = _searchCriteria.copyWith(keyword: _searchController.text);
      callCriteriaChanged();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void callCriteriaChanged(){
    widget.onSearchCriteriaChanged?.call(_searchCriteria);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SearchBar(
              leading: const Icon(Icons.search),
              controller: _searchController,
              trailing: _searchController.text.isEmpty ? null : [IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                },
              )]
            ),
          ],
        ),
      ],
    );
  }
}
