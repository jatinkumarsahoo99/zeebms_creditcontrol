part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static List<String> listRoutes = [];
  static const ASRUN_IMPORT_SECONDARY_EVENTS =
      _Paths.ASRUN_IMPORT_SECONDARY_EVENTS;
  static const COMBO_DEAL_ENTRY = _Paths.COMBO_DEAL_ENTRY;
  static const READYTO_BILLS = _Paths.READYTO_BILLS;
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
  static const COMBO_DEAL_ENTRY = '/frmLinkDeal';
  static const READYTO_BILLS = '/frmSetReadyToBill';
}
