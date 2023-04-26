import '../gen/i18n.dart';

enum WorkoutLevel {
  beginner(1),
  intermediate(2),
  advanced(3);

  final double value;
  const WorkoutLevel(this.value);

  static String getLabel(double level, I18n i18n) {
    final levelIndex =
        WorkoutLevel.values.firstWhere((item) => item.value == level).index;
    return i18n.workoutLevel[levelIndex];
  }
}
