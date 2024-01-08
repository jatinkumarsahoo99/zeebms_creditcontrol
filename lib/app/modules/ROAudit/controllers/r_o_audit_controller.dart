import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/PlutoGrid/pluto_grid.dart';
import '../../../data/DropDownValue.dart';

class ROAuditController extends GetxController {
  //TODO: Implement ROAuditController

  Rx<bool> isEnable = Rx<bool>(true);
  final count = 0.obs;
  RxList<DropDownValue> progTypeList = RxList([]);
  RxList<DropDownValue> bmsVersionList = RxList([]);
  RxList<DropDownValue> matchList = RxList([]);

  DropDownValue? selectedProgTypeList;
  DropDownValue? selectedBMSVersionList;
  DropDownValue? selectedMatchList;

  PlutoGridStateManager? stateManager;
  Map<String, dynamic> responseData = {'report': []};

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  List<Map<String,Map<String, double>>>? userGridSetting1;

  Rx<bool>additionClick = Rx<bool>(false);

  Color backColor = const Color(0xFFE7ECEF);
  Rx<double> blur = Rx<double>(30);
  Rx<Offset> distance = Rx<Offset>( Offset(10,10));
  Rx<int> selectedInt = Rx<int>(0);
  formHandler(String string) {

  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
