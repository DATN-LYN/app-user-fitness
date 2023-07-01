import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchKeywordProvider = StateProvider.autoDispose<String>((ref) => '');
