import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_criteria.freezed.dart';

@freezed
class SearchCriteria with _$SearchCriteria{
  const SearchCriteria._();

  const factory SearchCriteria({
    @Default('') String keyword,
  }) = _SearchCriteria;
}