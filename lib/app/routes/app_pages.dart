import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import '../modules/AgencyGroupMaster/bindings/agency_group_master_binding.dart';
import '../modules/AgencyGroupMaster/views/agency_group_master_view.dart';
import '../modules/AgencyMaster/bindings/agency_master_binding.dart';
import '../modules/AgencyMaster/views/agency_master_view.dart';
import '../modules/AsrunImportSecondaryEvents/bindings/asrun_import_secondary_events_binding.dart';
import '../modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import '../modules/ClearSecondarySpots/bindings/clear_secondary_spots_binding.dart';
import '../modules/ClearSecondarySpots/views/clear_secondary_spots_view.dart';
import '../modules/ClientGroupMaster/bindings/client_group_master_binding.dart';
import '../modules/ClientGroupMaster/views/client_group_master_view.dart';
import '../modules/ClientEmbargo/bindings/client_embargo_binding.dart';
import '../modules/ClientEmbargo/views/client_embargo_view.dart';
import '../modules/ClientMaster/bindings/client_master_binding.dart';
import '../modules/ClientMaster/views/client_master_view.dart';
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
import '../modules/DealReport/bindings/deal_report_binding.dart';
import '../modules/DealReport/views/deal_report_view.dart';
import '../modules/EBillsForBonusActivity/bindings/e_bills_for_bonus_activity_binding.dart';
import '../modules/EBillsForBonusActivity/views/e_bills_for_bonus_activity_view.dart';
import '../modules/GSTPlantInfo/bindings/g_s_t_plant_info_binding.dart';
import '../modules/GSTPlantInfo/views/g_s_t_plant_info_view.dart';
import '../modules/InvoiceRevision/bindings/invoice_revision_binding.dart';
import '../modules/InvoiceRevision/views/invoice_revision_view.dart';
import '../modules/PlaceTypeMaster/bindings/place_type_master_binding.dart';
import '../modules/PlaceTypeMaster/views/place_type_master_view.dart';
import '../modules/ROAudit/bindings/r_o_audit_binding.dart';
import '../modules/ROAudit/views/r_o_audit_view.dart';
import '../modules/ReadytoBills/bindings/readyto_bills_binding.dart';
import '../modules/ReadytoBills/views/readyto_bills_view.dart';
import '../modules/SecondaryAsrunModification/bindings/secondary_asrun_modification_binding.dart';
import '../modules/SecondaryAsrunModification/views/secondary_asrun_modification_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../providers/AuthGuard1.dart';

// import '../modules/ClientGroupMasterts/bindings/client_group_master_binding.dart';
// import '../modules/ClientGroupMasterts/views/client_group_master_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

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
      page: () => AuthGuard(
        childName: _Paths.AGENCY_MASTER,
      ),
      binding: AgencyMasterBinding(),
    ),
    GetPage(
      name: _Paths.CLIENT_EMBARGO,
      // page: () =>  ClientEmbargoView(),
      page: () => AuthGuard(
        childName: _Paths.CLIENT_EMBARGO,
      ),
      binding: ClientEmbargoBinding(),
    ),
    GetPage(
      name: _Paths.E_BILLS_FOR_BONUS_ACTIVITY,
      page: () => const EBillsForBonusActivityView(),
      binding: EBillsForBonusActivityBinding(),
    ),
    GetPage(
      name: _Paths.SECONDARY_ASRUN_MODIFICATION,
      // page: () =>  SecondaryAsrunModificationView(),
      page: () => AuthGuard(childName: _Paths.SECONDARY_ASRUN_MODIFICATION),
      binding: SecondaryAsrunModificationBinding(),
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
    GetPage(
      name: _Paths.AGENCY_GROUP_MASTER,
      page: () => AuthGuard(childName: _Paths.AGENCY_GROUP_MASTER),
      binding: AgencyGroupMasterBinding(),
    ),
    GetPage(
      name: _Paths.DEAL_REPORT,
      page: () => const DealReportView(),
      binding: DealReportBinding(),
    ),
    GetPage(
      name: _Paths.G_S_T_PLANT_INFO,
      // page: () =>  GSTPlantInfoView(),
      page: () => AuthGuard(childName: _Paths.G_S_T_PLANT_INFO),
      binding: GSTPlantInfoBinding(),
    ),
    GetPage(
      name: _Paths.PLACE_TYPE_MASTER,
      // page: () =>  PlaceTypeMasterView(),
      page: () => AuthGuard(childName: _Paths.PLACE_TYPE_MASTER),
      binding: PlaceTypeMasterBinding(),
    ),
  ];
}
