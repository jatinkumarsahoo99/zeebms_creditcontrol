import 'package:bms_creditcontrol/app/controller/MainController.dart';
import 'package:bms_creditcontrol/app/modules/AgencyEmbargo/views/agency_embargo_view.dart';
import 'package:bms_creditcontrol/app/modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import 'package:bms_creditcontrol/app/modules/AsrunVerification/views/asrun_verification_view.dart';
import 'package:bms_creditcontrol/app/modules/ClientGroupMaster/views/client_group_master_view.dart';
import 'package:bms_creditcontrol/app/modules/ComboDealEntry/views/combo_deal_entry_view.dart';
import 'package:bms_creditcontrol/app/modules/Ebills/views/ebills_view.dart';
import 'package:bms_creditcontrol/app/modules/EmailBillDetails/views/email_bill_details_view.dart';
import 'package:bms_creditcontrol/app/modules/PaymentRouteMaster/views/payment_route_master_view.dart';
import 'package:bms_creditcontrol/app/modules/ReadytoBills/views/readyto_bills_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/LoadingScreen.dart';
import '../../widgets/NoDataFoundPage.dart';
import '../modules/BillExport/views/bill_export_view.dart';
import '../modules/AsrunSpecificationAdRevenue/views/asrun_specification_ad_revenue_view.dart';
import '../modules/ClearSecondarySpots/views/clear_secondary_spots_view.dart';
import '../modules/AgencyGroupMaster/views/agency_group_master_view.dart';
import '../modules/AgencyMaster/views/agency_master_view.dart';
import '../modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import '../modules/ClientDeals/views/client_deals_view.dart';
import '../modules/ClientEmbargo/views/client_embargo_view.dart';
import '../modules/ClientMaster/views/client_master_view.dart';
import '../modules/CompanyChannelLink/views/company_channel_link_view.dart';
import '../modules/DealReport/views/deal_report_view.dart';
import '../modules/CurrencyTypeMaster/views/currency_type_master_view.dart';
import '../modules/EBillAgencyGroupMaster/views/e_bill_agency_group_master_view.dart';
import '../modules/ExportBillingFPC/views/export_billing_f_p_c_view.dart';
import '../modules/GSTPlantInfo/views/g_s_t_plant_info_view.dart';
import '../modules/GenerateBookingReport/bindings/generate_booking_report_binding.dart';
import '../modules/GenerateBookingReport/views/generate_booking_report_view.dart';
import '../modules/MovieUpdate/views/movie_update_view.dart';
import '../modules/PlaceMaster/views/place_master_view.dart';
import '../modules/PlaceTypeMaster/views/place_type_master_view.dart';
import '../modules/ROAudit/views/r_o_audit_view.dart';
import '../modules/CompanyMaster/views/company_master_view.dart';
import '../modules/CreditRateMaster/views/credit_rate_master_view.dart';
import '../modules/InvoiceRevision/views/invoice_revision_view.dart';
import '../modules/PayrouteCategoryMaster/views/payroute_category_master_view.dart';
import '../modules/SAPBIllCheckReport/views/s_a_p_b_ill_check_report_view.dart';
import '../modules/SalesExecutiveMaster/views/sales_executive_master_view.dart';
import '../modules/SpotsNotTelecastedReport/views/spots_not_telecasted_report_view.dart';
import '../modules/StationMaster/views/station_master_view.dart';
import '../modules/TrafficOrderCorrection/views/traffic_order_correction_view.dart';
import '../modules/UndoCancelation/views/undo_cancelation_view.dart';
import '../modules/SecondaryAsrunModification/views/secondary_asrun_modification_view.dart';
import '../modules/ViewDealChangeHistory/views/view_deal_change_history_view.dart';
import '../modules/home/views/home_view.dart';
import '../routes/app_pages.dart';
import 'dart:html' as w;
class AuthGuard extends StatefulWidget {
  final String childName;

  AuthGuard({required this.childName}) {
    assert(this.childName != null);
  }

  @override
  State<AuthGuard> createState() => _AuthGuard1State();
}

class _AuthGuard1State extends State<AuthGuard> with WidgetsBindingObserver {
  @override
  void initState() {
    print("Auth guard init");
    super.initState();
    if (kIsWeb) {
      w.window.addEventListener('focus', onFocus);
      w.window.addEventListener('blur', onBlur);
    } else {
      WidgetsBinding.instance.addObserver(this);
    }
  }

  @override
  void dispose() {
    print("Auth guard dispose");
    if (kIsWeb) {
      w.window.removeEventListener('focus', onFocus);
      w.window.removeEventListener('blur', onBlur);
    } else {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  void onFocus(w.Event e) {
    didChangeAppLifecycleState(AppLifecycleState.resumed);
  }

  void onBlur(w.Event e) {
    didChangeAppLifecycleState(AppLifecycleState.paused);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      // --
        print('Resumed');
        FocusScope.of(Get.context!).unfocus();

        break;
      case AppLifecycleState.inactive:
      // --
        print('Inactive');
        break;
      case AppLifecycleState.paused:
      // --
        print('Paused');
        FocusScope.of(Get.context!).unfocus();
        break;
      case AppLifecycleState.detached:
      // --
        print('Detached');
        break;
    }
  }

  Widget? currentWidget;

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      init: Get.find<MainController>(),
      // init: MainController(),
      initState: (c) {
        // Get.find<MainController>().checkSession2();
        Get.find<MainController>().checkSessionFromParams();
      },
      builder: (controller) {
        print("Login value>>" + controller.loginVal.value.toString());
        if (controller.loginVal.value == 1) {
          switch (widget.childName) {
            case Routes.HOME:
              currentWidget = HomeView();
              break;
            case Routes.ASRUN_IMPORT_SECONDARY_EVENTS:
              currentWidget = AsrunImportSecondaryEventsView();
              break;
            case Routes.COMPANY_MASTER:
              currentWidget = CompanyMasterView();
              break;
            case Routes.INVOICE_REVISION:
              currentWidget = InvoiceRevisionView();
              break;

            case Routes.COMBO_DEAL_ENTRY:
              currentWidget = ComboDealEntryView();
              break;
            case Routes.READYTO_BILLS:
              currentWidget = ReadytoBillsView();
              break;
            case Routes.ASRUN_VERIFICATION:
              currentWidget = AsrunVerificationView();
              break;
            case Routes.EBILLS:
              currentWidget = EbillsView();
              break;

            case Routes.UNDO_CANCELATION:
              currentWidget = MovieUpdateView();
              break;
            case Routes.CLEAR_SECONDARY_SPOTS:
              currentWidget = ClearSecondarySpotsView();
              break;
            case Routes.CLIENT_GROUP_MASTER:
              currentWidget = ClientGroupMasterView();
              break;
            case Routes.CREDIT_RATE_MASTER:
              currentWidget = CreditRateMasterView();
              break;
            case Routes.PAYROUTE_CATEGORY_MASTER:
              currentWidget = PayrouteCategoryMasterView();
              break;

            case Routes.ASRUN_IMPORT_SECONDARY_EVENTS:
              currentWidget = AsrunImportSecondaryEventsView();
              break;
            case Routes.R_O_AUDIT:
              currentWidget = ROAuditView();
              break;
            case Routes.DEAL_REPORT:
              currentWidget = DealReportView();
              break;
            case Routes.AGENCY_MASTER:
              currentWidget = AgencyMasterView();
              break;
            case Routes.CLIENT_EMBARGO:
              currentWidget = ClientEmbargoView();
              break;
            case Routes.SECONDARY_ASRUN_MODIFICATION:
              currentWidget = SecondaryAsrunModificationView();
              break;
            case Routes.AGENCY_GROUP_MASTER:
              currentWidget = AgencyGroupMasterView();
              break;
            case Routes.G_S_T_PLANT_INFO:
              currentWidget = GSTPlantInfoView();
              break;
            case Routes.PLACE_TYPE_MASTER:
              currentWidget = PlaceTypeMasterView();
              break;
            case Routes.PAYMENT_ROUTE_MASTER:
              currentWidget = PaymentRouteMasterView();
              break;
            case Routes.AGENCY_EMBARGO:
              currentWidget = AgencyEmbargoView();
              break;

            case Routes.SPOTS_NOT_TELECASTED_REPORT:
              currentWidget = SpotsNotTelecastedReportView();
              break;
            case Routes.VIEW_DEAL_CHANGE_HISTORY:
              currentWidget = ViewDealChangeHistoryView();
              break;
            case Routes.CLIENT_MASTER:
              currentWidget = ClientMasterView();
              break;
            case Routes.STATION_MASTER:
              currentWidget = StationMasterView();
              break;
            case Routes.PLACE_MASTER:
              currentWidget = PlaceMasterView();
              break;
            case Routes.CURRENCY_TYPE_MASTER:
              currentWidget = CurrencyTypeMasterView();
              break;
            case Routes.EXPORT_BILLING_F_P_C:
              currentWidget = ExportBillingFPCView();
              break;
            case Routes.CLIENT_DEALS:
              currentWidget = ClientDealsView();
              break;
            case Routes.S_A_P_B_ILL_CHECK_REPORT:
              currentWidget = SAPBIllCheckReportView();
              break;
            case Routes.GENERATE_BOOKING_REPORT:
              currentWidget = GenerateBookingReportView();
              break;
            case Routes.E_BILL_AGENCY_GROUP_MASTER:
              currentWidget = EBillAgencyGroupMasterView();
              break;
            case Routes.ASRUN_SPECIFICATION_AD_REVENUE:
              currentWidget = AsrunSpecificationAdRevenueView();
              break;
            case Routes.COMPANY_CHANNEL_LINK:
              currentWidget = CompanyChannelLinkView();
              break;
            case Routes.TRAFFIC_ORDER_CORRECTION:
              currentWidget = TrafficOrderCorrectionView();
              break;
            case Routes.BILL_EXPORT:
              currentWidget = BillExportView();
              break;
            case Routes.SALES_EXECUTIVE_MASTER:
              currentWidget = SalesExecutiveMasterView();
              break;
            case Routes.EMAIL_BILL_DETAILS:
              currentWidget = EmailBillDetailsView();
              break;
            default:
              currentWidget = const NoDataFoundPage();
          }
          // currentWidget = child;
        } else if (controller.loginVal.value == 2) {
          currentWidget = const NoDataFoundPage();
        } else {
          currentWidget = const LoadingScreen();
        }
        return currentWidget!;
      },
    );
  }
}
//
// class AuthGuard extends StatelessWidget {
//   final String childName;
//
//   AuthGuard({required this.childName}) {
//     assert(this.childName != null);
//   }
//
//   Widget? currentWidget;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetX<MainController>(
//       init: Get.find<MainController>(),
//       // init: MainController(),
//       initState: (c) {
//         // Get.find<MainController>().checkSession2();
//         Get.find<MainController>().checkSessionFromParams();
//       },
//       builder: (controller) {
//         print("Login value>>" + controller.loginVal.value.toString());
//         if (controller.loginVal.value == 1) {
//           switch (childName) {
//             case Routes.HOME:
//               currentWidget = HomeView();
//               break;
//             case Routes.ASRUN_IMPORT_SECONDARY_EVENTS:
//               currentWidget = AsrunImportSecondaryEventsView();
//               break;
//             case Routes.COMPANY_MASTER:
//               currentWidget = CompanyMasterView();
//               break;
//             case Routes.INVOICE_REVISION:
//               currentWidget = InvoiceRevisionView();
//               break;
//
//             case Routes.COMBO_DEAL_ENTRY:
//               currentWidget = ComboDealEntryView();
//               break;
//             case Routes.READYTO_BILLS:
//               currentWidget = ReadytoBillsView();
//               break;
//             case Routes.ASRUN_VERIFICATION:
//               currentWidget = AsrunVerificationView();
//               break;
//             case Routes.EBILLS:
//               currentWidget = EbillsView();
//               break;
//
//             case Routes.UNDO_CANCELATION:
//               currentWidget = MovieUpdateView();
//               break;
//             case Routes.CLEAR_SECONDARY_SPOTS:
//               currentWidget = ClearSecondarySpotsView();
//               break;
//             case Routes.CLIENT_GROUP_MASTER:
//               currentWidget = ClientGroupMasterView();
//               break;
//             case Routes.CREDIT_RATE_MASTER:
//               currentWidget = CreditRateMasterView();
//               break;
//             case Routes.PAYROUTE_CATEGORY_MASTER:
//               currentWidget = PayrouteCategoryMasterView();
//               break;
//
//             case Routes.ASRUN_IMPORT_SECONDARY_EVENTS:
//               currentWidget = AsrunImportSecondaryEventsView();
//               break;
//             case Routes.R_O_AUDIT:
//               currentWidget = ROAuditView();
//               break;
//             case Routes.DEAL_REPORT:
//               currentWidget = DealReportView();
//               break;
//             case Routes.AGENCY_MASTER:
//               currentWidget = AgencyMasterView();
//               break;
//             case Routes.CLIENT_EMBARGO:
//               currentWidget = ClientEmbargoView();
//               break;
//             case Routes.SECONDARY_ASRUN_MODIFICATION:
//               currentWidget = SecondaryAsrunModificationView();
//               break;
//             case Routes.AGENCY_GROUP_MASTER:
//               currentWidget = AgencyGroupMasterView();
//               break;
//             case Routes.G_S_T_PLANT_INFO:
//               currentWidget = GSTPlantInfoView();
//               break;
//             case Routes.PLACE_TYPE_MASTER:
//               currentWidget = PlaceTypeMasterView();
//               break;
//             case Routes.PAYMENT_ROUTE_MASTER:
//               currentWidget = PaymentRouteMasterView();
//               break;
//             case Routes.AGENCY_EMBARGO:
//               currentWidget = AgencyEmbargoView();
//               break;
//
//             case Routes.SPOTS_NOT_TELECASTED_REPORT:
//               currentWidget = SpotsNotTelecastedReportView();
//               break;
//             case Routes.VIEW_DEAL_CHANGE_HISTORY:
//               currentWidget = ViewDealChangeHistoryView();
//               break;
//             case Routes.CLIENT_MASTER:
//               currentWidget = ClientMasterView();
//               break;
//             case Routes.STATION_MASTER:
//               currentWidget = StationMasterView();
//               break;
//             case Routes.PLACE_MASTER:
//               currentWidget = PlaceMasterView();
//               break;
//             case Routes.CURRENCY_TYPE_MASTER:
//               currentWidget = CurrencyTypeMasterView();
//               break;
//             case Routes.EXPORT_BILLING_F_P_C:
//               currentWidget = ExportBillingFPCView();
//               break;
//             case Routes.CLIENT_DEALS:
//               currentWidget = ClientDealsView();
//               break;
//             default:
//               currentWidget = const NoDataFoundPage();
//           }
//           // currentWidget = child;
//         } else if (controller.loginVal.value == 2) {
//           currentWidget = const NoDataFoundPage();
//         } else {
//           currentWidget = const LoadingScreen();
//         }
//         return currentWidget!;
//       },
//     );
//   }
// }
