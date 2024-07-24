import 'package:share_scooter/core/utils/resources/app_strings.dart';

class ErrorState {
  final String title;
  final String desc;
  ErrorState({
    required this.title,
    required this.desc,
  });
}

enum ErrorType {
  LOCATION,
  INTERNET,
}

extension ErrorTypeExtension on ErrorType {
  ErrorState getError([String? txt]) {
    switch (this) {
      case ErrorType.LOCATION:
        return ErrorState(title: AppStr.accessLocationError, desc: txt!);
      case ErrorType.INTERNET:
        return ErrorState(
            title: AppStr.internetErrorTitle, desc: AppStr.internetErrorDesc);
    }
  }
}
