import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import '../../widgets/NoDataFoundPage.dart';
import '../modules/AgencyGroupMaster/bindings/agency_group_master_binding.dart';
import '../modules/AgencyMaster/bindings/agency_master_binding.dart';
import '../modules/AsrunSpecificationAdRevenue/bindings/asrun_specification_ad_revenue_binding.dart';
import '../modules/BillTransfer/bindings/bill_transfer_binding.dart';
import '../modules/BillTransfer/views/bill_transfer_view.dart';
import '../modules/ClientEmbargo/bindings/client_embargo_binding.dart';
import '../modules/ClientMaster/bindings/client_master_binding.dart';
import '../modules/DealReport/bindings/deal_report_binding.dart';
import '../modules/EBillAgencyGroupMaster/bindings/e_bill_agency_group_master_binding.dart';
import '../modules/EBillsForBonusActivity/bindings/e_bills_for_bonus_activity_binding.dart';
import '../modules/EBillsForBonusActivity/views/e_bills_for_bonus_activity_view.dart';
import '../modules/GSTPlantInfo/bindings/g_s_t_plant_info_binding.dart';
import '../modules/GenerateBookingReport/bindings/generate_booking_report_binding.dart';
import '../modules/PlaceTypeMaster/bindings/place_type_master_binding.dart';
import '../modules/ROAudit/AuditBookings/views/audit_bookings_view.dart';
import '../modules/ROAudit/AuditCancellation/bindings/audit_cancellation_binding.dart';
import '../modules/ROAudit/AuditCancellation/views/audit_cancellation_view.dart';
import '../modules/ROAudit/AuditReschedule/bindings/audit_reschedule_binding.dart';
import '../modules/ROAudit/bindings/r_o_audit_binding.dart';
import '../modules/SAPBIllCheckReport/bindings/s_a_p_b_ill_check_report_binding.dart';
import '../modules/SecondaryAsrunModification/bindings/secondary_asrun_modification_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../providers/AuthGuard1.dart';

// import '../modules/AuditBookings/bindings/audit_bookings_binding.dart';
// import '../modules/AuditBookings/views/audit_bookings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = kReleaseMode
      ? Routes.HOME
      : ("${Routes.AGENCY_MASTER}?personalNo=CX5CP1oS3%2FepJloRhT%2F7JQ%3D%3D&loginCode=GhNK0fgJ1lghoL8cGVvoKg%3D%3D&formName=MIwQ7EMo0EfEHhtKQnpM9kezFFoojACI6t01pVYRjxg%3D");

  static final routes = [
    GetPage(
      name: _Paths.NO_FOUND,
      page: () => NoDataFoundPage(),
      // binding: OriginalRepeatMasterPageBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => AuthGuard(
        childName: _Paths.HOME,
      ),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ASRUN_IMPORT_SECONDARY_EVENTS,
      page: () => AuthGuard(childName: _Paths.ASRUN_IMPORT_SECONDARY_EVENTS),
      // binding: AsrunImportSecondaryEventsBinding(),
    ),
    GetPage(
      name: _Paths.COMPANY_CHANNEL_LINK,
      page: () => AuthGuard(childName: _Paths.COMPANY_CHANNEL_LINK),
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
      page: () => AuthGuard(
        childName: _Paths.CLIENT_MASTER,
      ),
      // page: () =>  ClientMasterView(),
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
      page: () => AuthGuard(childName: _Paths.E_BILLS_FOR_BONUS_ACTIVITY),
      // binding: EBillsForBonusActivityBinding(),
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
      name: _Paths.ASRUN_VERIFICATION,
      page: () => AuthGuard(childName: _Paths.ASRUN_VERIFICATION),
      // binding: AsrunVerificationBinding(),
    ),
    GetPage(
      name: _Paths.EBILLS,
      page: () => AuthGuard(childName: _Paths.EBILLS),
      // binding: EbillsBinding(),
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
      // page: () =>  DealReportView(),
      page: () => AuthGuard(childName: _Paths.DEAL_REPORT),
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
    GetPage(
        name: _Paths.PAYMENT_ROUTE_MASTER,
        page: () => AuthGuard(childName: _Paths.PAYMENT_ROUTE_MASTER)
        // binding: PaymentRouteMasterBinding(),
        ),
    GetPage(
        name: _Paths.AGENCY_EMBARGO,
        page: () => AuthGuard(childName: _Paths.AGENCY_EMBARGO)
        // binding: AgencyEmbargoBinding(),
        ),
    GetPage(
      name: _Paths.SPOTS_NOT_TELECASTED_REPORT,
      page: () => AuthGuard(childName: _Paths.SPOTS_NOT_TELECASTED_REPORT),
    ),
    GetPage(
      name: _Paths.VIEW_DEAL_CHANGE_HISTORY,
      page: () => AuthGuard(childName: _Paths.VIEW_DEAL_CHANGE_HISTORY),
    ),
    GetPage(
      name: _Paths.STATION_MASTER,
      page: () => AuthGuard(childName: _Paths.STATION_MASTER),
    ),
    GetPage(
      name: _Paths.PLACE_MASTER,
      page: () => AuthGuard(childName: _Paths.PLACE_MASTER),
    ),
    GetPage(
      name: _Paths.CURRENCY_TYPE_MASTER,
      page: () => AuthGuard(childName: _Paths.CURRENCY_TYPE_MASTER),
    ),
    GetPage(
      name: _Paths.EXPORT_BILLING_F_P_C,
      page: () => AuthGuard(childName: _Paths.EXPORT_BILLING_F_P_C),
    ),
    GetPage(
      name: _Paths.CLIENT_DEALS,
      page: () => AuthGuard(childName: _Paths.CLIENT_DEALS),
    ),
    GetPage(
      name: _Paths.SALES_EXECUTIVE_MASTER,
      page: () => AuthGuard(childName: _Paths.SALES_EXECUTIVE_MASTER),
      // binding: SalesExecutiveMasterBinding(),
    ),
    GetPage(
      name: _Paths.SAP_BILL_CHECK_REPORT,
      // page: () =>  SAPBIllCheckReportView(),
      page: () => AuthGuard(childName: _Paths.SAP_BILL_CHECK_REPORT),
      binding: SAPBIllCheckReportBinding(),
    ),
    GetPage(
      name: _Paths.GENERATE_BOOKING_REPORT,
      // page: () =>  GenerateBookingReportView(),
      page: () => AuthGuard(childName: _Paths.GENERATE_BOOKING_REPORT),
      binding: GenerateBookingReportBinding(),
    ),
    GetPage(
      name: _Paths.E_BILL_AGENCY_GROUP_MASTER,
      // page: () =>  EBillAgencyGroupMasterView(),
      page: () => AuthGuard(childName: _Paths.E_BILL_AGENCY_GROUP_MASTER),
      binding: EBillAgencyGroupMasterBinding(),
    ),
    GetPage(
      name: _Paths.ASRUN_SPECIFICATION_AD_REVENUE,
      // page: () => const AsrunSpecificationAdRevenueView(),
      page: () => AuthGuard(childName: _Paths.ASRUN_SPECIFICATION_AD_REVENUE),
      binding: AsrunSpecificationAdRevenueBinding(),
    ),
    GetPage(
      name: _Paths.BILL_EXPORT,
      page: () => AuthGuard(childName: _Paths.BILL_EXPORT),
    ),
    GetPage(
      name: _Paths.EMAIL_BILL_DETAILS,
      page: () => AuthGuard(childName: _Paths.EMAIL_BILL_DETAILS),
    ),
    GetPage(
      name: _Paths.TRAFFIC_ORDER_CORRECTION,
      page: () => AuthGuard(childName: _Paths.TRAFFIC_ORDER_CORRECTION),
    ),
    GetPage(
      name: _Paths.AUDIT_BOOKINGS,
      page: () => AuthGuard(childName: _Paths.AUDIT_BOOKINGS),
    ),
    GetPage(
      name: _Paths.AUDIT_RESCHEDULE,
      page: () => AuthGuard(childName: _Paths.AUDIT_RESCHEDULE),
      binding: AuditRescheduleBinding(),
    ),
    GetPage(
      name: _Paths.AUDIT_CANCELLATION,
      page: () => AuthGuard(childName: _Paths.AUDIT_CANCELLATION),
    ),
    GetPage(
      name: _Paths.BILL_TRANSFER,
      // page: () => const BillTransferView(),
      page: () => AuthGuard(childName: _Paths.BILL_TRANSFER),
      binding: BillTransferBinding(),
    ),
  ];
}
