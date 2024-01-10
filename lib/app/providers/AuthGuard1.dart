import 'package:bms_creditcontrol/app/controller/MainController.dart';
import 'package:bms_creditcontrol/app/modules/AgencyEmbargo/views/agency_embargo_view.dart';
import 'package:bms_creditcontrol/app/modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import 'package:bms_creditcontrol/app/modules/AsrunVerification/views/asrun_verification_view.dart';
import 'package:bms_creditcontrol/app/modules/ClientGroupMaster/views/client_group_master_view.dart';
import 'package:bms_creditcontrol/app/modules/ComboDealEntry/views/combo_deal_entry_view.dart';
import 'package:bms_creditcontrol/app/modules/Ebills/views/ebills_view.dart';
import 'package:bms_creditcontrol/app/modules/PaymentRouteMaster/views/payment_route_master_view.dart';
import 'package:bms_creditcontrol/app/modules/ReadytoBills/views/readyto_bills_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/LoadingScreen.dart';
import '../../widgets/NoDataFoundPage.dart';
import '../modules/ClearSecondarySpots/views/clear_secondary_spots_view.dart';
import '../modules/AgencyGroupMaster/views/agency_group_master_view.dart';
import '../modules/AgencyMaster/views/agency_master_view.dart';
import '../modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import '../modules/ClientEmbargo/views/client_embargo_view.dart';
import '../modules/GSTPlantInfo/views/g_s_t_plant_info_view.dart';
import '../modules/PlaceTypeMaster/views/place_type_master_view.dart';
import '../modules/ROAudit/views/r_o_audit_view.dart';
import '../modules/CompanyMaster/views/company_master_view.dart';
import '../modules/CreditRateMaster/views/credit_rate_master_view.dart';
import '../modules/InvoiceRevision/views/invoice_revision_view.dart';
import '../modules/PayrouteCategoryMaster/views/payroute_category_master_view.dart';
import '../modules/UndoCancelation/views/undo_cancelation_view.dart';
import '../modules/SecondaryAsrunModification/views/secondary_asrun_modification_view.dart';
import '../modules/home/views/home_view.dart';
import '../routes/app_pages.dart';

class AuthGuard extends StatelessWidget {
  final String childName;

  AuthGuard({required this.childName}) {
    assert(this.childName != null);
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
          switch (childName) {
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
              currentWidget = UndoCancelationView();
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
