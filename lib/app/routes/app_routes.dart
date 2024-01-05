part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static List<String> listRoutes = [];
  static const ASRUN_IMPORT_SECONDARY_EVENTS =
      _Paths.ASRUN_IMPORT_SECONDARY_EVENTS;
  static const CLIENT_MASTER = _Paths.CLIENT_MASTER;
  static const R_O_AUDIT = _Paths.R_O_AUDIT;
  static const AGENCY_MASTER = _Paths.AGENCY_MASTER;
  static const CLIENT_EMBARGO = _Paths.CLIENT_EMBARGO;
  static const E_BILLS_FOR_BONUS_ACTIVITY = _Paths.E_BILLS_FOR_BONUS_ACTIVITY;
  static const SECONDARY_ASRUN_MODIFICATION =
      _Paths.SECONDARY_ASRUN_MODIFICATION;
  static const COMPANY_MASTER = _Paths.COMPANY_MASTER;
  static const COMBO_DEAL_ENTRY = _Paths.COMBO_DEAL_ENTRY;
  static const READYTO_BILLS = _Paths.READYTO_BILLS;
  static const INVOICE_REVISION = _Paths.INVOICE_REVISION;
  static const AGENCY_GROUP_MASTER = _Paths.AGENCY_GROUP_MASTER;
  static const DEAL_REPORT = _Paths.DEAL_REPORT;
  static const G_S_T_PLANT_INFO = _Paths.G_S_T_PLANT_INFO;
  static const PLACE_TYPE_MASTER = _Paths.PLACE_TYPE_MASTER;
}

abstract class RoutesList {
  RoutesList._();

  static List<String> listRoutes = [
    // _Paths.HOME,
    _Paths.HOME,
    _Paths.R_O_AUDIT,
    _Paths.AGENCY_MASTER,
    _Paths.CLIENT_EMBARGO,
  ];
}

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const ASRUN_IMPORT_SECONDARY_EVENTS = '/frmSecondaryAsRunImport';
  static const COMPANY_MASTER = '/frmCompanyMaster';
  static const COMBO_DEAL_ENTRY = '/frmLinkDeal';
  static const READYTO_BILLS = '/frmSetReadyToBill';
  static const INVOICE_REVISION = '/frmBillRevision';
  static const CLIENT_MASTER = '/client-master';
  static const R_O_AUDIT = '/frmAuditStatus';
  static const AGENCY_MASTER = '/frmAgencyMaster';
  static const CLIENT_EMBARGO = '/frmClientEmbargo';
  static const E_BILLS_FOR_BONUS_ACTIVITY = '/e-bills-for-bonus-activity';
  static const SECONDARY_ASRUN_MODIFICATION = '/frmSecondaryAsRunModification';
  static const AGENCY_GROUP_MASTER = '/frmAgencyGroupMaster';
  static const DEAL_REPORT = '/deal-report';
  static const G_S_T_PLANT_INFO = '/frmGstPlantInfo';
  static const PLACE_TYPE_MASTER = '/frmPlaceTypeMaster';
}
