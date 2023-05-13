import '../graphql/fragment/__generated__/exercise_fragment.data.gql.dart';

class ExerciseHelper {
  ExerciseHelper._();

  static double getTotalCalo(List<GExercise> exercises) {
    return exercises.map((e) => e.calo).reduce((a, b) => a! + b!) ?? 0;
  }

  static double getTotalDuration(List<GExercise> exercises) {
    return exercises.map((e) => e.duration).reduce((a, b) => a! + b!) ?? 0;
  }
}
