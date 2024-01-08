import 'package:bms_creditcontrol/app/controller/MainController.dart';
import 'package:bms_creditcontrol/app/modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import 'package:bms_creditcontrol/app/modules/ComboDealEntry/views/combo_deal_entry_view.dart';
import 'package:bms_creditcontrol/app/modules/ReadytoBills/views/readyto_bills_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/LoadingScreen.dart';
import '../../widgets/NoDataFoundPage.dart';
import '../modules/AgencyGroupMaster/views/agency_group_master_view.dart';
import '../modules/AgencyMaster/views/agency_master_view.dart';
import '../modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import '../modules/ClientEmbargo/views/client_embargo_view.dart';
import '../modules/ClientMaster/views/client_master_view.dart';
import '../modules/DealReport/views/deal_report_view.dart';
import '../modules/GSTPlantInfo/views/g_s_t_plant_info_view.dart';
import '../modules/PlaceTypeMaster/views/place_type_master_view.dart';
import '../modules/ROAudit/views/r_o_audit_view.dart';
import '../modules/CompanyMaster/views/company_master_view.dart';
import '../modules/InvoiceRevision/views/invoice_revision_view.dart';
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
            case Routes.ASRUN_IMPORT_SECONDARY_EVENTS:
              currentWidget =  AsrunImportSecondaryEventsView();
              break;
            case Routes.R_O_AUDIT:
              currentWidget =  ROAuditView();
              break;
            case Routes.DEAL_REPORT:
              currentWidget =  DealReportView();
              break;
            case Routes.AGENCY_MASTER:
              currentWidget =  AgencyMasterView();
              break;
            case Routes.CLIENT_EMBARGO:
              currentWidget =  ClientEmbargoView();
              break;
            case Routes.SECONDARY_ASRUN_MODIFICATION:
              currentWidget =  SecondaryAsrunModificationView();
              break;
            case Routes.AGENCY_GROUP_MASTER:
              currentWidget =  AgencyGroupMasterView();
              break;
            case Routes.G_S_T_PLANT_INFO:
              currentWidget =  GSTPlantInfoView();
              break;
            case Routes.PLACE_TYPE_MASTER:
              currentWidget =  PlaceTypeMasterView();
              break;
            case Routes.CLIENT_MASTER:
              currentWidget =  ClientMasterView();
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
