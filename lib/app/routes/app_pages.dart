import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import '../modules/AsrunImportSecondaryEvents/bindings/asrun_import_secondary_events_binding.dart';
import '../modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import '../modules/CompanyMaster/bindings/company_master_binding.dart';
import '../modules/CompanyMaster/views/company_master_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../providers/AuthGuard1.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;
  static const INITIAL = kReleaseMode
      ? Routes.HOME
      : (Routes.COMPANY_MASTER +
          "?personalNo=ces%2FeKicpwo5mz%2FYFOQDvw%3D%3D&loginCode=zWc5qlvs%2BXZUagqFBqBN0A%3D%3D&formName=OI8ukDpPPVN0I2BEXu2h4nuFu%2BZm1ZRpvP8NL4XCXzQ%3D");

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
    GetPage(
      name: _Paths.COMPANY_MASTER,
      page: () => AuthGuard(
        childName: _Paths.COMPANY_MASTER,
      ),
    ),
  ];
}
