import 'package:collection/collection.dart';

import '../gen/i18n.dart';

enum WorkoutLevel {
  beginner(1),
  intermediate(2),
  advanced(3);

  final double value;
  const WorkoutLevel(this.value);

  static String? label(double levelNumber, I18n i18n) {
    final level = WorkoutLevel.values.firstWhereOrNull(
      (item) => item.value == levelNumber,
    );
    if (level != null) return i18n.workoutLevel[level.index];
    return null;
  }
}
