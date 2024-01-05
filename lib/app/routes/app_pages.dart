import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import '../modules/AgencyGroupMaster/bindings/agency_group_master_binding.dart';
import '../modules/AgencyGroupMaster/views/agency_group_master_view.dart';
import '../modules/AgencyMaster/bindings/agency_master_binding.dart';
import '../modules/AgencyMaster/views/agency_master_view.dart';
import '../modules/AsrunImportSecondaryEvents/bindings/asrun_import_secondary_events_binding.dart';
import '../modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import '../modules/ClientEmbargo/bindings/client_embargo_binding.dart';
import '../modules/ClientEmbargo/views/client_embargo_view.dart';
import '../modules/ClientMaster/bindings/client_master_binding.dart';
import '../modules/ClientMaster/views/client_master_view.dart';
import '../modules/ComboDealEntry/bindings/combo_deal_entry_binding.dart';
import '../modules/ComboDealEntry/views/combo_deal_entry_view.dart';
import '../modules/CompanyMaster/bindings/company_master_binding.dart';
import '../modules/CompanyMaster/views/company_master_view.dart';
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

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = kReleaseMode
      ? Routes.HOME
      : (Routes.PLACE_TYPE_MASTER +
          "?personalNo=R9vVPL7er1Os%2FusemWG%2FIw%3D%3D&loginCode=0iGe3vK5h2KGjfSKZTpmsQ%3D%3D&formName=0JUkJLseCJROuXQJxWn0tvQx2tD7hbegZhslvSOuxHotg9L%2FT284%2FQNIMZExXr81");

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
      name: _Paths.AGENCY_GROUP_MASTER,
      // page: () =>  AgencyGroupMasterView(),
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
