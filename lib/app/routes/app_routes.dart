part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static List<String> listRoutes = [];
  static const ASRUN_IMPORT_SECONDARY_EVENTS =
      _Paths.ASRUN_IMPORT_SECONDARY_EVENTS;
  static const COMPANY_MASTER = _Paths.COMPANY_MASTER;
  static const COMBO_DEAL_ENTRY = _Paths.COMBO_DEAL_ENTRY;
  static const READYTO_BILLS = _Paths.READYTO_BILLS;
  static const INVOICE_REVISION = _Paths.INVOICE_REVISION;
  static const UNDO_CANCELATION = _Paths.UNDO_CANCELATION;
  static const CLEAR_SECONDARY_SPOTS = _Paths.CLEAR_SECONDARY_SPOTS;
  static const CLIENT_GROUP_MASTER = _Paths.CLIENT_GROUP_MASTER;
  static const CREDIT_RATE_MASTER = _Paths.CREDIT_RATE_MASTER;
  static const PAYROUTE_CATEGORY_MASTER = _Paths.PAYROUTE_CATEGORY_MASTER;
}

abstract class RoutesList {
  RoutesList._();

  static List<String> listRoutes = [
    // _Paths.HOME,
    _Paths.HOME,
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
  static const UNDO_CANCELATION = '/frmmovieupdate';
  static const CLEAR_SECONDARY_SPOTS = '/frmscrollmarking';
  static const CLIENT_GROUP_MASTER = '/frmClientGroupMaster';
  static const CREDIT_RATE_MASTER = '/frmCreditRateMaster';
  static const PAYROUTE_CATEGORY_MASTER = '/frmPayRouteCategoryMaster';
}
