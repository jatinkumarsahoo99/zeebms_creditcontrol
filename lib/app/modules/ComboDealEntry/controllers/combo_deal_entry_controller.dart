import 'package:bms_creditcontrol/app/controller/ConnectorControl.dart';
import 'package:bms_creditcontrol/app/controller/HomeController.dart';
import 'package:bms_creditcontrol/app/controller/MainController.dart';
import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:bms_creditcontrol/app/data/rowfilter.dart';
import 'package:bms_creditcontrol/app/modules/ComboDealEntry/bindings/group_number_leave_model.dart';
import 'package:bms_creditcontrol/app/modules/ComboDealEntry/bindings/tabel_deal_model.dart';
import 'package:bms_creditcontrol/app/modules/ComboDealEntry/bindings/tabel_link_deal_model.dart';
import 'package:bms_creditcontrol/app/modules/CommonDocs/controllers/common_docs_controller.dart';
import 'package:bms_creditcontrol/app/modules/CommonDocs/views/common_docs_view.dart';
import 'package:bms_creditcontrol/app/modules/CommonSearch/views/common_search_view.dart';
import 'package:bms_creditcontrol/app/providers/ApiFactory.dart';
import 'package:bms_creditcontrol/widgets/LoadingDialog.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/model/pluto_row.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/src/pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ComboDealEntryController extends GetxController {
  TextEditingController groupNo = TextEditingController(text: '0'),
      date = TextEditingController();

  var isShow = false.obs;
  var lastSelectedIdx = 0;
  var isAllEnabels = true.obs;
  var isAgencyEnabels = true.obs;

  var dealCode = '0';

  PlutoGridStateManager? tabelDealGrid;
  PlutoGridStateManager? tabelLinkDealGrid;

  TabelDealModel? tabelDealModel;
  TabelLinkDealModel? tabelLinkDealModel;
  GroupNumberLeave? groupNumberLeave;

  var tabelDealList = [].obs;
  var tabelLinkDealList = [].obs;
  var tempList = [].obs;
  var stopLoop = true.obs;

  var agency = RxList<DropDownValue>();

  Rxn<DropDownValue> selectClient = Rxn<DropDownValue>(),
      selectAgency = Rxn<DropDownValue>();

  FocusNode agencyFN = FocusNode(),
      clientFN = FocusNode(),
      showSelectedFN = FocusNode(),
      groupNoFN = FocusNode(),
      tabelDealFN = FocusNode();

  Rxn<List<Map<String, Map<String, double>>>>? userGridSetting1 = Rxn([]);
  fetchUserSetting1() async {
    userGridSetting1?.value =
        await Get.find<HomeController>().fetchUserSetting1();
    update(["grid"]);
  }

  @override
  void onInit() {
    super.onInit();
    // groupNoFN.addListener(() {
    //   if (groupNoFN.hasFocus) {
    //     print('TextField gained focus');
    //   } else {
    //     print('TextField lost focus');
    //     groupNoLeave(groupNo.text);
    //   }
    // });
    groupNoFN = FocusNode(
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.tab) {
          groupNoLeave(groupNo.text);
          return KeyEventResult.ignored;
        }
        return KeyEventResult.ignored;
      },
    );
    // agencyFN = FocusNode(
    //   onKeyEvent: (node, event) {
    //     if (event.logicalKey == LogicalKeyboardKey.tab) {
    //       getAgencyLeave(selectClient.value?.key ?? "",
    //           selectAgency.value?.key ?? "", date.text);
    //       return KeyEventResult.ignored;
    //     }
    //     return KeyEventResult.ignored;
    //   },
    // );
    fetchUserSetting1();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getAgency(clientCode) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMBO_DEAL_ENTRY_GET_AGENCY(clientCode),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('lstAgency')) {
            agency.clear();
            map['lstAgency'].forEach((e) {
              agency.add(DropDownValue(
                key: e['agencyCode'],
                value: e['agencyName'],
              ));
            });
            selectAgency.value =
                DropDownValue(key: agency[0].key, value: agency[0].value);
          }
        });
  }

  getAgencyLeave(clientCode, agencyCode, groupdate) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMBO_DEAL_ENTRY_GET_AGENCY_LEAVE(
            clientCode, agencyCode, groupdate),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('lstDeals')) {
            tabelDealModel =
                TabelDealModel.fromJson(map as Map<String, dynamic>);
            tabelDealList.value = tabelDealModel?.lstDeals?.lstdealrecord ?? [];
            isAllEnabels.value = false;
            isAgencyEnabels.value = false;
            tabelDealFN.requestFocus();
          }
        });
  }

  getDealContent(dealcode, locationcode, channelcode, dealnumber) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMBO_DEAL_ENTRY_GET_DEALS_CONTENT_CLICK(
            dealcode, locationcode, channelcode, dealnumber),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('linkedDeals')) {
            // tabelLinkDealModel =
            //     TabelLinkDealModel.fromJson(map as Map<String, dynamic>);
            tempList.value = map['linkedDeals']['lstTblLinkDeal'];
            tabelLinkDealList.addAll(tempList.value);
          }
        });
  }

  groupNoLeave(groupNumber) {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMBO_DEAL_ENTRY_GROUP_NUMBER_LEAVE(
          groupNumber,
        ),
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('cdeRecord')) {
            groupNumberLeave =
                GroupNumberLeave.fromJson(map as Map<String, dynamic>);

            // Deal Code
            dealCode = groupNumberLeave?.cdeRecord?.lstLinkeddeal?[0].dealcode
                    .toString() ??
                "";
            //Group Number
            groupNo.text = groupNumberLeave
                    ?.cdeRecord?.lstLinkeddeal?[0].groupNumber
                    .toString() ??
                "";
            //Date
            date.text = dateConvertToddMMyyyy(
                groupNumberLeave?.cdeRecord?.lstLinkeddeal?[0].groupdate ?? "");
            //Agency
            groupNumberLeave!.cdeRecord!.lstAgency!.forEach((e) {
              agency.add(DropDownValue(key: e.agencyCode, value: e.agencyName));
            });
            selectAgency.value = agency.firstWhereOrNull((e) {
              var result = e.key ==
                  groupNumberLeave!.cdeRecord!.lstLinkeddeal![0].agencyCode;
              return result;
            });

            //Tabel Deal
            tabelDealList.value = groupNumberLeave?.cdeRecord?.lstTbldeal ?? [];
            //Tabel Link Deal
            tabelLinkDealList.value = map['cdeRecord']['lsttblLinkedDeals'];
            //Client
            clientSearch(
                groupNumberLeave!.cdeRecord!.lstLinkeddeal![0].clientName);
          }
        });
  }

  Future<void> clientSearch(searchText) async {
    LoadingDialog.call();
    await Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.COMBO_DEAL_ENTRY_SEARCH_CLIENT1(searchText),
        fun: (map) {
          Get.back();
          if (map != null) {
            selectClient.value = DropDownValue(
                key: map[0]['ClientCode'], value: map[0]['ClientName']);
            isAllEnabels.value = false;
            agencyFN.requestFocus();
          }
        });
  }

  checkSave() async {
    if (tabelLinkDealList.isNotEmpty) {
      stopLoop.value = true;
      for (var i = 0; i < tabelLinkDealList.length && stopLoop.value; i++) {
        if (tabelLinkDealList[i]["groupValuationRate"] == 0) {
          tabelLinkDealGrid!.setCurrentCell(
            tabelLinkDealGrid!.getRowByIdx(i)?.cells['groupValuationRate'],
            i,
            notify: true,
          );
          await LoadingDialog.modify1(
              "Group Valuation Rate is 0\nDo you want to proceed with the save?",
              () {
            //yes
          }, () {
            //no
            stopLoop.value = false;
            Get.back();
          }, cancelTitle: "NO", deleteTitle: "Yes");
        }
      }
      if (stopLoop.value == true) {
        saveRecord();
      }
    }
  }

  saveRecord() {
    var payload = {
      "lstTblLinkDeals": tabelLinkDealList,
      "dealcode": dealCode,
      "groupNumber": groupNo.text,
      "clientCode": selectClient.value?.key ?? "",
      "agencyCode": selectAgency.value?.key ?? "",
      "groupdate": date.text,
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.COMBO_DEAL_ENTRY_SAVE_RECORD,
        json: payload,
        fun: (Map map) {
          Get.back();
          if (map != null && map.containsKey('message')) {
            LoadingDialog.callDataSaved(
                msg: map['message'],
                callback: () {
                  Get.back();
                });
          }
        });
  }

  handleOnCheckBoxChangeInward(PlutoGridOnChangedEvent event) {
    lastSelectedIdx = tabelDealGrid?.refRows[event.rowIdx ?? 0].sortIdx ?? 0;
    if (event.columnIdx == 1) {
      tabelDealList[lastSelectedIdx].selected = (event.value == "true");
      if (tabelDealList[lastSelectedIdx].selected == true) {
        getDealContent(
          "0",
          tabelDealList[lastSelectedIdx].locationcode,
          tabelDealList[lastSelectedIdx].channelcode,
          tabelDealList[lastSelectedIdx].dealnumber,
        );
      } else {
        for (var i = 0; i < tabelLinkDealList.length; i++) {
          if (tabelDealList[lastSelectedIdx].locationcode ==
                  tabelLinkDealList[i]['locationcode'] &&
              tabelDealList[lastSelectedIdx].channelcode ==
                  tabelLinkDealList[i]['channelcode'] &&
              tabelDealList[lastSelectedIdx].dealnumber ==
                  tabelLinkDealList[i]['dealnumber']) {
            tabelLinkDealList.removeWhere((element) {
              return element['locationcode'] ==
                      tabelDealList[lastSelectedIdx].locationcode &&
                  element['channelcode'] ==
                      tabelDealList[lastSelectedIdx].channelcode &&
                  element['dealnumber'] ==
                      tabelDealList[lastSelectedIdx].dealnumber;
            });
          }
        }
      }
    }
  }

  handleactionOnPressChangeInward(
      PlutoGridCellPosition position, bool isSpaceCalled) {
    lastSelectedIdx = tabelDealGrid?.refRows[position.rowIdx ?? 0].sortIdx ?? 0;
    if (isSpaceCalled) {
      if (tabelDealGrid != null) {
        tabelDealGrid?.changeCellValue(
          tabelDealGrid!.currentCell!,
          tabelDealGrid!.currentCell!.value == "true" ? "false" : "true",
          force: true,
          callOnChangedEvent: true,
          notify: true,
        );
      }
    }
  }

  Future<void> doubleClickFilterGrid(gridController, field, value) async {
    print("Hashcode======================> ${gridController!.hashCode}");

    if (Get.find<MainController>()
        .filters1
        .containsKey(gridController!.hashCode.toString())) {
    } else {
      Get.find<MainController>().filters1[gridController!.hashCode.toString()] =
          RxList([]);
    }

    if (gridController!.hashCode != null) {
      Get.find<MainController>()
          .filters1[gridController!.hashCode.toString()]!
          .add(RowFilter(
              // costPer10Sec
              field: field,
              operator: "equal",
              value: value));
    } else {
      print(gridController!.currentCell);
    }

    var _filters = Get.find<MainController>()
            .filters1[gridController.hashCode.toString()] ??
        [];
    gridController!.setFilter((element) => true);
    List<PlutoRow> _filterRows = gridController!.rows;
    for (var filter in _filters) {
      if (filter.operator == "equal") {
        _filterRows = _filterRows.where((element) {
          return element.cells[filter.field]!.value == filter.value;
        }).toList();
      } else {
        _filterRows = _filterRows.where((element) {
          return element.cells[filter.field]!.value == filter.value;
        }).toList();
      }
    }
    gridController!.setFilter((element) => _filterRows.contains(element));
  }

  Future<void> clearFirstDataTableFilter(
      PlutoGridStateManager stateManager) async {
    Get.find<MainController>().filters1[stateManager.hashCode.toString()] =
        RxList([]);
    var _filters =
        Get.find<MainController>().filters1[stateManager.hashCode.toString()] ??
            [];
    stateManager.setFilter((element) => true);
    List<PlutoRow> _filterRows = stateManager.rows;
    for (var filter in _filters) {
      if (filter.operator == "equal") {
        _filterRows = _filterRows
            .where(
                (element) => element.cells[filter.field]!.value == filter.value)
            .toList();
      } else {
        _filterRows = _filterRows
            .where(
                (element) => element.cells[filter.field]!.value != filter.value)
            .toList();
      }
    }
    stateManager.setFilter((element) => _filterRows.contains(element));
  }

  String dateConvertToddMMyyyy(String date) {
    return (DateFormat('dd-MM-yyyy')
        .format(DateFormat('yyyy-MM-ddThh:mm:ss').parse(date)));
  }

  formHandler(btn) {
    switch (btn) {
      case "Save":
        checkSave();
        break;
      case "Clear":
        Get.delete<ComboDealEntryController>();
        Get.find<HomeController>().clearPage1();
        break;
      case "Search":
        Get.to(
          const SearchPage(
            key: Key("Combo Deal Entry"),
            screenName: "Combo Deal Entry",
            appBarName: "Combo Deal Entry",
            strViewName: "BMS_view_LinkedDeals",
            isAppBarReq: true,
          ),
        );
        break;
      case "Docs":
        if (dealCode != "0") {
          Get.defaultDialog(
            title: "Documents",
            content: CommonDocsView(
              documentKey: "Linkeddeal ${dealCode.toString()}",
            ),
          ).then((value) {
            Get.delete<CommonDocsController>(tag: "commonDocs");
          });
        }
        break;
      case "Exit":
        Get.find<HomeController>().postUserGridSetting1(listStateManager: [
          tabelDealGrid,
          tabelLinkDealGrid,
        ], tableNamesList: [
          'key1',
          'key2',
        ]);
        break;
    }
  }
}
