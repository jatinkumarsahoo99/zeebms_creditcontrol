import 'package:bms_creditcontrol/app/controller/MainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/LoadingScreen.dart';
import '../../widgets/NoDataFoundPage.dart';
import '../modules/AgencyMaster/views/agency_master_view.dart';
import '../modules/AsrunImportSecondaryEvents/views/asrun_import_secondary_events_view.dart';
import '../modules/ClientEmbargo/views/client_embargo_view.dart';
import '../modules/ROAudit/views/r_o_audit_view.dart';
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
              currentWidget = const AsrunImportSecondaryEventsView();
              break;
            case Routes.R_O_AUDIT:
              currentWidget =  ROAuditView();
              break;
            case Routes.AGENCY_MASTER:
              currentWidget =  AgencyMasterView();
              break;
            case Routes.CLIENT_EMBARGO:
              currentWidget =  ClientEmbargoView();
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
