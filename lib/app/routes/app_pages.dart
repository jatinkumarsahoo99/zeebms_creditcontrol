import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import '../modules/AgencyMaster/bindings/agency_master_binding.dart';
import '../modules/AgencyMaster/views/agency_master_view.dart';
import '../modules/AsrunImportSecondaryEvents/bindings/asrun_import_secondary_events_binding.dart';
import '../modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import '../modules/ClientMaster/bindings/client_master_binding.dart';
import '../modules/ClientMaster/views/client_master_view.dart';
import '../modules/ROAudit/bindings/r_o_audit_binding.dart';
import '../modules/ROAudit/views/r_o_audit_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../providers/AuthGuard1.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = kReleaseMode
      ? Routes.HOME
      : (Routes.AGENCY_MASTER +
          "?personalNo=R9vVPL7er1Os%2FusemWG%2FIw%3D%3D&loginCode=0iGe3vK5h2KGjfSKZTpmsQ%3D%3D&formName=0JUkJLseCJROuXQJxWn0tvQx2tD7hbegZhslvSOuxHotg9L%2FT284%2FQNIMZExXr81");

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
      name: _Paths.CLIENT_MASTER,
      page: () => const ClientMasterView(),
      binding: ClientMasterBinding(),
    ),
    GetPage(
      name: _Paths.R_O_AUDIT,
      // page: () =>  ROAuditView(),
      page: () => AuthGuard(
        childName: _Paths.R_O_AUDIT,
      ),
      binding: ROAuditBinding(),
    ),
    GetPage(
      name: _Paths.AGENCY_MASTER,
      // page: () =>  AgencyMasterView(),
      page: () => AuthGuard(childName: _Paths.AGENCY_MASTER,),
      binding: AgencyMasterBinding(),
    ),
  ];
}
