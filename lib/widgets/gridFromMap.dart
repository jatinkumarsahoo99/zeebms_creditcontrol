import 'package:bms_creditcontrol/app/providers/extensions/string_extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:bms_creditcontrol/widgets/PlutoGrid/pluto_grid.dart';

import '../app/providers/DataGridMenu.dart';
import '../app/providers/SizeDefine.dart';
import '../app/providers/Utils.dart';
import '../app/styles/theme.dart';

class DataGridFromMap extends StatelessWidget {
  final Map<String, double>? widthSpecificColumn;
  DataGridFromMap({
    Key? key,
    required this.mapData,
    this.colorCallback,
    this.showSrNo = true,
    this.hideCode = true,
    this.widthRatio,
    this.showonly,
    this.enableSort = false,
    this.onload,
    this.hideKeys,
    this.mode,
    this.editKeys,
    this.onEdit,
    this.actionIcon,
    this.keyMapping,
    this.actionIconKey,
    this.columnAutoResize = false,
    this.actionOnPress,
    this.onSelected,
    this.checkRowKey = "selected",
    this.onRowDoubleTap,
    this.formatDate = true,
    this.dateFromat = "dd-MM-yyyy",
    this.onFocusChange,
    this.checkRow,
    this.doPasccal = true,
    this.exportFileName,
    this.focusNode,
    this.previousWidgetFN,
    this.specificWidth,
    this.rowHeight = 25,
    this.headerHeight = 30,
    this.minimumWidth,
    this.widthSpecificColumn,
  }) : super(key: key);
  final List mapData;
  final double rowHeight;
  final double headerHeight;
  final double? minimumWidth;
  bool enableSort;
  final Map<String, double>? specificWidth;
  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final IconData? actionIcon;
  final String? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function? actionOnPress;
  final bool doPasccal;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  FocusNode? focusNode;
  FocusNode? previousWidgetFN;

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];
    if (showSrNo!) {
      segColumn.add(PlutoColumn(
          title: "Sr. No.",
          enableRowChecked: false,
          readOnly: true,
          enableSorting: enableSort,
          enableRowDrag: false,
          enableDropToResize: true,
          enableContextMenu: false,
          minWidth: 10,
          width: (widthSpecificColumn != null &&
                  widthSpecificColumn!.containsKey("no"))
              ? widthSpecificColumn!["no"]!
              : Utils.getColumnSize(key: "no", value: mapData[0][key]),
          enableAutoEditing: false,
          hide: hideCode! &&
              key.toString().toLowerCase() != "hourcode" &&
              key.toString().toLowerCase().contains("code"),
          enableColumnDrag: false,
          field: "no",
          type: PlutoColumnType.text()));
    }
    if (showonly != null && showonly!.isNotEmpty) {
      for (var key in showonly!) {
        if ((mapData[0] as Map).containsKey(key)) {
          segColumn.add(
            PlutoColumn(
                title: doPasccal
                    ? keyMapping != null
                        ? keyMapping!.containsKey(key)
                            ? keyMapping![key]
                            : key == "fpcCaption"
                                ? "FPC Caption"
                                : key.toString().pascalCaseToNormal()
                        : key.toString().pascalCaseToNormal()
                    : key.toString(),
                enableRowChecked:
                    (checkRow == true && key == checkRowKey) ? true : false,
                renderer: ((rendererContext) {
                  if (actionIconKey != null && key == actionIconKey) {
                    return GestureDetector(
                      child: Icon(
                        actionIcon,
                        size: 19,
                      ),
                      onTap: () {
                        actionOnPress!(rendererContext.rowIdx);
                      },
                    );
                    // if () {
                    // } else {
                    //   return GestureDetector(
                    //     onSecondaryTapDown: (detail) {
                    //       DataGridMenu().showGridMenu(
                    //           rendererContext.stateManager, detail, context);
                    //     },
                    //     child: Text(
                    //       rendererContext.cell.value.toString(),
                    //       style: TextStyle(
                    //         fontSize: SizeDefine.columnTitleFontSize,
                    //       ),
                    //     ),
                    //   );
                    // }
                  } else {
                    return GestureDetector(
                      onSecondaryTapDown: (detail) {
                        DataGridMenu().showGridMenu(
                            rendererContext.stateManager, detail, context,
                            data: mapData, exportFileName: exportFileName);
                      },
                      child: Text(
                        (rendererContext.cell.value ?? "").toString(),
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                }),
                enableSorting: enableSort,
                enableRowDrag: false,
                enableEditingMode: editKeys != null && editKeys!.contains(key),
                enableDropToResize: true,
                enableContextMenu: false,
                /*width: Utils.getColumnSize(
                  key: key,
                  value: mapData[0][key].toString(),
                ),*/
                minWidth: minimumWidth ?? 25,
                width: (widthSpecificColumn != null &&
                        widthSpecificColumn!.containsKey(key))
                    ? widthSpecificColumn![key]!
                    : Utils.getColumnSize(key: key, value: mapData[0][key]),
                enableAutoEditing: false,
                hide: showonly == null
                    ? (hideKeys != null && hideKeys!.contains(key)) ||
                        hideCode! &&
                            key.toString().toLowerCase() != "hourcode" &&
                            key.toString().toLowerCase().contains("code")
                    : !showonly!.contains(key),
                enableColumnDrag: false,
                field: key,
                type: PlutoColumnType.text()),
          );
        }
      }
    } else {
      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: EdgeInsets.only(),
            title: doPasccal
                ? key == "fpcCaption"
                    ? "FPC Caption"
                    : Utils.normalCaseToPascalCase(key)
                : key,
            enableRowChecked:
                (checkRow == true && key == checkRowKey) ? true : false,
            renderer: ((rendererContext) {
              if (actionIconKey != null) {
                if (key == actionIconKey) {
                  return GestureDetector(
                    child: Icon(
                      actionIcon,
                      size: 19,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      actionOnPress!(rendererContext.rowIdx);
                    },
                  );
                } else {
                  return GestureDetector(
                    onSecondaryTapDown: (detail) {
                      DataGridMenu().showGridMenu(
                          rendererContext.stateManager, detail, context,
                          data: mapData, exportFileName: exportFileName);
                    },
                    child: Text(
                      rendererContext.cell.value.toString(),
                      style: TextStyle(
                        fontSize: SizeDefine.columnTitleFontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
              } else {
                return GestureDetector(
                  onSecondaryTapDown: (detail) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        data: mapData, exportFileName: exportFileName);
                  },
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
            minWidth: minimumWidth ?? 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey(key))
                ? widthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: false,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                    hideCode! &&
                        key.toString().toLowerCase() != "hourcode" &&
                        key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }
    }

    for (var i = 0; i < mapData.length; i++) {
      Map row = mapData[i];

      Map<String, PlutoCell> cells = {};
      if (showSrNo!) {
        cells["no"] = PlutoCell(value: i + 1);
      }
      try {
        for (var element in row.entries) {
          cells[element.key] = PlutoCell(
            value: element.key == "selected" ||
                    element.value == null ||
                    (element.value is Map)
                ? ""
                : element.key.toString().toLowerCase().contains("date") &&
                        formatDate!
                    ? DateFormat(dateFromat).format(DateTime.parse(
                        element.value.toString().replaceAll("T", " ")))
                    : element.value.toString(),
          );
        }
        segRows.add(PlutoRow(cells: cells, sortIdx: i));
      } catch (e) {
        print("problem in adding rows ${e.toString()}");
      }
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
            onChanged: onEdit,
            mode: mode ?? PlutoGridMode.normal,
            configuration: plutoGridConfiguration(
                focusNode: focusNode!,
                autoScale: columnAutoResize,
                actionOnPress: actionOnPress,
                actionKey: actionIconKey,
                previousWidgetFN: previousWidgetFN,
                rowHeight: rowHeight,
                headerHeight: headerHeight),
            rowColorCallback: colorCallback,
            onLoaded: (load) {
              if (widthSpecificColumn == null || widthSpecificColumn == {}) {
                load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.none,
                    resizeMode: PlutoResizeMode.normal));
              }

              load.stateManager.setKeepFocus(false);
              if (onload != null) {
                onload!(load);
              }
            },
            columns: segColumn,
            onRowDoubleTap: onRowDoubleTap,
            onSelected: onSelected,
            rows: segRows),
      ),
    );
  }
}




class DataGridFromMap6 extends StatelessWidget {
  final Map<String, double>? widthSpecificColumn;
  DataGridFromMap6({
    Key? key,
    required this.mapData,
    this.colorCallback,
    this.showSrNo = true,
    this.hideCode = true,
    this.widthRatio,
    this.showonly,
    this.enableSort = false,
    this.onload,
    this.hideKeys,
    this.mode,
    this.editKeys,
    this.onEdit,
    this.actionIcon,
    this.keyMapping,
    this.actionIconKey,
    this.columnAutoResize = false,
    this.actionOnPress,
    this.onSelected,
    this.checkRowKey = "selected",
    this.onRowDoubleTap,
    this.formatDate = true,
    this.dateFromat = "dd-MM-yyyy",
    this.onFocusChange,
    this.checkRow,
    this.doPasccal = true,
    this.exportFileName,
    this.focusNode,
    this.previousWidgetFN,
    this.specificWidth,
    this.rowHeight = 25,
    this.headerHeight = 30,
    this.minimumWidth,
    this.widthSpecificColumn,
  }) : super(key: key);
  final List mapData;
  final double rowHeight;
  final double headerHeight;
  bool enableSort;
  final Map<String, double>? specificWidth;
  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final double? minimumWidth;
  final IconData? actionIcon;
  final String? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function? actionOnPress;
  final bool doPasccal;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  FocusNode? focusNode;
  FocusNode? previousWidgetFN;

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];
    if (showSrNo!) {
      segColumn.add(PlutoColumn(
          title: "Sr. No.",
          enableRowChecked: false,
          readOnly: true,
          enableSorting: enableSort,
          enableRowDrag: false,
          enableDropToResize: true,
          enableContextMenu: false,
          minWidth: 80,
          width: (widthSpecificColumn != null &&
                  widthSpecificColumn!.containsKey("no"))
              ? widthSpecificColumn!["no"]!
              : Utils.getColumnSize(key: "no", value: mapData[0][key]),
          enableAutoEditing: false,
          hide: hideCode! &&
              key.toString().toLowerCase() != "hourcode" &&
              key.toString().toLowerCase().contains("code"),
          enableColumnDrag: false,
          field: "no",
          type: PlutoColumnType.text()));
    }
    if (showonly != null && showonly!.isNotEmpty) {
      for (var key in showonly!) {
        if ((mapData[0] as Map).containsKey(key)) {
          segColumn.add(
            PlutoColumn(
                title: doPasccal
                    ? keyMapping != null
                        ? keyMapping!.containsKey(key)
                            ? keyMapping![key]
                            : key == "fpcCaption"
                                ? "FPC Caption"
                                : key.toString().pascalCaseToNormal()
                        : key.toString().pascalCaseToNormal()
                    : key.toString(),
                enableRowChecked:
                    (checkRow == true && key == checkRowKey) ? true : false,
                renderer: ((rendererContext) {
                  if (actionIconKey != null && key == actionIconKey) {
                    return GestureDetector(
                      child: Icon(
                        actionIcon,
                        size: 19,
                      ),
                      onTap: () {
                        actionOnPress!(rendererContext.rowIdx);
                      },
                    );
                    // if () {
                    // } else {
                    //   return GestureDetector(
                    //     onSecondaryTapDown: (detail) {
                    //       DataGridMenu().showGridMenu(
                    //           rendererContext.stateManager, detail, context);
                    //     },
                    //     child: Text(
                    //       rendererContext.cell.value.toString(),
                    //       style: TextStyle(
                    //         fontSize: SizeDefine.columnTitleFontSize,
                    //       ),
                    //     ),
                    //   );
                    // }
                  } else {
                    return GestureDetector(
                      onSecondaryTapDown: (detail) {
                        DataGridMenu().showGridMenu(
                            rendererContext.stateManager, detail, context,
                            data: mapData, exportFileName: exportFileName);
                      },
                      child: Text(
                        (rendererContext.cell.value ?? "").toString(),
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                }),
                enableSorting: enableSort,
                enableRowDrag: false,
                enableEditingMode: editKeys != null && editKeys!.contains(key),
                enableDropToResize: true,
                enableContextMenu: false,
                /*width: Utils.getColumnSize(
                  key: key,
                  value: mapData[0][key].toString(),
                ),*/
                minWidth: minimumWidth ?? 130,
                width: (widthSpecificColumn != null &&
                        widthSpecificColumn!.containsKey(key))
                    ? widthSpecificColumn![key]!
                    : Utils.getColumnSize(key: key, value: mapData[0][key]),
                enableAutoEditing: false,
                hide: showonly == null
                    ? (hideKeys != null && hideKeys!.contains(key)) ||
                        hideCode! &&
                            key.toString().toLowerCase() != "hourcode" &&
                            key.toString().toLowerCase().contains("code")
                    : !showonly!.contains(key),
                enableColumnDrag: false,
                field: key,
                type: PlutoColumnType.text()),
          );
        }
      }
    } else {
      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: EdgeInsets.only(),
            title: doPasccal
                ? key == "fpcCaption"
                    ? "FPC Caption"
                    : Utils.normalCaseToPascalCase(key)
                : key,
            enableRowChecked:
                (checkRow == true && key == checkRowKey) ? true : false,
            renderer: ((rendererContext) {
              if (actionIconKey != null) {
                if (key == actionIconKey) {
                  return GestureDetector(
                    child: Icon(
                      actionIcon,
                      size: 19,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      actionOnPress!(rendererContext.rowIdx);
                    },
                  );
                } else {
                  return GestureDetector(
                    onSecondaryTapDown: (detail) {
                      DataGridMenu().showGridMenu(
                          rendererContext.stateManager, detail, context,
                          data: mapData, exportFileName: exportFileName);
                    },
                    child: Text(
                      rendererContext.cell.value.toString(),
                      style: TextStyle(
                        fontSize: SizeDefine.columnTitleFontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
              } else {
                return GestureDetector(
                  onSecondaryTapDown: (detail) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        data: mapData, exportFileName: exportFileName);
                  },
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
            minWidth: minimumWidth ?? 130,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey(key))
                ? widthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: false,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                    hideCode! &&
                        key.toString().toLowerCase() != "hourcode" &&
                        key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }
    }

    for (var i = 0; i < mapData.length; i++) {
      Map row = mapData[i];

      Map<String, PlutoCell> cells = {};
      if (showSrNo!) {
        cells["no"] = PlutoCell(value: i + 1);
      }
      try {
        for (var element in row.entries) {
          cells[element.key] = PlutoCell(
            value: element.key == "selected" ||
                    element.value == null ||
                    (element.value is Map)
                ? ""
                : element.key.toString().toLowerCase().contains("date") &&
                        formatDate!
                    ? DateFormat(dateFromat).format(DateTime.parse(
                        element.value.toString().replaceAll("T", " ")))
                    : element.value.toString(),
          );
        }
        segRows.add(PlutoRow(cells: cells, sortIdx: i));
      } catch (e) {
        print("problem in adding rows ${e.toString()}");
      }
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
            onChanged: onEdit,
            mode: mode ?? PlutoGridMode.normal,
            configuration: plutoGridConfiguration(
                focusNode: focusNode!,
                autoScale: columnAutoResize,
                actionOnPress: actionOnPress,
                actionKey: actionIconKey,
                previousWidgetFN: previousWidgetFN,
                rowHeight: rowHeight,
                headerHeight: headerHeight),
            rowColorCallback: colorCallback,
            onLoaded: (load) {
              if (widthSpecificColumn == null || widthSpecificColumn == {}) {
                load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.none,
                    resizeMode: PlutoResizeMode.normal));
              }

              load.stateManager.setKeepFocus(false);
              if (onload != null) {
                onload!(load);
              }
            },
            columns: segColumn,
            onRowDoubleTap: onRowDoubleTap,
            onSelected: onSelected,
            rows: segRows),
      ),
    );
  }
}

class DataGridFromMap5 extends StatelessWidget {
  final Map<String, double>? widthSpecificColumn;
  DataGridFromMap5({
    Key? key,
    required this.mapData,
    this.colorCallback,
    this.showSrNo = true,
    this.hideCode = true,
    this.widthRatio,
    this.showonly,
    this.enableSort = false,
    this.onload,
    this.hideKeys,
    this.mode,
    this.editKeys,
    this.onEdit,
    this.actionIcon,
    this.keyMapping,
    this.actionIconKey,
    this.columnAutoResize = false,
    this.actionOnPress,
    this.onSelected,
    this.checkRowKey = "selected",
    this.onRowDoubleTap,
    this.formatDate = true,
    this.dateFromat = "dd-MM-yyyy",
    this.onFocusChange,
    this.checkRow,
    this.doPasccal = true,
    this.exportFileName,
    this.focusNode,
    this.previousWidgetFN,
    this.specificWidth,
    this.rowHeight = 25,
    this.widthSpecificColumn,
  }) : super(key: key);
  final List mapData;
  final double rowHeight;
  bool enableSort;
  final Map<String, double>? specificWidth;
  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final IconData? actionIcon;
  final String? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function? actionOnPress;
  final bool doPasccal;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  FocusNode? focusNode;
  FocusNode? previousWidgetFN;

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];
    if (showSrNo!) {
      segColumn.add(PlutoColumn(
          title: "Sr. No.",
          enableRowChecked: false,
          readOnly: true,
          enableSorting: enableSort,
          enableRowDrag: false,
          enableDropToResize: true,
          enableContextMenu: false,
          minWidth: 10,
          width: (widthSpecificColumn != null &&
                  widthSpecificColumn!.containsKey("no"))
              ? widthSpecificColumn!["no"]!
              : Utils.getColumnSize(key: "no", value: mapData[0][key]),
          enableAutoEditing: false,
          hide: hideCode! &&
              key.toString().toLowerCase() != "hourcode" &&
              key.toString().toLowerCase().contains("code"),
          enableColumnDrag: false,
          field: "no",
          type: PlutoColumnType.text()));
    }
    if (showonly != null && showonly!.isNotEmpty) {
      for (var key in showonly!) {
        if ((mapData[0] as Map).containsKey(key)) {
          segColumn.add(
            PlutoColumn(
                title: doPasccal
                    ? keyMapping != null
                        ? keyMapping!.containsKey(key)
                            ? keyMapping![key]
                            : key == "fpcCaption"
                                ? "FPC Caption"
                                : key.toString().pascalCaseToNormal()
                        : key.toString().pascalCaseToNormal()
                    : key.toString(),
                enableRowChecked:
                    (checkRow == true && key == checkRowKey) ? true : false,
                renderer: ((rendererContext) {
                  if (actionIconKey != null && key == actionIconKey) {
                    return GestureDetector(
                      child: Icon(
                        actionIcon,
                        size: 19,
                      ),
                      onTap: () {
                        actionOnPress!(rendererContext.rowIdx);
                      },
                    );
                    // if () {
                    // } else {
                    //   return GestureDetector(
                    //     onSecondaryTapDown: (detail) {
                    //       DataGridMenu().showGridMenu(
                    //           rendererContext.stateManager, detail, context);
                    //     },
                    //     child: Text(
                    //       rendererContext.cell.value.toString(),
                    //       style: TextStyle(
                    //         fontSize: SizeDefine.columnTitleFontSize,
                    //       ),
                    //     ),
                    //   );
                    // }
                  } else {
                    return GestureDetector(
                      onSecondaryTapDown: (detail) {
                        DataGridMenu().showGridMenu(
                            rendererContext.stateManager, detail, context,
                            data: mapData, exportFileName: exportFileName);
                      },
                      child: Text(
                        (rendererContext.cell.value ?? "").toString(),
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                }),
                enableSorting: enableSort,
                enableRowDrag: false,
                enableEditingMode: editKeys != null && editKeys!.contains(key),
                enableDropToResize: true,
                enableContextMenu: false,
                /*width: Utils.getColumnSize(
                  key: key,
                  value: mapData[0][key].toString(),
                ),*/
                minWidth: 25,
                width: (widthSpecificColumn != null &&
                        widthSpecificColumn!.containsKey(key))
                    ? widthSpecificColumn![key]!
                    : Utils.getColumnSize(key: key, value: mapData[0][key]),
                enableAutoEditing: false,
                hide: showonly == null
                    ? (hideKeys != null && hideKeys!.contains(key)) ||
                        hideCode! &&
                            key.toString().toLowerCase() != "hourcode" &&
                            key.toString().toLowerCase().contains("code")
                    : !showonly!.contains(key),
                enableColumnDrag: false,
                field: key,
                type: PlutoColumnType.text()),
          );
        }
      }
    } else {
      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: EdgeInsets.only(),
            title: doPasccal
                ? key == "fpcCaption"
                    ? "FPC Caption"
                    : key.toString().pascalCaseToNormal()
                : key,
            enableRowChecked:
                (checkRow == true && key == checkRowKey) ? true : false,
            renderer: ((rendererContext) {
              if (actionIconKey != null) {
                if (key == actionIconKey) {
                  return GestureDetector(
                    child: Icon(
                      actionIcon,
                      size: 19,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      actionOnPress!(rendererContext.rowIdx);
                    },
                  );
                } else {
                  return GestureDetector(
                    onSecondaryTapDown: (detail) {
                      DataGridMenu().showGridMenu(
                          rendererContext.stateManager, detail, context,
                          data: mapData, exportFileName: exportFileName);
                    },
                    child: Text(
                      rendererContext.cell.value.toString(),
                      style: TextStyle(
                        fontSize: SizeDefine.columnTitleFontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
              } else {
                return GestureDetector(
                  onSecondaryTapDown: (detail) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        data: mapData, exportFileName: exportFileName);
                  },
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
            minWidth: 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey(key))
                ? widthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: false,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                    hideCode! &&
                        key.toString().toLowerCase() != "hourcode" &&
                        key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }
    }

    for (var i = 0; i < mapData.length; i++) {
      Map row = mapData[i];

      Map<String, PlutoCell> cells = {};
      if (showSrNo!) {
        cells["no"] = PlutoCell(value: i + 1);
      }
      try {
        for (var element in row.entries) {
          cells[element.key] = PlutoCell(
            value: element.key == "selected" ||
                    element.value == null ||
                    (element.value is Map)
                ? ""
                : element.key.toString().toLowerCase().contains("date") &&
                        formatDate!
                    ? DateFormat(dateFromat).format(DateTime.parse(
                        element.value.toString().replaceAll("T", " ")))
                    : element.value.toString(),
          );
        }
        segRows.add(PlutoRow(cells: cells, sortIdx: i));
      } catch (e) {
        print("problem in adding rows ${e.toString()}");
      }
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
            onChanged: onEdit,
            mode: mode ?? PlutoGridMode.normal,
            configuration: plutoGridConfiguration(
              focusNode: focusNode!,
              autoScale: columnAutoResize,
              actionOnPress: actionOnPress,
              actionKey: actionIconKey,
              previousWidgetFN: previousWidgetFN,
              rowHeight: rowHeight,
            ),
            rowColorCallback: colorCallback,
            onLoaded: (load) {
              if (widthSpecificColumn == null || widthSpecificColumn == {}) {
                load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.none,
                    resizeMode: PlutoResizeMode.normal));
              }

              load.stateManager.setKeepFocus(false);
              if (onload != null) {
                onload!(load);
              }
            },
            columns: segColumn,
            onRowDoubleTap: onRowDoubleTap,
            onSelected: onSelected,
            rows: segRows),
      ),
    );
  }
}

class DataGridFromMap3 extends StatelessWidget {
  DataGridFromMap3(
      {Key? key,
      required this.mapData,
      this.colorCallback,
      this.showSrNo = true,
      this.hideCode = true,
      this.widthRatio,
      this.showonly,
      this.enableSort = false,
      this.onload,
      this.hideKeys,
      this.mode,
      this.editKeys,
      this.onEdit,
      this.actionIcons,
      this.keyMapping,
      this.actionIconKey,
      this.columnAutoResize = true,
      this.actionOnPress,
      this.onSelected,
      this.checkRowKey = "selected",
      this.onRowDoubleTap,
      this.formatDate = true,
      this.dateFromat = "dd-MM-yyyy",
      this.onFocusChange,
      this.checkRow,
      this.doPasccal = true,
      this.exportFileName,
      this.checkBoxColumnKey,
      this.showTitleInCheckBox,
      this.checkBoxStrComparison,
      this.uncheckCheckBoxStr,
      this.spaceActionKey,
      this.onActionKeyPress,
      this.enableColumnDoubleTap,
      this.onColumnHeaderDoubleTap,
      this.sort = PlutoColumnSort.none,
      this.previousWidgetFN,
      this.focusNode,
      this.gridStyle,
      this.specificWidth,
      this.rowHeight = 25,
      this.minimumWidth,
      this.formateDateColumn,
      this.noEditcheckBoxColumnKey,
      this.removeKeysFromFile,
      this.widthSpecificColumn})
      : super(key: key);
  final FocusNode? previousWidgetFN;
  final Map<String, double>? widthSpecificColumn;
  final Map<String, double>? specificWidth;
  PlutoGridStyleConfig? gridStyle;
  final List<String>? enableColumnDoubleTap;
  final Function(int columnInd, int rowIdx)? onActionKeyPress;
  final Function? spaceActionKey;
  final List mapData;
  final List<String>? showTitleInCheckBox;
  bool enableSort;
  final double rowHeight;
  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final List<String>? removeKeysFromFile;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final double? minimumWidth;
  final List<IconData>? actionIcons;
  final List<String?>? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function(PlutoGridCellPosition position, bool isSpaceCalled)?
      actionOnPress;
  final bool doPasccal;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  final List<String>? checkBoxColumnKey, noEditcheckBoxColumnKey;
  final dynamic uncheckCheckBoxStr;
  final dynamic checkBoxStrComparison;
  final void Function(String columnName)? onColumnHeaderDoubleTap;
  PlutoColumnSort sort;
  FocusNode? focusNode;
  Map<String, String>? formateDateColumn;
  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];

    if (mapData.isNotEmpty) {
      /// adding NO.
      if (showSrNo!) {
        segColumn.add(PlutoColumn(
            title: "No.",
            enableRowChecked: false,
            readOnly: true,
            enableSorting: enableSort,
            enableRowDrag: false,
            enableDropToResize: true,
            enableContextMenu: false,
            minWidth: 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey("no"))
                ? widthSpecificColumn!["no"]!
                : Utils.getColumnSize(key: "no", value: mapData[0][key]),
            enableAutoEditing: false,
            hide: hideCode! &&
                key.toString().toLowerCase() != "hourcode" &&
                key.toString().toLowerCase().contains("code"),
            enableColumnDrag: false,
            field: "no",
            type: PlutoColumnType.text()));
      }

      /// addidng columns

      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: const EdgeInsets.only(),
            sort: sort,
            titleSpan: enableColumnDoubleTap != null &&
                    enableColumnDoubleTap!.isNotEmpty &&
                    enableColumnDoubleTap!.contains(key)
                ? TextSpan(
                    text: doPasccal
                        ? key == "fpcCaption"
                            ? "FPC Caption"
                            : key.toString().pascalCaseToNormal()
                        : key,
                    recognizer: DoubleTapGestureRecognizer()
                      ..onDoubleTap = () {
                        if (onColumnHeaderDoubleTap != null) {
                          onColumnHeaderDoubleTap!(key);
                        }
                      },
                  )
                : null,
            title: doPasccal
                ? keyMapping != null
                    ? keyMapping!.containsKey(key)
                        ? keyMapping![key]
                        : key == "fpcCaption"
                            ? "FPC Caption"
                            : key.toString().pascalCaseToNormal()
                    : key.toString().pascalCaseToNormal()
                : key.toString(),
            enableRowChecked: false,
            renderer: ((rendererContext) {
              // print(">>>>>>>>>>>.rendererContext.cell.value"+rendererContext.cell.value.toString());
              // print(">>>>>>>>>>>.rendererContext.cell.value"+rendererContext.cell.value.runtimeType.toString());
              if (checkBoxColumnKey != null &&
                  checkBoxColumnKey!.isNotEmpty &&
                  checkBoxColumnKey!.contains(key)) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      canRequestFocus: false,
                      onTap: (noEditcheckBoxColumnKey != null &&
                              noEditcheckBoxColumnKey!.contains(key))
                          ? null
                          : () {
                              if (showTitleInCheckBox != null &&
                                  showTitleInCheckBox!.isNotEmpty) {
                                var temp = mapData[rendererContext.rowIdx][key];
                                print(">>>>>>>>>>temp$temp");
                                temp['key'] =
                                    (temp['key'] == checkBoxStrComparison)
                                        ? uncheckCheckBoxStr
                                        : checkBoxStrComparison;
                                rendererContext.stateManager.changeCellValue(
                                  rendererContext.cell,
                                  temp,
                                  force: true,
                                  callOnChangedEvent: true,
                                  notify: true,
                                );
                                rendererContext.stateManager.setCurrentCell(
                                    rendererContext.cell,
                                    rendererContext.rowIdx);
                                if (rendererContext.stateManager.onSelected !=
                                    null) {
                                  rendererContext.stateManager
                                      .onSelected!(PlutoGridOnSelectedEvent(
                                    cell: rendererContext.cell,
                                    row: rendererContext.row,
                                    rowIdx: rendererContext.rowIdx,
                                    selectedRows: rendererContext
                                        .stateManager.currentSelectingRows,
                                  ));
                                }
                              } else {
                                rendererContext.stateManager.changeCellValue(
                                  rendererContext.cell,
                                  rendererContext.cell.value ==
                                          checkBoxStrComparison
                                      ? uncheckCheckBoxStr
                                      : checkBoxStrComparison,
                                  force: true,
                                  callOnChangedEvent: true,
                                  notify: true,
                                );
                                rendererContext.stateManager.setCurrentCell(
                                    rendererContext.cell,
                                    rendererContext.rowIdx);
                                if (rendererContext.stateManager.onSelected !=
                                    null) {
                                  rendererContext.stateManager
                                      .onSelected!(PlutoGridOnSelectedEvent(
                                    cell: rendererContext.cell,
                                    row: rendererContext.row,
                                    rowIdx: rendererContext.rowIdx,
                                    selectedRows: rendererContext
                                        .stateManager.currentSelectingRows,
                                  ));
                                }
                              }
                            },
                      child: Icon(
                        ((showTitleInCheckBox != null &&
                                        showTitleInCheckBox!.isNotEmpty)
                                    ? mapData[rendererContext.rowIdx][key]
                                        ['key']
                                    : rendererContext.cell.value) ==
                                checkBoxStrComparison
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: ((showTitleInCheckBox != null &&
                                        showTitleInCheckBox!.isNotEmpty)
                                    ? mapData[rendererContext.rowIdx][key]
                                        ['key']
                                    : rendererContext.cell.value) ==
                                checkBoxStrComparison
                            ? Colors.deepPurpleAccent
                            : Colors.grey,
                        size: rowHeight <= 22 ? 18 : Get.theme.iconTheme.size,
                      ),
                    ),
                    if (showTitleInCheckBox != null &&
                        showTitleInCheckBox!.isNotEmpty &&
                        showTitleInCheckBox!.contains(key)) ...{
                      const SizedBox(width: 5),
                      Text(
                        (showTitleInCheckBox != null &&
                                showTitleInCheckBox!.isNotEmpty)
                            ? mapData[rendererContext.rowIdx][key]['value']
                            : mapData[rendererContext.rowIdx][key],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                      ),
                    }
                  ],
                );
              } else {
                return GestureDetector(
                  onSecondaryTapDown: (detail) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        data: mapData,
                        exportFileName: exportFileName,
                        removeKeysFromFile: removeKeysFromFile);
                  },
                  child: Text(
                    rendererContext.cell.value.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            minWidth:minimumWidth?? 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey(key))
                ? widthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: false,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                    hideCode! &&
                        key.toString().toLowerCase() != "hourcode" &&
                        key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }

      /// adding rows
      for (var i = 0; i < mapData.length; i++) {
        Map row = mapData[i];

        Map<String, PlutoCell> cells = {};
        if (showSrNo!) {
          cells["no"] = PlutoCell(value: i + 1);
        }
        try {
          for (var element in row.entries) {
            try {
              cells[element.key] = PlutoCell(
                value: formateDateColumn != null &&
                        formateDateColumn!.containsKey(element.key) &&
                        element.value != null
                    ? DateFormat(dateFromat).format(
                        DateFormat(formateDateColumn![element.key])
                            .parse(element.value))
                    : element.value ?? "",
              );
            } catch (e) {
              print(
                  "Problem while formating date assigning original value ${e.toString()}");
              cells[element.key] = PlutoCell(
                value: element.value ?? "",
              );
            }
          }
          segRows.add(PlutoRow(cells: cells, sortIdx: i));
        } catch (e) {
          print("problem in adding rows");
        }
      }
    } else {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      );
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
          onChanged: onEdit,
          mode: mode ?? PlutoGridMode.normal,
          configuration: plutoGridConfiguration2(
            focusNode: focusNode!,
            rowHeight: rowHeight,
            autoScale: columnAutoResize,
            actionOnPress: actionOnPress,
            actionKey: actionIconKey ?? [],
            previousWidgetFN: previousWidgetFN,
          ).copyWith(style: gridStyle),
          rowColorCallback: colorCallback,
          onLoaded: (load) {
            if (widthSpecificColumn == null || widthSpecificColumn == {}) {
              load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.none,
                  resizeMode: PlutoResizeMode.normal));
            }

            load.stateManager.setKeepFocus(false);
            if (onload != null) {
              onload!(load);
            }
          },
          columns: segColumn,
          onRowDoubleTap: onRowDoubleTap,
          onSelected: onSelected,
          rows: segRows,
        ),
      ),
    );
  }
}

class DataGridFromMap4 extends StatelessWidget {
  DataGridFromMap4({
    Key? key,
    required this.mapData,
    this.colorCallback,
    this.showSrNo = true,
    this.hideCode = true,
    this.widthRatio,
    this.showonly,
    this.enableSort = false,
    this.onload,
    this.hideKeys,
    this.mode,
    this.editKeys,
    this.onEdit,
    this.actionIcons,
    this.keyMapping,
    this.actionIconKey,
    this.columnAutoResize = true,
    this.actionOnPress,
    this.onSelected,
    this.checkRowKey = "selected",
    this.onRowDoubleTap,
    this.formatDate = true,
    this.dateFromat = "dd-MM-yyyy",
    this.onFocusChange,
    this.checkRow,
    this.doPasccal = true,
    this.exportFileName,
    this.checkBoxColumnKey,
    this.showTitleInCheckBox,
    this.checkBoxStrComparison,
    this.uncheckCheckBoxStr,
    this.spaceActionKey,
    this.onActionKeyPress,
    this.enableColumnDoubleTap,
    this.onColumnHeaderDoubleTap,
    this.sort = PlutoColumnSort.none,
    this.previousWidgetFN,
    this.focusNode,
    this.gridStyle,
    this.specificWidth,
    this.rowHeight = 25,
    this.formateDateColumn,
    this.noEditcheckBoxColumnKey,
    this.removeKeysFromFile,
    this.widthSpecificColumn,
    this.onColumnHeaderSingleTap,
    this.enableAutoEditing = false,
  }) : super(key: key);
  final FocusNode? previousWidgetFN;
  final Map<String, double>? widthSpecificColumn;
  final Map<String, double>? specificWidth;
  PlutoGridStyleConfig? gridStyle;
  final List<String>? enableColumnDoubleTap;
  final Function(int columnInd, int rowIdx)? onActionKeyPress;
  final Function? spaceActionKey;
  final List mapData;
  final List<String>? showTitleInCheckBox;
  bool enableSort;
  final double rowHeight;
  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final List<String>? removeKeysFromFile;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final List<IconData>? actionIcons;
  final List<String?>? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function(PlutoGridCellPosition position, bool isSpaceCalled)?
      actionOnPress;
  final bool doPasccal;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  final List<String>? checkBoxColumnKey, noEditcheckBoxColumnKey;
  final dynamic uncheckCheckBoxStr;
  final dynamic checkBoxStrComparison;
  final void Function(String columnName)? onColumnHeaderDoubleTap;
  PlutoColumnSort sort;
  FocusNode? focusNode;
  Map<String, String>? formateDateColumn;
  final Function? onColumnHeaderSingleTap;
  final bool enableAutoEditing;

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];

    if (mapData.isNotEmpty) {
      /// adding NO.
      if (showSrNo!) {
        segColumn.add(PlutoColumn(
            title: "No.",
            enableRowChecked: false,
            readOnly: true,
            enableSorting: enableSort,
            enableRowDrag: false,
            enableDropToResize: true,
            enableContextMenu: false,
            minWidth: 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey("no"))
                ? widthSpecificColumn!["no"]!
                : Utils.getColumnSize(key: "no", value: mapData[0][key]),
            enableAutoEditing: false,
            hide: hideCode! &&
                key.toString().toLowerCase() != "hourcode" &&
                key.toString().toLowerCase().contains("code"),
            enableColumnDrag: false,
            field: "no",
            type: PlutoColumnType.text()));
      }

      /// addidng columns

      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: const EdgeInsets.only(),
            sort: sort,
            titleSpan: enableColumnDoubleTap != null &&
                    enableColumnDoubleTap!.isNotEmpty &&
                    enableColumnDoubleTap!.contains(key)
                ? TextSpan(
                    text: doPasccal
                        ? key == "fpcCaption"
                            ? "FPC Caption"
                            : key.toString().pascalCaseToNormal()
                        : key,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (onColumnHeaderDoubleTap != null) {
                          onColumnHeaderDoubleTap!(key);
                        }
                      },
                  )
                : null,
            title: doPasccal
                ? keyMapping != null
                    ? keyMapping!.containsKey(key)
                        ? keyMapping![key]
                        : key == "fpcCaption"
                            ? "FPC Caption"
                            : key.toString().pascalCaseToNormal()
                    : key.toString().pascalCaseToNormal()
                : key.toString(),
            enableRowChecked: false,
            renderer: ((rendererContext) {
              // print(">>>>>>>>>>>.rendererContext.cell.value"+rendererContext.cell.value.toString());
              // print(">>>>>>>>>>>.rendererContext.cell.value"+rendererContext.cell.value.runtimeType.toString());
              if (checkBoxColumnKey != null &&
                  checkBoxColumnKey!.isNotEmpty &&
                  checkBoxColumnKey!.contains(key)) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      canRequestFocus: false,
                      onTap: (noEditcheckBoxColumnKey != null &&
                              noEditcheckBoxColumnKey!.contains(key))
                          ? null
                          : () {
                              if (showTitleInCheckBox != null &&
                                  showTitleInCheckBox!.isNotEmpty) {
                                var temp = mapData[rendererContext.rowIdx][key];
                                print(">>>>>>>>>>temp$temp");
                                temp['key'] =
                                    (temp['key'] == checkBoxStrComparison)
                                        ? uncheckCheckBoxStr
                                        : checkBoxStrComparison;
                                rendererContext.stateManager.changeCellValue(
                                  rendererContext.cell,
                                  temp,
                                  force: true,
                                  callOnChangedEvent: true,
                                  notify: true,
                                );
                                rendererContext.stateManager.setCurrentCell(
                                    rendererContext.cell,
                                    rendererContext.rowIdx);
                                if (rendererContext.stateManager.onSelected !=
                                    null) {
                                  rendererContext.stateManager
                                      .onSelected!(PlutoGridOnSelectedEvent(
                                    cell: rendererContext.cell,
                                    row: rendererContext.row,
                                    rowIdx: rendererContext.rowIdx,
                                    selectedRows: rendererContext
                                        .stateManager.currentSelectingRows,
                                  ));
                                }
                              } else {
                                rendererContext.stateManager.changeCellValue(
                                  rendererContext.cell,
                                  rendererContext.cell.value ==
                                          checkBoxStrComparison
                                      ? uncheckCheckBoxStr
                                      : checkBoxStrComparison,
                                  force: true,
                                  callOnChangedEvent: true,
                                  notify: true,
                                );
                                rendererContext.stateManager.setCurrentCell(
                                    rendererContext.cell,
                                    rendererContext.rowIdx);
                                if (rendererContext.stateManager.onSelected !=
                                    null) {
                                  rendererContext.stateManager
                                      .onSelected!(PlutoGridOnSelectedEvent(
                                    cell: rendererContext.cell,
                                    row: rendererContext.row,
                                    rowIdx: rendererContext.rowIdx,
                                    selectedRows: rendererContext
                                        .stateManager.currentSelectingRows,
                                  ));
                                }
                              }
                            },
                      child: Icon(
                        ((showTitleInCheckBox != null &&
                                        showTitleInCheckBox!.isNotEmpty)
                                    ? mapData[rendererContext.rowIdx][key]
                                        ['key']
                                    : rendererContext.cell.value) ==
                                checkBoxStrComparison
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: ((showTitleInCheckBox != null &&
                                        showTitleInCheckBox!.isNotEmpty)
                                    ? mapData[rendererContext.rowIdx][key]
                                        ['key']
                                    : rendererContext.cell.value) ==
                                checkBoxStrComparison
                            ? Colors.deepPurpleAccent
                            : Colors.grey,
                        size: rowHeight <= 22 ? 18 : Get.theme.iconTheme.size,
                      ),
                    ),
                    if (showTitleInCheckBox != null &&
                        showTitleInCheckBox!.isNotEmpty &&
                        showTitleInCheckBox!.contains(key)) ...{
                      const SizedBox(width: 5),
                      Text(
                        (showTitleInCheckBox != null &&
                                showTitleInCheckBox!.isNotEmpty)
                            ? mapData[rendererContext.rowIdx][key]['value']
                            : mapData[rendererContext.rowIdx][key],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                      ),
                    }
                  ],
                );
              } else {
                return GestureDetector(
                  onSecondaryTapDown: (detail) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        data: mapData,
                        exportFileName: exportFileName,
                        removeKeysFromFile: removeKeysFromFile);
                  },
                  child: Text(
                    rendererContext.cell.value.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            minWidth: 25,
            width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey(key))
                ? widthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: enableAutoEditing,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                    hideCode! &&
                        key.toString().toLowerCase() != "hourcode" &&
                        key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }

      /// adding rows
      for (var i = 0; i < mapData.length; i++) {
        Map row = mapData[i];

        Map<String, PlutoCell> cells = {};
        if (showSrNo!) {
          cells["no"] = PlutoCell(value: i + 1);
        }
        try {
          for (var element in row.entries) {
            try {
              cells[element.key] = PlutoCell(
                value: formateDateColumn != null &&
                        formateDateColumn!.containsKey(element.key) &&
                        element.value != null
                    ? DateFormat(dateFromat).format(
                        DateFormat(formateDateColumn![element.key])
                            .parse(element.value))
                    : element.value ?? "",
              );
            } catch (e) {
              print(
                  "Problem while formating date assigning original value ${e.toString()}");
              cells[element.key] = PlutoCell(
                value: element.value ?? "",
              );
            }
          }
          segRows.add(PlutoRow(cells: cells, sortIdx: i));
        } catch (e) {
          print("problem in adding rows");
        }
      }
    } else {
      return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      );
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: GestureDetector(
          onTap: () {
            onColumnHeaderSingleTap!();

            // print("hey====1");
          },
          child: PlutoGrid(
            onChanged: onEdit,
            mode: mode ?? PlutoGridMode.normal,
            configuration: plutoGridConfiguration2(
              focusNode: focusNode!,
              rowHeight: rowHeight,
              autoScale: columnAutoResize,
              actionOnPress: actionOnPress,
              actionKey: actionIconKey ?? [],
              previousWidgetFN: previousWidgetFN,
            ).copyWith(style: gridStyle),
            rowColorCallback: colorCallback,
            onLoaded: (load) {
              if (widthSpecificColumn == null || widthSpecificColumn == {}) {
                load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.none,
                    resizeMode: PlutoResizeMode.normal));
              }

              load.stateManager.setKeepFocus(false);
              if (onload != null) {
                onload!(load);
              }
            },
            columns: segColumn,
            onRowDoubleTap: onRowDoubleTap,
            onSelected: onSelected,
            rows: segRows,
          ),
        ),
      ),
    );
  }
}


class DataGridFromMap7 extends StatelessWidget {
  final Map<String, double>? witdthSpecificColumn;
  final bool canShowFilter;
  DataGridFromMap7(
      {Key? key,
        required this.mapData,
        this.canShowFilter = true,
        this.colorCallback,
        this.showSrNo = true,
        this.hideCode = true,
        this.widthRatio,
        this.showonly,
        this.enableSort = false,
        this.onload,
        this.hideKeys,
        this.mode,
        this.editKeys,
        this.onEdit,
        this.actionIcon,
        this.keyMapping,
        this.actionIconKey,
        this.columnAutoResize = false,
        this.actionOnPress,
        this.onSelected,
        this.onRowCheck,
        this.onContextMenuClick,
        this.checkRowKey = "selected",
        this.onRowDoubleTap,
        this.formatDate = true,
        this.dateFromat = "dd-MM-yyyy",
        this.onFocusChange,
        this.checkRow,
        this.doPasccal = true,
        this.exportFileName,
        this.focusNode,
        this.previousWidgetFN,
        this.witdthSpecificColumn,
        this.csvFormat = false,
        this.showOnlyCheckBox,
        this.removeKeysFromFile})
      : super(key: key);
  final List mapData;
  bool enableSort;

  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final List<String>? removeKeysFromFile;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final Function(DataGridMenuItem, int)? onContextMenuClick;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final Function(PlutoGridOnRowCheckedEvent)? onRowCheck;
  final double? widthRatio;
  final IconData? actionIcon;
  final String? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function? actionOnPress;
  final bool doPasccal;
  final bool? csvFormat;
  final bool? showOnlyCheckBox;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  FocusNode? focusNode;
  FocusNode? previousWidgetFN;

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];
    if (showSrNo!) {
      segColumn.add(PlutoColumn(
          title: "No.",
          // titleSpan: TextSpan(
          //   text: "No.",
          //   recognizer: DoubleTapGestureRecognizer()
          //     ..onDoubleTap = () {
          //       if (onContextMenuClick == null) {
          //         DataGridMenu().showGridMenu(rendererContext.stateManager, detail, context, exportFileName: exportFileName);
          //       } else {
          //         DataGridMenu().showGridCustomMenu(rendererContext.stateManager, detail, context,
          //             exportFileName: exportFileName, onPressedClick: onContextMenuClick, plutoContext: rendererContext);
          //       }
          //     },
          // ),
          enableRowChecked: false,
          readOnly: true,
          enableSorting: enableSort,
          enableRowDrag: false,
          enableDropToResize: true,
          enableContextMenu: false,
          width: 40,
          enableAutoEditing: false,
          hide: hideCode! &&
              key.toString().toLowerCase() != "hourcode" &&
              key.toString().toLowerCase().contains("code"),
          enableColumnDrag: false,
          field: "no",
          cellPadding: const EdgeInsets.all(0),
          renderer: ((rendererContext) {
            // print("On rendererContext called");
            return GestureDetector(
              onSecondaryTapDown: canShowFilter
                  ? (detail) {
                if (onContextMenuClick == null) {
                  DataGridMenu().showGridMenu(
                      rendererContext.stateManager, detail, context,
                      exportFileName: exportFileName,
                      csvFormat: csvFormat ?? false,
                      data: mapData,
                      removeKeysFromFile: removeKeysFromFile);
                } else {
                  DataGridMenu().showGridCustomMenu1(
                      rendererContext.stateManager, detail, context,
                      exportFileName: exportFileName,
                      onPressedClick: onContextMenuClick,
                      data: mapData,
                      plutoContext: rendererContext);
                }
              }
                  : null,
              child: Container(
                // height: 25,
                  height: double.infinity,
                  // width: Utils.getColumnSize1(key: key, value: mapData[0][key]),
                  // padding: EdgeInsets.only(
                  //   left:
                  // ),
                  decoration: BoxDecoration(
                      border:
                      Border.all(color: Colors.transparent, width: 0.01),
                      borderRadius: BorderRadius.circular(1),
                      color: Colors.white),
                  alignment: Alignment.center,
                  // color: (key == "epsNo" || key == "tapeid" || key == "status") ? ColorData.cellColor(rendererContext.row.cells[key]?.value, key) : null,
                  child: Text(
                    (rendererContext.rowIdx + 1).toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                  )),
            );
          }),
          // renderer: (rendererContext) {
          //   return GestureDetector(
          //     onSecondaryTapDown: canShowFilter
          //         ? (detail) {
          //             if (onContextMenuClick == null) {
          //               DataGridMenu().showGridMenu(
          //                   rendererContext.stateManager, detail, context,
          //                   exportFileName: exportFileName);
          //             } else {
          //               DataGridMenu().showGridCustomMenu(
          //                   rendererContext.stateManager, detail, context,
          //                   exportFileName: exportFileName,
          //                   onPressedClick: onContextMenuClick,
          //                   plutoContext: rendererContext);
          //             }
          //           }
          //         : null,
          //     child: Text(
          //       (rendererContext.cell.value ?? "").toString(),
          //       style: TextStyle(
          //         fontSize: SizeDefine.columnTitleFontSize,
          //       ),
          //       maxLines: 1,
          //       overflow: TextOverflow.ellipsis,
          //     ),
          //   );
          // },
          type: PlutoColumnType.text()));
    }
    if (showonly != null && showonly!.isNotEmpty) {
      for (var key in showonly!) {
        if ((mapData[0] as Map).containsKey(key)) {
          segColumn.add(PlutoColumn(
              minWidth: 25,
              title: doPasccal
                  ? keyMapping != null
                  ? keyMapping!.containsKey(key)
                  ? keyMapping![key]
                  : key == "fpcCaption"
                  ? "FPC Caption"
                  : key.toString().pascalCaseToNormal()
                  : key.toString().pascalCaseToNormal()
                  : key.toString(),
              enableRowChecked:
              (checkRow == true && key == checkRowKey) ? true : false,
              renderer: ((rendererContext) {
                if (actionIconKey != null && key == actionIconKey) {
                  return GestureDetector(
                    child: Icon(
                      actionIcon,
                      size: 19,
                    ),
                    onTap: () {
                      actionOnPress!(rendererContext.rowIdx);
                    },
                  );
                } else {
                  return GestureDetector(
                    onSecondaryTapDown: canShowFilter
                        ? (detail) {
                      if (onContextMenuClick == null) {
                        DataGridMenu().showGridMenu(
                            rendererContext.stateManager, detail, context,
                            exportFileName: exportFileName,
                            csvFormat: csvFormat ?? false,
                            data: mapData,
                            removeKeysFromFile: removeKeysFromFile);
                      } else {
                        DataGridMenu().showGridCustomMenu1(
                            rendererContext.stateManager, detail, context,
                            exportFileName: exportFileName,
                            onPressedClick: onContextMenuClick,
                            data: mapData,
                            plutoContext: rendererContext);
                      }
                    }
                        : null,
                    child: Text(
                      (rendererContext.cell.value ?? "").toString(),
                      style: TextStyle(
                        fontSize: SizeDefine.columnTitleFontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
              }),
              enableSorting: enableSort,
              enableRowDrag: false,
              enableEditingMode: editKeys != null && editKeys!.contains(key),
              enableDropToResize: true,
              enableContextMenu: false,
              width: Utils.getColumnSize(
                key: key,
                value: mapData[0][key].toString(),
              ),
              enableAutoEditing: false,
              hide: showonly == null
                  ? (hideKeys != null && hideKeys!.contains(key)) ||
                  hideCode! &&
                      key.toString().toLowerCase() != "hourcode" &&
                      key.toString().toLowerCase().contains("code")
                  : !showonly!.contains(key),
              enableColumnDrag: false,
              field: key,
              type: PlutoColumnType.text()));
        }
      }
    } else {
      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: EdgeInsets.only(),
            title: doPasccal
                ? key == "fpcCaption"
                ? "FPC Caption"
                : key.toString().pascalCaseToNormal()
                : key,
            enableRowChecked:
            (checkRow == true && key == checkRowKey) ? true : false,
            renderer: ((rendererContext) {
              if (actionIconKey != null) {
                if (key == actionIconKey) {
                  return GestureDetector(
                    child: Icon(
                      actionIcon,
                      size: 19,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      actionOnPress!(rendererContext.rowIdx);
                    },
                  );
                } else {
                  return GestureDetector(
                    onSecondaryTapDown: canShowFilter
                        ? (detail) {
                      if (onContextMenuClick == null) {
                        DataGridMenu().showGridMenu(
                            rendererContext.stateManager, detail, context,
                            exportFileName: exportFileName,
                            csvFormat: csvFormat ?? false,
                            data: mapData,
                            removeKeysFromFile: removeKeysFromFile);
                      } else {
                        DataGridMenu().showGridCustomMenu1(
                            rendererContext.stateManager, detail, context,
                            exportFileName: exportFileName,
                            onPressedClick: onContextMenuClick,
                            data: mapData,
                            plutoContext: rendererContext);
                      }
                    }
                        : null,
                    child: Text(
                      rendererContext.cell.value.toString(),
                      style: TextStyle(
                        fontSize: SizeDefine.columnTitleFontSize,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
              } else if (showOnlyCheckBox == true) {
                return GestureDetector(
                  onSecondaryTapDown: canShowFilter
                      ? (detail) {
                    if (onContextMenuClick == null) {
                      DataGridMenu().showGridMenu(
                          rendererContext.stateManager, detail, context,
                          exportFileName: exportFileName,
                          csvFormat: csvFormat ?? false,
                          data: mapData,
                          removeKeysFromFile: removeKeysFromFile);
                    } else {
                      DataGridMenu().showGridCustomMenu1(
                          rendererContext.stateManager, detail, context,
                          exportFileName: exportFileName,
                          onPressedClick: onContextMenuClick,
                          data: mapData,
                          plutoContext: rendererContext);
                    }
                  }
                      : null,
                  child: ((key ?? "").toString().toLowerCase().trim() ==
                      (checkRowKey ?? "").toString().toLowerCase().trim())
                      ? Checkbox(
                    value: (rendererContext.cell.value != null &&
                        (rendererContext.cell.value)
                            .toString()
                            .trim() ==
                            "true")
                        ? true
                        : false,
                    onChanged: (bool? value) {},
                    materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,
                  )
                      : Text(
                    rendererContext.cell.value.toString(),
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              } else {
                return GestureDetector(
                  onSecondaryTapDown: canShowFilter
                      ? (detail) {
                    if (onContextMenuClick == null) {
                      DataGridMenu().showGridMenu(
                          rendererContext.stateManager, detail, context,
                          exportFileName: exportFileName,
                          csvFormat: csvFormat ?? false,
                          data: mapData,
                          removeKeysFromFile: removeKeysFromFile);
                    } else {
                      DataGridMenu().showGridCustomMenu1(
                          rendererContext.stateManager, detail, context,
                          exportFileName: exportFileName,
                          onPressedClick: onContextMenuClick,
                          data: mapData,
                          plutoContext: rendererContext);
                    }
                  }
                      : null,
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: TextStyle(
                      fontSize: SizeDefine.columnTitleFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            minWidth: 25,
            width: (witdthSpecificColumn != null &&
                witdthSpecificColumn!.keys.toList().contains(key))
                ? witdthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: false,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                hideCode! &&
                    key.toString().toLowerCase() != "hourcode" &&
                    key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }
    }

    for (var i = 0; i < mapData.length; i++) {
      Map row = mapData[i];

      Map<String, PlutoCell> cells = {};
      if (showSrNo!) {
        cells["no"] = PlutoCell(value: i + 1);
      }
      try {
        for (var element in row.entries) {
          cells[element.key] = PlutoCell(
            value: element.key == "selected" || element.value == null
                ? ""
                : element.key.toString().toLowerCase().contains("date") &&
                formatDate!
                ? DateFormat(dateFromat).format(DateTime.parse(
                element.value.toString().replaceAll("T", " ")))
                : element.value.toString(),
          );
        }
        segRows.add(PlutoRow(cells: cells, sortIdx: i));
      } catch (e) {
        print("problem in adding rows" + e.toString());
      }
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
            onChanged: onEdit,
            mode: mode ?? PlutoGridMode.normal,
            configuration: plutoGridConfiguration(
              focusNode: focusNode!,
              autoScale: columnAutoResize,
              actionOnPress: actionOnPress,
              actionKey: actionIconKey,
              previousWidgetFN: previousWidgetFN,
              rowHeight: 25,
            ),
            rowColorCallback: colorCallback,
            onLoaded: (load) {
              // load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
              //     autoSizeMode: columnAutoResize
              //         ? PlutoAutoSizeMode.none
              //         : PlutoAutoSizeMode.scale,
              //     resizeMode: PlutoResizeMode.normal));
              load.stateManager.setKeepFocus(false);
              if (onload != null) {
                onload!(load);
              }
            },
            columns: segColumn,
            onRowDoubleTap: onRowDoubleTap,
            onSelected: onSelected,
            onRowChecked: onRowCheck,
            rows: segRows),
      ),
    );
  }
}



class DataGridFromMapCompareDialog extends StatelessWidget {
  final Map<String, double>? widthSpecificColumn;
  DataGridFromMapCompareDialog({
    Key? key,
    required this.mapData,
    this.colorCallback,
    this.showSrNo = true,
    this.hideCode = true,
    this.widthRatio,
    this.showonly,
    this.enableSort = false,
    this.onload,
    this.hideKeys,
    this.mode,
    this.editKeys,
    this.onEdit,
    this.actionIcon,
    this.keyMapping,
    this.actionIconKey,
    this.columnAutoResize = false,
    this.actionOnPress,
    this.onSelected,
    this.checkRowKey = "selected",
    this.onRowDoubleTap,
    this.formatDate = true,
    this.dateFromat = "dd-MM-yyyy",
    this.onFocusChange,
    this.checkRow,
    this.doPasccal = true,
    this.exportFileName,
    this.focusNode,
    this.previousWidgetFN,
    this.specificWidth,
    this.rowHeight = 25,
    this.headerHeight = 30,
    this.minimumWidth,
    this.widthSpecificColumn,
  }) : super(key: key);
  final List mapData;
  final double rowHeight;
  final double headerHeight;
  final double? minimumWidth;
  bool enableSort;
  final Map<String, double>? specificWidth;
  final bool? showSrNo;
  final bool? hideCode;
  final PlutoGridMode? mode;
  final bool? formatDate;
  final bool? checkRow;
  final String? checkRowKey;
  final Map? keyMapping;
  final String? dateFromat;
  final String? exportFileName;
  final List<String>? showonly;
  final Function(PlutoGridOnRowDoubleTapEvent)? onRowDoubleTap;
  final Function(PlutoGridOnChangedEvent)? onEdit;
  final Function(bool)? onFocusChange;
  final List? hideKeys;
  final Function(PlutoGridOnSelectedEvent)? onSelected;
  final double? widthRatio;
  final IconData? actionIcon;
  final String? actionIconKey;
  final bool columnAutoResize;
  final List<String>? editKeys;
  final Function? actionOnPress;
  final bool doPasccal;
  Color Function(PlutoRowColorContext)? colorCallback;
  Function(PlutoGridOnLoadedEvent)? onload;
  final GlobalKey rebuildKey = GlobalKey();
  FocusNode? focusNode;
  FocusNode? previousWidgetFN;

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> segColumn = [];

    focusNode ??= FocusNode();
    List<PlutoRow> segRows = [];
    if (showSrNo!) {
      segColumn.add(PlutoColumn(
          title: "Sr. No.",
          enableRowChecked: false,
          readOnly: true,
          enableSorting: enableSort,
          enableRowDrag: false,
          enableDropToResize: true,
          enableContextMenu: false,
          minWidth: 10,
          width: (widthSpecificColumn != null &&
              widthSpecificColumn!.containsKey("no"))
              ? widthSpecificColumn!["no"]!
              : Utils.getColumnSize(key: "no", value: mapData[0][key]),
          enableAutoEditing: false,
          hide: hideCode! &&
              key.toString().toLowerCase() != "hourcode" &&
              key.toString().toLowerCase().contains("code"),
          enableColumnDrag: false,
          field: "no",
          type: PlutoColumnType.text()));
    }
    if (showonly != null && showonly!.isNotEmpty) {
      for (var key in showonly!) {
        if ((mapData[0] as Map).containsKey(key)) {
          segColumn.add(
            PlutoColumn(
                title: doPasccal
                    ? keyMapping != null
                    ? keyMapping!.containsKey(key)
                    ? keyMapping![key]
                    : key == "fpcCaption"
                    ? "FPC Caption"
                    : key.toString().pascalCaseToNormal()
                    : key.toString().pascalCaseToNormal()
                    : key.toString(),
                enableRowChecked:
                (checkRow == true && key == checkRowKey) ? true : false,
                renderer: ((rendererContext) {
                  if (actionIconKey != null && key == actionIconKey) {
                    return GestureDetector(
                      child: Icon(
                        actionIcon,
                        size: 19,
                      ),
                      onTap: () {
                        actionOnPress!(rendererContext.rowIdx);
                      },
                    );
                    // if () {
                    // } else {
                    //   return GestureDetector(
                    //     onSecondaryTapDown: (detail) {
                    //       DataGridMenu().showGridMenu(
                    //           rendererContext.stateManager, detail, context);
                    //     },
                    //     child: Text(
                    //       rendererContext.cell.value.toString(),
                    //       style: TextStyle(
                    //         fontSize: SizeDefine.columnTitleFontSize,
                    //       ),
                    //     ),
                    //   );
                    // }
                  } else {
                    return GestureDetector(
                      onSecondaryTapDown: (detail) {
                        DataGridMenu().showGridMenu(
                            rendererContext.stateManager, detail, context,
                            data: mapData, exportFileName: exportFileName);
                      },
                      child: Container(
                        color: getColors(rendererContext),
                        height: 30,
                        child: Text(
                          (rendererContext.cell.value ?? "").toString(),
                          style: TextStyle(
                            fontSize: SizeDefine.columnTitleFontSize,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }
                }),
                enableSorting: enableSort,
                enableRowDrag: false,
                enableEditingMode: editKeys != null && editKeys!.contains(key),
                enableDropToResize: true,
                enableContextMenu: false,
                /*width: Utils.getColumnSize(
                  key: key,
                  value: mapData[0][key].toString(),
                ),*/
                minWidth: minimumWidth ?? 25,
                width: (widthSpecificColumn != null &&
                    widthSpecificColumn!.containsKey(key))
                    ? widthSpecificColumn![key]!
                    : Utils.getColumnSize(key: key, value: mapData[0][key]),
                enableAutoEditing: false,
                hide: showonly == null
                    ? (hideKeys != null && hideKeys!.contains(key)) ||
                    hideCode! &&
                        key.toString().toLowerCase() != "hourcode" &&
                        key.toString().toLowerCase().contains("code")
                    : !showonly!.contains(key),
                enableColumnDrag: false,
                field: key,
                type: PlutoColumnType.text()),
          );
        }
      }
    } else {
      for (var key in mapData[0].keys) {
        segColumn.add(PlutoColumn(
            titlePadding: EdgeInsets.only(),
            title: doPasccal
                ? key == "fpcCaption"
                ? "FPC Caption"
                : Utils.normalCaseToPascalCase(key)
                : key,
            enableRowChecked:
            (checkRow == true && key == checkRowKey) ? true : false,
            renderer: ((rendererContext) {
              if (actionIconKey != null) {
                if (key == actionIconKey) {
                  return GestureDetector(
                    child: Icon(
                      actionIcon,
                      size: 19,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      actionOnPress!(rendererContext.rowIdx);
                    },
                  );
                } else {
                  return GestureDetector(
                    onSecondaryTapDown: (detail) {
                      DataGridMenu().showGridMenu(
                          rendererContext.stateManager, detail, context,
                          data: mapData, exportFileName: exportFileName);
                    },
                    child: Container(
                      color: getColors(rendererContext),
                      height: 30,
                      child: Text(
                        rendererContext.cell.value.toString(),
                        style: TextStyle(
                          fontSize: SizeDefine.columnTitleFontSize,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }
              } else {
                return GestureDetector(
                  onSecondaryTapDown: (detail) {
                    DataGridMenu().showGridMenu(
                        rendererContext.stateManager, detail, context,
                        data: mapData, exportFileName: exportFileName);
                  },
                  child: Container(
                    color: getColors(rendererContext),
                    height: 30,
                    child: Text(
                      rendererContext.cell.value.toString(),
                      style: TextStyle(
                        fontSize: SizeDefine.columnTitleFontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }
            }),
            enableSorting: enableSort,
            enableRowDrag: false,
            enableEditingMode: editKeys != null && editKeys!.contains(key),
            enableDropToResize: true,
            enableContextMenu: false,
            // width: Utils.getColumnSize(key: key, value: mapData[0][key]),
            minWidth: minimumWidth ?? 25,
            width: (widthSpecificColumn != null &&
                widthSpecificColumn!.containsKey(key))
                ? widthSpecificColumn![key]!
                : Utils.getColumnSize(key: key, value: mapData[0][key]),
            enableAutoEditing: false,
            hide: showonly == null
                ? (hideKeys != null && hideKeys!.contains(key)) ||
                hideCode! &&
                    key.toString().toLowerCase() != "hourcode" &&
                    key.toString().toLowerCase().contains("code")
                : !showonly!.contains(key),
            enableColumnDrag: false,
            field: key,
            type: PlutoColumnType.text()));
      }
    }

    for (var i = 0; i < mapData.length; i++) {
      Map row = mapData[i];

      Map<String, PlutoCell> cells = {};
      if (showSrNo!) {
        cells["no"] = PlutoCell(value: i + 1);
      }
      try {
        for (var element in row.entries) {
          cells[element.key] = PlutoCell(
            value: element.key == "selected" ||
                element.value == null ||
                (element.value is Map)
                ? ""
                : element.key.toString().toLowerCase().contains("date") &&
                formatDate!
                ? DateFormat(dateFromat).format(DateTime.parse(
                element.value.toString().replaceAll("T", " ")))
                : element.value.toString(),
          );
        }
        segRows.add(PlutoRow(cells: cells, sortIdx: i));
      } catch (e) {
        print("problem in adding rows ${e.toString()}");
      }
    }

    return Scaffold(
      key: rebuildKey,
      body: Focus(
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: false,
        child: PlutoGrid(
            onChanged: onEdit,
            mode: mode ?? PlutoGridMode.normal,
            configuration: plutoGridConfiguration(
                focusNode: focusNode!,
                autoScale: columnAutoResize,
                actionOnPress: actionOnPress,
                actionKey: actionIconKey,
                previousWidgetFN: previousWidgetFN,
                rowHeight: rowHeight,
                headerHeight: headerHeight),
            rowColorCallback: colorCallback,
            onLoaded: (load) {
              if (widthSpecificColumn == null || widthSpecificColumn == {}) {
                load.stateManager.setColumnSizeConfig(PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.none,
                    resizeMode: PlutoResizeMode.normal));
              }

              load.stateManager.setKeepFocus(false);
              if (onload != null) {
                onload!(load);
              }
            },
            columns: segColumn,
            onRowDoubleTap: onRowDoubleTap,
            onSelected: onSelected,
            rows: segRows),
      ),
    );
  }
}



Color getColors(PlutoColumnRendererContext plutoCon) {
  Color color = Colors.white;
  // print(">>>>>>>>>>>>>>>>>>>keyGet ${plutoCon.cell.column.title} - ${plutoCon.rowIdx}");
  // print(">>>>>>>>>>>>>>>>>>>keyGet field ${plutoCon.cell.column.field} - ${plutoCon.rowIdx}");
  try {
    /*if (plutoCon.stateManager.currentRowIdx == plutoCon.rowIdx) {
      color = Colors.deepPurple.shade200;
      return color;
    }*/

    if (plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "Starttime_current".toLowerCase()) {
      DateTime dateTime1 = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-03-28 ${plutoCon.cell.value}");
      String ? dateTimeString = plutoCon
          .stateManager.rows[plutoCon.rowIdx].cells['starttime_Proposed']?.value
          .toString();
      DateTime dateTime2 = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-03-28 ${dateTimeString}");

      // print(">>>>>>>>>> sta dateTime1.isAfter(dateTime2) ${dateTime1} - ${dateTime1.isAfter(dateTime2)} dateTime1.isBefore(dateTime2) ${dateTime2} ${dateTime1.isBefore(dateTime2)}");

      if(dateTime1.isBefore(dateTime2)){
        color = Colors.lightGreen;
      }else{
        color = Colors.white;
      }
      return color;
    }

    if (plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "Starttime_proposed".toLowerCase()) {
      DateTime dateTime1 = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-03-28 ${plutoCon.cell.value}");
      String ? dateTimeString = plutoCon
          .stateManager.rows[plutoCon.rowIdx].cells['starttime_Current']?.value
          .toString();
      DateTime dateTime2 = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-03-28 ${dateTimeString}");

      // print(">>>>>>>>>> sta dateTime1.isAfter(dateTime2) ${dateTime1} - ${dateTime1.isAfter(dateTime2)} dateTime1.isBefore(dateTime2) ${dateTime2} ${dateTime1.isBefore(dateTime2)}");

      if(dateTime1.isBefore(dateTime2)){
        color = Colors.pink;
      }else{
        color = Colors.white;
      }
      return color;
    }

     if(plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "Endtime_proposed".toLowerCase()){

      DateTime dateTime1 = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-03-28 ${plutoCon.cell.value}");
      String ? dateTimeString = plutoCon
          .stateManager.rows[plutoCon.rowIdx].cells['endTime_Current']?.value
          .toString();
      DateTime dateTime2 = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-03-28 ${dateTimeString}");

      print(">>>>>>>>>> sta????? dateTime1.isAfter(dateTime2) ${dateTime1} - ${dateTime1.isAfter(dateTime2)} dateTime1.isBefore(dateTime2) ${dateTime2} ${dateTime1.isBefore(dateTime2)}");


      if(dateTime1.isAfter(dateTime2)){
        color = Colors.lightGreen;
      }else{
        color = Colors.white;
      }
      return color;
    }

    if(plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "Endtime_current".toLowerCase()){

      DateTime dateTime1 = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-03-28 ${plutoCon.cell.value}");
      String ? dateTimeString = plutoCon
          .stateManager.rows[plutoCon.rowIdx].cells['endTime_Proposed']?.value
          .toString();
      DateTime dateTime2 = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-03-28 ${dateTimeString}");

      print(">>>>>>>>>> sta>>> dateTime1.isAfter(dateTime2) ${dateTime1} - ${dateTime1.isAfter(dateTime2)} dateTime1.isBefore(dateTime2) ${dateTime2} ${dateTime1.isBefore(dateTime2)}");


      if(dateTime1.isAfter(dateTime2)){
        color = Colors.lightGreen;
      }else{
        color = Colors.white;
      }
      return color;
    }

    if(plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "seconds_Proposed".toLowerCase()){

      double data1 = getNumType(text: plutoCon.cell.value);
      double data2 = getNumType(text: (plutoCon
          .stateManager.rows[plutoCon.rowIdx].cells['seconds_Current']?.value??"").toString());

      if(data1 > data2){
        color = Colors.lightGreen;
      }else{
        color = Colors.white;
      }
      return color;
    }

     if(plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "Seconds_current".toLowerCase()){


      double data1 = getNumType(text: plutoCon.cell.value);
      double data2 = getNumType(text: (plutoCon
          .stateManager.rows[plutoCon.rowIdx].cells['seconds_Proposed']?.value??"").toString());

      if(data1 > data2){
        color = Colors.lightGreen;
      }else{
        color = Colors.white;
      }
      return color;
    }

    if(plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "rate_Proposed".toLowerCase()){

      double data1 = getNumType(text: plutoCon.cell.value);
      double data2 = getNumType(text: (plutoCon
          .stateManager.rows[plutoCon.rowIdx].cells['rate_current']?.value??"").toString());

      if(data1 > data2){
        color = Colors.lightGreen;
      }else{
        color = Colors.white;
      }
      return color;
    }

     if(plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "Rate_current".toLowerCase()){

       double data1 = getNumType(text: plutoCon.cell.value);
       double data2 = getNumType(text: (plutoCon
           .stateManager.rows[plutoCon.rowIdx].cells['rate_Proposed']?.value??"").toString());

       if(data1 > data2){
         color = Colors.lightGreen;
       }else{
         color = Colors.white;
       }
      return color;
    }

    if(plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "amount_Proposed".toLowerCase()){

      double data1 = getNumType(text: plutoCon.cell.value);
      double data2 = getNumType(text: (plutoCon
          .stateManager.rows[plutoCon.rowIdx].cells['amount_Current']?.value??"").toString());

      if(data1 > data2){
        color = Colors.lightGreen;
      }else{
        color = Colors.white;
      }
      return color;
    }

    if(plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "amount_Current".toLowerCase()){

      double data1 = getNumType(text: plutoCon.cell.value);
      double data2 = getNumType(text: (plutoCon
          .stateManager.rows[plutoCon.rowIdx].cells['amount_Proposed']?.value??"").toString());

      if(data1 > data2){
        color = Colors.lightGreen;
      }else{
        color = Colors.white;
      }

      return color;
    }



    if(plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "valuationRate_Proposed".toLowerCase()){

      double data1 = getNumType(text: plutoCon.cell.value);
      double data2 = getNumType(text: (plutoCon
          .stateManager.rows[plutoCon.rowIdx].cells['valuationRate_Current']?.value??"").toString());

      if(data1 > data2){
        color = Colors.lightGreen;
      }else{
        color = Colors.white;
      }
      return color;
    }

     if(plutoCon.cell.column.title.toString().trim().toLowerCase() ==
        "Valuationrate_current".toLowerCase()){

       double data1 = getNumType(text: plutoCon.cell.value);
       double data2 = getNumType(text: (plutoCon
           .stateManager.rows[plutoCon.rowIdx].cells['valuationRate_Proposed']?.value??"").toString());

       if(data1 > data2){
         color = Colors.lightGreen;
       }else{
         color = Colors.white;
       }
      return color;
    }

     if (plutoCon.stateManager.currentCell == plutoCon.cell) {
      color = Colors.deepPurple.shade200;
      return color;
    }

     color = Colors.white;
     return color;

  } catch (e) {
    if (plutoCon.stateManager.currentCell == plutoCon.cell) {
      color = Colors.deepPurple.shade200;
    } else {
      color = Colors.white;
    }
  }

  return color;
}

double getNumType({String ? text}){
  try{
    if(text != null && text != ""){
      return double.parse(text);
    }else{
      return 0.0;
    }
  }catch(e){
    return 0.0;
  }
}
