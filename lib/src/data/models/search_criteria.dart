import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marathondujeu/src/data/collections/collections.dart';

part 'search_criteria.freezed.dart';

@freezed
class SearchCriteria with _$SearchCriteria{
  const SearchCriteria._();

  const factory SearchCriteria({
    @Default('') String keyword,
    Event? event,
  }) = _SearchCriteria;
}