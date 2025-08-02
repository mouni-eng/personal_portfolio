import 'package:easy_localization/easy_localization.dart';

extension StringExtensions on String {
  String get translate => this.tr();
  String translateWith({List<String>? args, Map<String, String>? namedArgs}) =>
      this.tr(args: args, namedArgs: namedArgs);
}
