import '../gen/i18n.dart';
import '../graphql/__generated__/schema.schema.gql.dart';

extension GenderExtension on GGENDER {
  String label(I18n i18n) {
    switch (this) {
      case GGENDER.Male:
        return i18n.gender[0];
      case GGENDER.Female:
        return i18n.gender[1];
      case GGENDER.Others:
        return i18n.gender[2];
      default:
        return i18n.gender[0];
    }
  }
}
