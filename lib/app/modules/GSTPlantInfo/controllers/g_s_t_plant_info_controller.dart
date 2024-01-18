import 'package:get/get.dart';

import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../../widgets/PlutoGrid/src/model/pluto_cell.dart';
import '../../../../widgets/PlutoGrid/src/model/pluto_row.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';
import '../GSTPlantInfoModel.dart';

class GSTPlantInfoController extends GetxController {
  //TODO: Implement GSTPlantInfoController

  final count = 0.obs;
  GSTPlantInfoModel? gstPlantInfoModel = GSTPlantInfoModel(load: []);

  PlutoGridStateManager? stateManager;
  List<Map<String, Map<String, double>>>? userGridSetting1 = [];

  fetchUserSetting1() async {
    userGridSetting1 = await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    fetchUserSetting1();
    super.onInit();
  }

  getData() {
    LoadingDialog.call();
    try {
      Get.find<ConnectorControl>().GETMETHODCALL(
          api: ApiFactory.GST_PLANT_INFO_LOAD,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if (map is Map && map['load'] != null && map['load'].length > 0) {
              gstPlantInfoModel =
                  GSTPlantInfoModel.fromJson(map as Map<String, dynamic>);
              update(["grid"]);
            } else {
              gstPlantInfoModel = GSTPlantInfoModel(load: []);
              update(["grid"]);
            }
          },
          failed: (map) {
            closeDialogIfOpen();
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  save() {
    try {
      LoadingDialog.call();
      Map<String, dynamic> postData = {"lstdt": getDataFromGrid1(stateManager)};

      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.GST_PLANT_INFO_SAVE,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['save'] != null && map['save'].length >0){
              clearAll();
            }
          },
          failed: (map) {
            closeDialogIfOpen();
            LoadingDialog.showErrorDialog(map.toString());
          });
    } catch (e) {
      closeDialogIfOpen();
    }
  }

  List<Map<String, dynamic>> getDataFromGrid1(
      PlutoGridStateManager? statemanager) {
    if (statemanager != null) {
      statemanager.setFilter((element) => true);
      statemanager.notifyListeners();
      List<PlutoRow> myList = statemanager.rows;
      // filerStateManagerData(statemanager);
      List<Map<String, dynamic>> mapList = [];
      // print("rows_length: "+myList.length.toString());
      // print("rows_length1: "+statemanager.filterRows.length.toString());
      for (var row in myList) {
        Map<String, dynamic> rowMap = {};
        for (var key in row.cells.keys) {
          rowMap[key] = row.cells[key]?.value ?? "";
        }
        mapList.add(rowMap);
      }
      return mapList;
    } else {
      return [];
    }
  }

  clearAll() {
    Get.delete<GSTPlantInfoController>();
    Get.find<HomeController>().clearPage1();
  }

  add() {
    if (stateManager != null) {
      int index = (stateManager?.rows.length ?? 1);
      print(">>>>>>>>index$index");
      stateManager?.insertRows(index, [
        PlutoRow(cells: {
          "plantID": PlutoCell(value: 0),
          "plantCode": PlutoCell(value: ""),
          "plantName": PlutoCell(value: ""),
          "plantName2": PlutoCell(value: ""),
          "coCode": PlutoCell(value: ""),
          "companyName": PlutoCell(value: ""),
          "houseNumberAndStreet": PlutoCell(value: ""),
          "postalCode": PlutoCell(value: ""),
          "city": PlutoCell(value: ""),
          "countryKey": PlutoCell(value: ""),
          "countryName": PlutoCell(value: ""),
          "region": PlutoCell(value: ""),
          "regionDescription": PlutoCell(value: ""),
          "no": PlutoCell(value: (index+1).toString()),
        })
      ]);
      stateManager?.notifyListeners();
    } else {
      gstPlantInfoModel?.load?.add(Load(
          plantID: 0,
          city: "",
          coCode: "",
          companyName: "",
          countryKey: "",
          countryName: "",
          houseNumberAndStreet: "",
          plantCode: "",
          plantName2: "",
          plantName: "",
          postalCode: "",
          region: "",
          regionDescription: ""));
      update(['grid']);
    }
  }

  remove() {
    if (stateManager != null) {
      if ((stateManager?.rows[stateManager?.currentRowIdx ?? 0].cells['plantID']
                      ?.value ??
                  "0")
              .toString() ==
          "0") {
        stateManager?.removeCurrentRow();
        stateManager?.notifyListeners();
      }
    }
  }

  formHandler(String text) {
    if (text == 'Exit') {
      Get.find<HomeController>().postUserGridSetting1(
          listStateManager: [stateManager], tableNamesList: ['tbl1']);
    } else if (text == "Save") {
      save();
    } else if (text == "Clear") {
      clearAll();
    }
  }

  void increment() => count.value++;
}
