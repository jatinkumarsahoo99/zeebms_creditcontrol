import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import '../modules/AsrunImportSecondaryEvents/bindings/asrun_import_secondary_events_binding.dart';
import '../modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import '../modules/ClearSecondarySpots/bindings/clear_secondary_spots_binding.dart';
import '../modules/ClearSecondarySpots/views/clear_secondary_spots_view.dart';
import '../modules/ClientGroupMaster/bindings/client_group_master_binding.dart';
import '../modules/ClientGroupMaster/views/client_group_master_view.dart';
import '../modules/ComboDealEntry/bindings/combo_deal_entry_binding.dart';
import '../modules/ComboDealEntry/views/combo_deal_entry_view.dart';
import '../modules/CompanyMaster/bindings/company_master_binding.dart';
import '../modules/CompanyMaster/views/company_master_view.dart';
import '../modules/CreditRateMaster/bindings/credit_rate_master_binding.dart';
import '../modules/CreditRateMaster/views/credit_rate_master_view.dart';
import '../modules/InvoiceRevision/bindings/invoice_revision_binding.dart';
import '../modules/InvoiceRevision/views/invoice_revision_view.dart';
import '../modules/PayrouteCategoryMaster/bindings/payroute_category_master_binding.dart';
import '../modules/PayrouteCategoryMaster/views/payroute_category_master_view.dart';
import '../modules/ReadytoBills/bindings/readyto_bills_binding.dart';
import '../modules/ReadytoBills/views/readyto_bills_view.dart';
import '../modules/UndoCancelation/bindings/undo_cancelation_binding.dart';
import '../modules/UndoCancelation/views/undo_cancelation_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../providers/AuthGuard1.dart';

// import '../modules/ClientGroupMasterts/bindings/client_group_master_binding.dart';
// import '../modules/ClientGroupMasterts/views/client_group_master_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;
  static const INITIAL = kReleaseMode
      ? Routes.HOME
      : (Routes.PAYROUTE_CATEGORY_MASTER +
          "?personalNo=ces%2FeKicpwo5mz%2FYFOQDvw%3D%3D&loginCode=zWc5qlvs%2BXZUagqFBqBN0A%3D%3D&formName=OI8ukDpPPVN0I2BEXu2h4nuFu%2BZm1ZRpvP8NL4XCXzQ%3D");

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ASRUN_IMPORT_SECONDARY_EVENTS,
      page: () => AuthGuard(childName: _Paths.ASRUN_IMPORT_SECONDARY_EVENTS),
      // binding: AsrunImportSecondaryEventsBinding(),
    ),
    GetPage(
      name: _Paths.COMPANY_MASTER,
      page: () => AuthGuard(
        childName: _Paths.COMPANY_MASTER,
      ),
    ),
    GetPage(
      name: _Paths.COMBO_DEAL_ENTRY,
      page: () => AuthGuard(childName: _Paths.COMBO_DEAL_ENTRY),
    ),
    GetPage(
      name: _Paths.READYTO_BILLS,
      page: () => AuthGuard(childName: _Paths.READYTO_BILLS),
    ),
    GetPage(
      name: _Paths.INVOICE_REVISION,
      page: () => AuthGuard(childName: _Paths.INVOICE_REVISION),
    ),
    GetPage(
      name: _Paths.UNDO_CANCELATION,
      page: () => AuthGuard(childName: _Paths.UNDO_CANCELATION),
    ),
    GetPage(
      name: _Paths.CLEAR_SECONDARY_SPOTS,
      page: () => AuthGuard(childName: _Paths.CLEAR_SECONDARY_SPOTS),
    ),
    GetPage(
      name: _Paths.CLIENT_GROUP_MASTER,
      page: () => AuthGuard(childName: _Paths.CLIENT_GROUP_MASTER),
    ),
    GetPage(
      name: _Paths.CREDIT_RATE_MASTER,
      page: () => AuthGuard(childName: _Paths.CREDIT_RATE_MASTER),
    ),
    GetPage(
      name: _Paths.PAYROUTE_CATEGORY_MASTER,
      page: () => AuthGuard(childName: _Paths.PAYROUTE_CATEGORY_MASTER),
    ),
  ];
}
