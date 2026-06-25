import 'package:flutter_riverpod/flutter_riverpod.dart';

final mechanicRequestCategoryProvider = StateProvider.autoDispose<String>(
  (ref) => 'Колеса',
);

final mechanicRequestDetailProvider = StateProvider.autoDispose<String>(
  (ref) => 'Колесо A',
);

final mechanicRequestCommentProvider = StateProvider.autoDispose<String>(
  (ref) => 'Нужна замена после осмотра ТО.',
);

final mechanicRequestQuantityProvider = StateProvider.autoDispose<int>(
  (ref) => 1,
);

final mechanicRequestStatusProvider = StateProvider.autoDispose<String?>(
  (ref) => null,
);

final defectDescriptionProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final defectPhotoAttachedProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);
