import 'package:fitness_app/global/graphql/__generated__/schema.schema.gql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'program_filter_data.freezed.dart';

@freezed
class ProgramFilterData with _$ProgramFilterData {
  const factory ProgramFilterData([
    String? keyword,
    @Default([]) List<GBODY_PART> bodyParts,
    @Default([]) List<GWORKOUT_LEVEL> levels,
  ]) = _ProgramFilterData;
}
