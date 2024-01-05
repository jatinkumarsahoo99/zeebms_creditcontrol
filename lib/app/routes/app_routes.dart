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
  static const CLIENT_MASTER = '/client-master';
  static const R_O_AUDIT = '/frmAuditStatus';
  static const AGENCY_MASTER = '/frmAgencyMaster';
  static const CLIENT_EMBARGO = '/frmClientEmbargo';
  static const E_BILLS_FOR_BONUS_ACTIVITY = '/e-bills-for-bonus-activity';
  static const SECONDARY_ASRUN_MODIFICATION = '/secondary-asrun-modification';
}
