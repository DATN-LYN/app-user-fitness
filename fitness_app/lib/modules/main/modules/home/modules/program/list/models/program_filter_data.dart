import 'package:fitness_app/global/graphql/__generated__/schema.schema.gql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../../global/graphql/fragment/__generated__/category_fragment.data.gql.dart';

part 'program_filter_data.freezed.dart';

@freezed
class ProgramFilterData with _$ProgramFilterData {
  const factory ProgramFilterData([
    String? keyword,
    GBODY_PART? bodyPart,
    @Default([]) List<GWORKOUT_LEVEL> levels,
    GCategory? category,
  ]) = _ProgramFilterData;
}
