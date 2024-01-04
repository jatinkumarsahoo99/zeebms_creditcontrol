import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../modules/AsrunImportSecondaryEvents/bindings/asrun_import_secondary_events_binding.dart';
import '../modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../providers/AuthGuard1.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;
  static const INITIAL = kReleaseMode
      ? Routes.HOME
      : (Routes.ASRUN_IMPORT_SECONDARY_EVENTS +
          "?personalNo=CX5CP1oS3%2FepJloRhT%2F7JQ%3D%3D&loginCode=GhNK0fgJ1lghoL8cGVvoKg%3D%3D&formName=OI8ukDpPPVN0I2BEXu2h4nuFu%2BZm1ZRpvP8NL4XCXzQ%3D");

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ASRUN_IMPORT_SECONDARY_EVENTS,
      page: () => AuthGuard(
        childName: _Paths.ASRUN_IMPORT_SECONDARY_EVENTS,
      ),
      // binding: AsrunImportSecondaryEventsBinding(),
    ),
  ];
}
