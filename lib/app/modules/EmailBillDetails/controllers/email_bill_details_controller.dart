import 'dart:io';

import 'package:bms_creditcontrol/app/data/DropDownValue.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../widgets/LoadingDialog.dart';
import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
import '../../../controller/ConnectorControl.dart';
import '../../../controller/HomeController.dart';
import '../../../providers/ApiFactory.dart';
import '../views/email_bill_details_view.dart';
import 'package:dio/dio.dart' as dio;

import 'dart:html' as html;
// import 'package:file_selector/file_selector.dart';F

class EmailBillDetailsController extends GetxController {
  double widthRatio = 0.24;
  double widthRatio1 = 0.53;
  double widthOfTab = 100;

  String _folderPath = '';

  Rx<Mode> calendarView = Rx<Mode>(Mode.bills);
  Rx<String> selectRadio = Rx<String>("Summary");

  RxBool sendTest = RxBool(true);
  RxBool all1 = RxBool(false);
  RxBool all2 = RxBool(false);

  var companyList = <DropDownValue>[].obs;
  var fromList = <DropDownValue>[].obs;

  DropDownValue? selectedCompany;
  DropDownValue? selectedFrom;

  var gridData = [].obs;

  int inwardLastSelectedIdx = 0;
  List<File> files = [];
  List? billNameList;

  PlutoGridStateManager? stateManager;

  TextEditingController counter1_ = TextEditingController(text: "0");
  TextEditingController counter2_ = TextEditingController(text: "0");

  TextEditingController tecTestTo = TextEditingController();
  TextEditingController tecDate = TextEditingController(text: "30-4-2018");
  // TextEditingController tecDate = TextEditingController();

  TextEditingController tecPath = TextEditingController();
  TextEditingController tecbody = TextEditingController();

  var selectedFile = Rxn<PlatformFile?>();

  // var listFileName = ['swaggerEmailBills.json', 'swaggerBillDetails.json'];

  // List<html.File>? selectedFiles;
  String fileNameFromApi = "";
  var selectedFileNames = "".obs;
  FilePickerResult? multipleFile;
  FilePickerResult? multipleFileForAll;

  // var selectedFilesForAll = [];
  // List<FilePickerResult?> selectedFilesForAll = [];

  List<FilePickerResult?> selectedFilesForAll = [];

  // final List<html.File>? files

  // final SharedPreferences prefs = await SharedPreferences.getInstance();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    onLoad();
  }

  List<String> selectedFiles = [];

  // Future<void> selectFiles() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowMultiple: true,
  //     type: FileType.any,
  //   );

  //   if (result != null) {
  //     List<String> filenames = [
  //       'swaggerCreditControl 2.json',
  //       'swaggerIssueBlankTape1.json'
  //     ];

  //     List<String?> selectedFilepaths = result.paths ?? [];
  //     List<String> matchingFiles = [];

  //     // Filter selected files by filename
  //     selectedFilepaths.forEach((filepath) {
  //       String filename = filepath!.split('/').last; // Get filename from path
  //       if (filenames.contains(filename)) {
  //         matchingFiles.add(filepath);
  //       }
  //     });

  //     // setState(() {
  //     selectedFiles = matchingFiles;
  //     if (result != null) {
  //       for (var file in result.files) {
  //         print("selected file -  ${file.name}"); // Prints the file name
  //         selectedFileNames.value += "${file.name}, ";
  //       }
  //       selectedFileNames.value
  //           .substring(0, selectedFileNames.value.length - 2);
  //       multipleFile = result;

  //     }
  //     // });
  //   } else {
  //     // User canceled the picker
  //   }
  // }

  String dateFormat(String? date) {
    if (date != null && date != "") {
      DateTime dateNew = DateFormat("dd-MM-yyyy").parse(date);
      return DateFormat("yyyy-MM-dd").format(dateNew);
    } else {
      return "";
    }
  }

  // void selectFiles() {
  //   print("select file called");
  //   selectedFileNames.value = '';
  //   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  //   uploadInput.multiple = true; // Allow multiple file selection
  //   // uploadInput.
  //   uploadInput.click(); // Simulate a click on the input element
  //   uploadInput.onChange.listen((e) {
  //     selectedFiles = uploadInput.files;
  //     // Do something with the selected files
  //     if (selectedFiles != null) {
  //       for (var file in selectedFiles!) {
  //         print('Selected file: ${file.name}');
  //         selectedFileNames.value += "${file.name}, ";
  //       }
  //       selectedFileNames.substring(0, selectedFileNames.value.length - 1);
  //       print(selectedFileNames);
  //     }
  //   });
  // }

  pickFiles({required bool fromSendAll}) async {
    selectedFileNames.value = '';
    multipleFile = null;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      for (var file in result.files) {
        print("selected file -  ${file.name}"); // Prints the file name
        selectedFileNames.value += "${file.name}, ";
      }
      selectedFileNames.value.substring(0, selectedFileNames.value.length - 2);
      multipleFile = result;
      if (fromSendAll) {
        // sendBillFilesForAll();
        Get.back();
        // pickFilesToAddInAll();
        // sendAllBillFiles();
        selectFilesForAll(0);
        // pickFilesToAddInAll();
      }
    } else {
      // User canceled the picker
    }
  }

  // pickFilesToAddInAll(int index) async {
  //   // selectedFileNames.value = ';
  //   // multipleFileForAll = null;
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(allowMultiple: true);

  //   if (result != null) {
  //     // for (var file in result.files) {
  //     //   print("selected file -  ${file.name}"); // Prints the file name
  //     //   selectedFileNames.value += "${file.name}, ";
  //     // }
  //     // selectedFileNames.value.substring(0, selectedFileNames.value.length - 2);
  //     // multipleFileForAll = result;
  //     selectedFilesForAll[index] = result;
  //     // if (fromSendAll) {
  //     //   // sendBillFilesForAll();
  //     //   sendAllBillFiles();
  //     // }
  //     // return multipleFileForAll;
  //   } else {
  //     // User canceled the picker
  //   }
  // }

//   void selectSpecificFiles() {
//   // List of file names to select
//   var listFileName = ['swaggerEmailBills.json', 'swaggerBillDetails.json'];

//   // Create a FileList from the file names
//   // var fileList = html.FileList.f
//   var fileList = html.FileList.from(listFileName.map((fileName) => html.File(fileName)));

//   // Create a FileUploadInputElement and set its files
//   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//   uploadInput.files = fileList;

//   // Process the selected files
//   processSelectedFiles(uploadInput.files);
// }

// void processSelectedFiles(html.FileList files) {
//   // Do something with the selected files
//   for (var file in files) {
//     print('Selected file: ${file.name}');
//   }
// }

  // void selectFiles() {
  //   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  //   uploadInput.multiple = true; // Allow multiple file selection
  //   uploadInput.click(); // Simulate a click on the input element
  //   // for (var i = 0; i < listFileName.length; i++) {

  //   // }
  //   uploadInput.onChange.listen((e) {
  //     final List<html.File>? files = uploadInput.files;
  //     // Do something with the selected files
  //     for (var file in files!) {
  //       print('Selected file: ${file.name}');
  //     }
  //   });
  // }

//   void selectSpecificFiles() {
//   // List of file names to select
//   var listFileName = ['swaggerEmailBills.json', 'swaggerBillDetails.json'];

//   // Create a FileList from the file names
//   var fileList = html.FileList.from(listFileName.map((fileName) => html.File(fileName)));

//   // Create a FileUploadInputElement and set its files
//   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
//   uploadInput.files = fileList;

//   // Process the selected files
//   processSelectedFiles(uploadInput.files);
// }

  void processSelectedFiles(html.FileList files) {
    // Do something with the selected files
    for (var file in files) {
      print('Selected file: ${file.name}');
    }
  }

  handleactionOnPressChangeInward(
      PlutoGridCellPosition position, bool isSpaceCalled) {
    inwardLastSelectedIdx =
        stateManager?.refRows[position.rowIdx ?? 0].sortIdx ?? 0;
    if (isSpaceCalled) {
      if (stateManager != null) {
        stateManager?.changeCellValue(
          stateManager!.currentCell!,
          stateManager!.currentCell!.value == "true" ? "false" : "true",
          force: true,
          callOnChangedEvent: true,
          notify: true,
        );
      }
    }
  }

  // on

  onSaveConfig({required bool showDailog}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('saveConfigData', <String>[
      selectedFrom?.value ?? "",
      tecTestTo.text,
      tecPath.text,
      tecbody.text
    ]);
    if (showDailog) {
      LoadingDialog.callDataSaved(msg: "Saved successfully");
    }

    // LoadingDialog.callErrorMessage("saved");
  }

  loadConfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? savedConfigData = prefs.getStringList('saveConfigData');

    // savedConfigData
    if (savedConfigData != null) {
      for (var i = 0; i < fromList.value.length; i++) {
        print("e value ${fromList.value[i].value}");
        if (fromList.value[i].value == savedConfigData[0]) {
          selectedFrom = fromList.value[i];
          fromList.refresh();
        }
      }
      tecTestTo.text = savedConfigData[1];
      tecPath.text = savedConfigData[2];
      tecbody.text = savedConfigData[3];
    }
    // LoadingDialog.showErrorDialog("loaded");
    // await prefs.setStringList('saveConfigData', <String>[
    //   selectedFrom?.value ?? "",
    //   tecTestTo.text,
    //   tecPath.text,
    //   tecbody.text
    // ]);
  }

//   Future<void> _saveTextToFile(String text) async {
//     try {
//       if (kIsWeb) {
//     // Set web-specific directory
// }
//       final directory = await getApplicationDocumentsDirectory();
//       print("path ${directory.path}");
//       final file = File('${directory.path}/my_text_file.txt');
//       await file.writeAsString(text);
//       LoadingDialog.showErrorDialog('Text saved to file successfully');
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(
//       //     content: Text('Text saved to file successfully'),
//       //   ),
//       // );
//     } catch (e) {
//       LoadingDialog.showErrorDialog('Failed to save text to file: $e');

//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(
//       //     content: Text('Failed to save text to file: $e'),
//       //   ),
//       // );
//     }
//   }

  // Future<void> saveTextFieldValue(String text) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/textValue.txt');
  //   await file.writeAsString(text);
  // }

  onLoad() {
    LoadingDialog.call();
    Get.find<ConnectorControl>().GETMETHODCALL(
        api: ApiFactory.EMAIL_BILL_DETAILS_ONLOAD,
        // "https://jsonkeeper.com/b/D537"
        fun: (map) {
          closeDialogIfOpen();
          if (map is Map &&
              map.containsKey("onload") &&
              map['onload'] != null) {
            //company list
            if (map["onload"]["companyModels"] != null &&
                map["onload"]["companyModels"].isNotEmpty) {
              map['onload']["companyModels"].forEach((e) {
                companyList.add(DropDownValue(
                    key: e["sapCompanycode"], value: e["companyname"]));
                // cityList.add(
                //     DropDownValue(key: e["placecode"], value: e["placename"]));
              });
            }
            //from list
            if (map["onload"]["fromEmailsModels"] != null &&
                map["onload"]["fromEmailsModels"].isNotEmpty) {
              map['onload']["fromEmailsModels"].forEach((e) {
                fromList.add(
                    DropDownValue(key: e["formCode"], value: e["emailID"]));
                // cityList.add(
                //     DropDownValue(key: e["placecode"], value: e["placename"]));
              });
              // selectedFrom = fromList.last;
              // update(["d"]);
              // fromList.refresh();
            }
            loadConfig();
          }
        },
        failed: (map) {
          LoadingDialog.showErrorDialog(map);
        });
  }

  onGenerate() {
    var model = {
      "companyCode": selectedCompany!.key ?? "",
      "billdate": dateFormat(tecDate.text)
    };
    LoadingDialog.call();
    Get.find<ConnectorControl>().POSTMETHOD(
      api: ApiFactory.EMAIL_BILL_DETAILS_GENERATE,
      json: model,
      fun: (resp) {
        closeDialogIfOpen();
        if (resp is Map<String, dynamic> &&
            resp.toString().contains("generate") &&
            resp["generate"] != null &&
            resp["generate"].isNotEmpty) {
          // resp["generate"]
          gridData.value = resp["generate"];
          gridData.value.map((e) {
            e["selected"] = e["selected"].toString();
            return e;
          }).toList();
          // if (responseData.value.isNotEmpty) {
          //       responseData.value.map((e) {
          //         e["scheduledate"] = DateFormat("dd-MM-yyyy").format(
          //             DateFormat("yyyy-MM-ddThh:mm:ss")
          //                 .parse(e["scheduledate"]));
          //         return e;
          //       }).toList();
          //     }
        }
      },
      failed: (resp) {
        closeDialogIfOpen();
        LoadingDialog.showErrorDialog(resp);
      },
    );
  }

  void callChangeAllFromTo({
    required bool isChecked,
    required int txtToRowValue,
    required int txtFromNoValue,
  }) {
    int j;
    if (txtToRowValue > gridData.length) {
      j = gridData.length;
    } else {
      j = txtToRowValue;
    }
    for (int i = txtFromNoValue; i <= j; i++) {
      if (i > 0) {
        gridData.value[stateManager!.refRows[i - 1].sortIdx]['selected'] =
            isChecked.toString();
        stateManager!.changeCellValue(
          stateManager!.getRowByIdx(i - 1)!.cells['selected']!,
          isChecked.toString(),
          callOnChangedEvent: false,
          force: true,
          notify: true,
        );
      }

      // print(responseData);
      // gridData.refresh();
    }
  }

  onSummary() {
    var summaryDetails = [];
    gridData.asMap().forEach((index, e) {
      // print
      if (e["selected"].toString() == "true") {
        summaryDetails.add({
          "rowNo": index,
          "locationcode": e["locationcode"],
          "channelcode": e["channelCode"],
          "clientcode": e["clientCode"],
          "clientName": e["clientName"],
          "agencycode": e["agencyCode"],
          "agencyName": e["agencyName"],
          "mailTo": e["mailto"]
        });
      }
    });
    if (selectedFrom == null) {
      LoadingDialog.showErrorDialog("Please select From");
    } else if (tecTestTo.text.isEmpty) {
      LoadingDialog.showErrorDialog("Test to cannot be empty");
    } else if (summaryDetails.isEmpty) {
      LoadingDialog.showErrorDialog("Please select data from grid");
    } else {
      var model = {
        "companyCode": selectedCompany?.key ?? "",
        "companyName": selectedCompany?.value ?? "",
        "billdate": dateFormat(tecDate.text),
        "details": summaryDetails,
        "testMailFrom": selectedFrom?.value ?? "",
        "testMailTo": tecTestTo.text,
        "testMailBody": tecbody.text,
        "isEmailSendTest": sendTest.value
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.EMAIL_BILL_DETAILS_SUMMARY,
        json: model,
        fun: (resp) {
          closeDialogIfOpen();
          if (resp != null && resp is Map<String, dynamic>) {
            if (resp.toString().contains("successfully")) {
              LoadingDialog.callDataSaved(
                msg: resp["summary"]["message"],
                callback: () {
                  // callClear();
                },
              );
            } else {
              LoadingDialog.showErrorDialog(resp["summary"]["message"]);
            }
          }
        },
        failed: (resp) {
          closeDialogIfOpen();

          LoadingDialog.showErrorDialog(resp);
        },
      );
    }

    // var summaryDetails = [];
    // gridData.asMap().forEach((index, e) {
    //   // print
    //   if (e["selected"].toString() == "true") {
    //     summaryDetails.add({
    //       "rowNo": index,
    //       "locationcode": e["locationcode"],
    //       "channelcode": e["channelCode"],
    //       "clientcode": e["clientCode"],
    //       "clientName": e["clientName"],
    //       "agencycode": e["agencyCode"],
    //       "agencyName": e["agencyName"],
    //       "mailTo": e["mailto"]
    //     });
    //   }
    // });
    // gridData.map((e) {
    //   if (e["selected"]) {
    //     summaryDetails.add({
    //       "rowNo": index,
    //       "locationcode": "<string>",
    //       "channelcode": "<string>",
    //       "clientcode": "<string>",
    //       "clientName": "<string>",
    //       "agencycode": "<string>",
    //       "agencyName": "<string>",
    //       "mailTo": "<string>"
    //     });
    //   }
    // });
  }

  onBills(bool isBills) {
    onSaveConfig(showDailog: false);
    fileNameFromApi = "";
    selectedFileNames.value = "";
    var billsDetails = [];
    gridData.asMap().forEach((index, e) {
      if (e["selected"].toString() == "true") {
        billsDetails.add({
          "rowNo": index,
          "locationcode": e["locationcode"],
          "channelcode": e["channelCode"],
          "clientcode": e["clientCode"],
          "clientName": e["clientName"],
          "agencycode": e["agencyCode"],
          "agencyName": e["agencyName"],
          "mailTo": e["mailto"]
        });
      }
    });
    if (selectedFrom == null) {
      LoadingDialog.showErrorDialog("Please select From");
    } else if (tecTestTo.text.isEmpty) {
      LoadingDialog.showErrorDialog("Test to cannot be empty");
    } else if (billsDetails.isEmpty) {
      LoadingDialog.showErrorDialog("Please select data from grid");
    } else {
      var model = {
        "companyCode": selectedCompany?.key ?? "",
        "companyName": selectedCompany?.value ?? "",
        "billdate": dateFormat(tecDate.text),
        "details": billsDetails,
        "testMailFrom": selectedFrom?.value ?? "",
        "testMailTo": tecTestTo.text,
        "testMailBody": tecbody.text,
      };
      LoadingDialog.call();
      Get.find<ConnectorControl>().POSTMETHOD(
        api: ApiFactory.EMAIL_BILL_DETAILS_BILLS,
        json: model,
        fun: (resp) {
          closeDialogIfOpen();
          if (resp != null &&
              resp is Map<String, dynamic> &&
              resp.toString().contains("bills") &&
              resp["bills"].isNotEmpty) {
            billNameList = resp["bills"];
            for (var i = 0; i < billNameList!.length; i++) {
              fileNameFromApi +=
                  "${resp["bills"][i]["pdfInfo"][0]["invoiceFileName"]}, ";
            }
            fileNameFromApi =
                fileNameFromApi.substring(0, fileNameFromApi.length - 1);

            // if (isBills) {
            LoadingDialog.selectFileDailog(
              "Select the followig files",
              fileNameFromApi,
              controllerX: Get.put<EmailBillDetailsController>(
                  EmailBillDetailsController()),
              fun1: () {
                pickFiles(fromSendAll: false);
              },
              fun2: () {
                Get.back();
                if (isBills) {
                  sendBillFiles();
                } else {
                  sendAllBillFiles();
                }
              },
              fun1Title: "Select Files",
              fun2Title: "Send Files",
            );
            // }
            // else {
            //   LoadingDialog.selectFileDailog(
            //     "Select the followig files",
            //     fileNameFromApi,
            //     controllerX: Get.put<EmailBillDetailsController>(
            //         EmailBillDetailsController()),
            //     showOneButton: true,
            //     fun1: () {
            //       pickFiles(fromSendAll: true);
            //     },
            //     fun2: () {},
            //     fun1Title: "Select Files",
            //     fun2Title: "",
            //   );
            // }
          }
        },
        failed: (resp) {
          closeDialogIfOpen();

          LoadingDialog.showErrorDialog(resp);
        },
      );
    }
  }

  sendBillFiles() async {
    LoadingDialog.call();
    dio.FormData formData = dio.FormData.fromMap({
      "companyCode": selectedCompany?.key ?? "",
      "companyName": selectedCompany?.value ?? "",
      "billdate": dateFormat(tecDate.text),
      "testMailFrom": selectedFrom?.value ?? "",
      "testMailTo": tecTestTo.text,
      "testMailBody": tecbody.text,
      "isEmailSendTest": sendTest.value,
      // "files": sendBillsDetails,
      // "files": selectedFiles
    });

    gridData.asMap().forEach((index, e) {
      // var formData2 = dio.FormData();
      if (e["selected"].toString() == "true") {
        formData.fields.add(MapEntry(
          'files[$index].clientName',
          e["clientName"],
        ));
        formData.fields.add(MapEntry(
          'files[$index].agencyName',
          e["agencyName"],
        ));
        formData.fields.add(MapEntry(
          'files[$index].mailTo',
          ((e["mailto"] != null && e["mailto"] != "")
              ? e["mailto"]
              : tecTestTo.text),
        ));
        formData.fields.add(MapEntry(
          'files[$index].ChannelName',
          (e["channel"]),
        ));
        // if (multipleFile!.files.length >= (index + 1)) {
        //   formData.files.add(MapEntry(
        //     'files[$index].files',
        //     dio.MultipartFile.fromBytes(
        //       multipleFile!.files[index].bytes!.toList(),
        //       filename: multipleFile!.files[index].name,
        //     ),
        //   ));
        // }

        for (var i = 0; i < multipleFile!.files.length; i++) {
          if (billNameList![index]["pdfInfo"][0]['invoiceFileName'] ==
              multipleFile!.files[i].name) {
            formData.files.add(MapEntry(
              'files[$index].files',
              dio.MultipartFile.fromBytes(
                multipleFile!.files[i].bytes!.toList(),
                filename: multipleFile!.files[i].name,
              ),
            ));
          }
        }
      }
    });

    Get.find<ConnectorControl>().POSTMETHOD_FORMDATA(
      api: ApiFactory.EMAIL_BILL_DETAILS_GET_BILL_FILES,
      json: formData,
      fun: (value) {
        Get.back();

        if (value is Map && value.toString().contains("successfully")) {
          // LoadingDialog.callDataSaved()
          LoadingDialog.callDataSaved(
            msg: value["bills"],
            callback: () {},
          );
          // if (value["asrunDetails"]["lstTempResponse"]
          //         ['lstSaveTempDetailResponse'] !=
          //     null) {
          //   asrunData = <AsRunData>[];
          //   value["asrunDetails"]["lstTempResponse"]
          //           ['lstSaveTempDetailResponse']
          //       .forEach((v) {
          //     asrunData!.add(AsRunData.fromJson(v));
          //   });
          // }
          // update(["fpcData"]);
          // if (value["asrunDetails"]["lstTempResponse"]['showPopup'] != null &&
          //     value["asrunDetails"]["lstTempResponse"]['showPopup']
          //         ["isCheck"]) {
          //   LoadingDialog.callInfoMessage(value["asrunDetails"]
          //       ["lstTempResponse"]['showPopup']["message"]);
          // }
        }

        // update(["transButtons"]);
      },
    );
  }

  selectFilesForAll(int i) async {
    if (i < billNameList!.length) {
      stateManager!.setCurrentCell(
        stateManager!.getRowByIdx(billNameList![i]["rowNo"])?.cells['selected'],
        // tabelLinkDealGrid!.getRowByIdx(i)?.cells['groupValuationRate']
        billNameList![i]["rowNo"],
        notify: true,
      );
      if (i == (billNameList!.length - 1)) {
        LoadingDialog.selectFileDailog(
          "Select the files",
          "",
          controllerX:
              Get.put<EmailBillDetailsController>(EmailBillDetailsController()),
          // showOneButton: true,
          hideSelectedName: true,
          fun1: () {
            // pickFiles(fromSendAll: true);
            pickFilesToAddInAll(i);
          },
          fun2: () {
            Get.back();
            sendAllBillFiles();
          },
          fun1Title: "Select Files",
          fun2Title: "Send Files",
        );
      } else {
        LoadingDialog.selectFileDailog(
          "Select the files",
          "",
          controllerX:
              Get.put<EmailBillDetailsController>(EmailBillDetailsController()),
          showOneButton: true,
          hideSelectedName: true,
          fun1: () {
            // pickFiles(fromSendAll: true);
            pickFilesToAddInAll(i);
          },
          fun2: () {},
          fun1Title: "Select Files",
          fun2Title: "",
        );
      }
    }
    print("selectFilesForAll");
    // for (var i = 0; i < billNameList!.length; i++) {

    // }
    // sendAllBillFiles();
  }

  // List<FilePickerResult?> selectedFilesForAll = [];

// Function to pick files for a specific index
  Future<void> pickFilesToAddInAll(int index) async {
    print("======> Open");
    // for (var i = 0; i < billNameList!.length; i++) {
    //   print(i);
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      // selectedFilesForAll[index] = result;
      selectedFilesForAll.add(result);
      if (index < (billNameList!.length - 1)) {
        Get.back();
      }
      // Get.back();
      selectFilesForAll(index + 1);
      // pickFilesToAddInAll(index++);
    } else {
      selectedFilesForAll.add(result);
      if (index < (billNameList!.length - 1)) {
        Get.back();
      }
      selectFilesForAll(index + 1);

      // pickFilesToAddInAll(index++);

      // User canceled the picker
    }
    // }
    // if (index < billNameList!.length) {
    //   FilePickerResult? result =
    //       await FilePicker.platform.pickFiles(allowMultiple: true);

    //   if (result != null) {
    //     // selectedFilesForAll[index] = result;
    //     selectedFilesForAll.add(result);
    //     pickFilesToAddInAll(index++);
    //   } else {
    //     selectedFilesForAll.add(result);
    //     pickFilesToAddInAll(index++);

    //     // User canceled the picker
    //   }
    // }
  }

// Function to select files for all indices
  // Future<void> selectFilesForAll() async {
  //   print("selectFilesForAll");
  //   print(billNameList!.length);
  //   pickFilesToAddInAll(0);
  //   // print(${billNameList!.length});
  //   // for (var i = 0; i < billNameList!.length; i++) {
  //   //   await pickFilesToAddInAll(i);
  //   // }
  // }

  sendAllBillFiles() async {
    // for (var element in listFileName) {
    //   element[]
    // }
    LoadingDialog.call();
    dio.FormData formData = dio.FormData.fromMap({
      "companyCode": selectedCompany?.key ?? "",
      "companyName": selectedCompany?.value ?? "",
      "billdate": dateFormat(tecDate.text),
      "testMailFrom": selectedFrom?.value ?? "",
      "testMailTo": tecTestTo.text,
      "testMailBody": tecbody.text,
      "isEmailSendTest": sendTest.value,
      // "files": sendBillsDetails,
      // "files": selectedFiles
    });

    gridData.asMap().forEach((index, e) async {
      // var formData2 = dio.FormData();
      if (e["selected"].toString() == "true") {
        formData.fields.add(MapEntry(
          'files[$index].clientName',
          e["clientName"],
        ));
        formData.fields.add(MapEntry(
          'files[$index].agencyName',
          e["agencyName"],
        ));
        formData.fields.add(MapEntry(
          'files[$index].mailTo',
          ((e["mailto"] != null && e["mailto"] != "")
              ? e["mailto"]
              : tecTestTo.text),
        ));
        formData.fields.add(MapEntry(
          'files[$index].ChannelName',
          (e["channel"]),
        ));
        formData.fields.add(MapEntry(
          'files[$index].ChannelName',
          (e["channel"]),
        ));
        // add more
        formData.fields.add(MapEntry(
          'files[$index].agencycode',
          (e["agencyCode"]),
        ));
        formData.fields.add(MapEntry(
          'files[$index].clientcode',
          (e["clientCode"]),
        ));
        formData.fields.add(MapEntry(
          'files[$index].channelcode',
          (e["channelCode"]),
        ));
        formData.fields.add(MapEntry(
          'files[$index].locationcode',
          (e["locationcode"]),
        ));

        for (var i = 0; i < multipleFile!.files.length; i++) {
          if (billNameList![index]["pdfInfo"][0]['invoiceFileName'] ==
              multipleFile!.files[i].name) {
            formData.files.add(MapEntry(
              'files[$index].files',
              dio.MultipartFile.fromBytes(
                multipleFile!.files[i].bytes!.toList(),
                filename: multipleFile!.files[i].name,
              ),
            ));
          }
        }

        // for (var i = 0; i < selectedFilesForAll[index]!.files.length; i++) {
        //   formData.files.add(MapEntry(
        //       "files[$index].ExtraFiles",
        //       dio.MultipartFile.fromBytes(
        //         selectedFilesForAll[index]!.files[i].bytes!.toList(),
        //         filename: selectedFilesForAll[index]!.files[i].name,
        //       )));
        // }

        // callChangeAllFromTo() {}

        // var fileList = [];
        // if (selectedFilesForAll[index] != null) {
        //   for (var i = 0; i < selectedFilesForAll[index]!.files.length; i++) {
        //     fileList.add(
        //       dio.MultipartFile.fromBytes(
        //         selectedFilesForAll[index]!.files[i].bytes!.toList(),
        //         filename: selectedFilesForAll[index]!.files[i].name,
        //       ),
        //     );
        //   }
        //   formData.files.add(MapEntry(
        //       'files[$index].ExtraFiles', fileList as dio.MultipartFile));
        // }

        // if (multipleFile!.files.length >= (index + 1)) {
        //   formData.files.add(MapEntry(
        //     'files[$index].files',
        //     dio.MultipartFile.fromBytes(
        //       multipleFile!.files[index].bytes!.toList(),
        //       filename: multipleFile!.files[index].name,
        //     ),
        //   ));
        // }

        // pickFiles(fromSendAll: fromSendAll);
        // pickFiles(fromSendAll: )

        // await pickFilesToAddInAll();

        // Get.back();

        // var fileList = [];
        // print(
        //     "selected files selected filesselected filesselected filesselected filesselected files");
        // print(selectedFilesForAll);
        // if (selectedFilesForAll[index] != null) {
        //   selectedFilesForAll[index].
        //   // fileList.add(dio.MultipartFile.fromBytes(
        //   //     multipleFile!.files[i].bytes!.toList(),
        //   //     filename: multipleFile!.files[i].name,
        //   //   ))
        // }
        // if (selectedFilesForAll[index] != null) {
        //   fileList.add(dio.MultipartFile.fromBytes(
        //       multipleFile!.files[i].bytes!.toList(),
        //       filename: multipleFile!.files[i].name,
        //     ));
        // }
        // for (var i = 0; i < multipleFile!.files.length; i++) {
        //   if (billNameList![index]["pdfInfo"][0]['invoiceFileName'] ==
        //       multipleFile!.files[i].name) {
        //     fileList.add(dio.MultipartFile.fromBytes(
        //       multipleFile!.files[i].bytes!.toList(),
        //       filename: multipleFile!.files[i].name,
        //     ));
        //     // formData.files.add(MapEntry(
        //     //   'files[$index].files',
        //     //   dio.MultipartFile.fromBytes(
        //     //     multipleFile!.files[i].bytes!.toList(),
        //     //     filename: multipleFile!.files[i].name,
        //     //   ),
        //     // ));
        //   }
        // }
        // fileList.add(selectedFilesForAll[index]);
        // // for (var i = 0; i < multipleFileForAll!.files.length; i++) {
        // //   // if (billNameList![index]["pdfInfo"][0]['invoiceFileName'] ==
        // //   //     multipleFile!.files[i].name) {
        // //   fileList.add(dio.MultipartFile.fromBytes(
        // //     multipleFileForAll!.files[i].bytes!.toList(),
        // //     filename: multipleFileForAll!.files[i].name,
        // //   ));
        // //   // formData.files.add(MapEntry(
        // //   //   'files[$index].files',
        // //   //   dio.MultipartFile.fromBytes(
        // //   //     multipleFile!.files[i].bytes!.toList(),
        // //   //     filename: multipleFile!.files[i].name,
        // //   //   ),
        // //   // ));
        // //   // }
        // // }
        // print(fileList);
        // formData.files.add(
        //     MapEntry('files[$index].files', fileList as dio.MultipartFile));
      }
    });

    Get.find<ConnectorControl>().POSTMETHOD_FORMDATA(
      api: ApiFactory.EMAIL_BILL_DETAILS_GET_BILL_FILES_ALL,
      json: formData,
      fun: (value) {
        Get.back();

        if (value is Map && value.toString().contains("successfully")) {
          // LoadingDialog.callDataSaved()
          LoadingDialog.callDataSaved(
            msg: value["bills"],
            callback: () {},
          );
          // if (value["asrunDetails"]["lstTempResponse"]
          //         ['lstSaveTempDetailResponse'] !=
          //     null) {
          //   asrunData = <AsRunData>[];
          //   value["asrunDetails"]["lstTempResponse"]
          //           ['lstSaveTempDetailResponse']
          //       .forEach((v) {
          //     asrunData!.add(AsRunData.fromJson(v));
          //   });
          // }
          // update(["fpcData"]);
          // if (value["asrunDetails"]["lstTempResponse"]['showPopup'] != null &&
          //     value["asrunDetails"]["lstTempResponse"]['showPopup']
          //         ["isCheck"]) {
          //   LoadingDialog.callInfoMessage(value["asrunDetails"]
          //       ["lstTempResponse"]['showPopup']["message"]);
          // }
        }

        // if (value is Map &&
        //     value.containsKey("bills") &&
        //     value["bills"] != null) {
        //   LoadingDialog.callDataSaved(
        //     msg: value["bills"],
        //     callback: () {},
        //   );
        //   // if (value["asrunDetails"]["lstTempResponse"]
        //   //         ['lstSaveTempDetailResponse'] !=
        //   //     null) {
        //   //   asrunData = <AsRunData>[];
        //   //   value["asrunDetails"]["lstTempResponse"]
        //   //           ['lstSaveTempDetailResponse']
        //   //       .forEach((v) {
        //   //     asrunData!.add(AsRunData.fromJson(v));
        //   //   });
        //   // }
        //   // update(["fpcData"]);
        //   // if (value["asrunDetails"]["lstTempResponse"]['showPopup'] != null &&
        //   //     value["asrunDetails"]["lstTempResponse"]['showPopup']
        //   //         ["isCheck"]) {
        //   //   LoadingDialog.callInfoMessage(value["asrunDetails"]
        //   //       ["lstTempResponse"]['showPopup']["message"]);
        //   // }
        // }

        // update(["transButtons"]);
      },
    );
  }

  selectUnselectAll() {
    for (var i = 0; i < gridData.value.length; i++) {
      gridData.value[i]["selected"] = all1.value;
      stateManager!.changeCellValue(
        stateManager!.getRowByIdx(i)!.cells['selected']!,
        all1.value.toString(),
        callOnChangedEvent: false,
        force: true,
        notify: true,
      );

      // gridData!.changeCellValue(
      //                 mgSpotTabelGrid!
      //                     .getRowByIdx(i)!
      //                     .cells['selectRow']!,
      //                 controllsEnable.value.toString(),
      //                 callOnChangedEvent: false,
      //                 force: true,
      //                 notify: true,
      //               );
      // return ;
    }

    gridData.refresh();
    print("object");
  }

  // sendBillFilesForAll() async {
  //   var sendBillsDetailsForAll = [];
  //   gridData.asMap().forEach((index, e) {
  //     if (e["selected"]) {
  //       sendBillsDetailsForAll.add({
  //         "clientName": e["clientName"],
  //         "agencyName": e["agencyName"],
  //         "files": dio.MultipartFile.fromBytes(
  //             multipleFile!.files[index].bytes!.toList(),
  //             filename: multipleFile!.files[index].name),
  //         "channelName": e["channel"],
  //         "mailTo": e["mailto"]
  //       });
  //     }
  //   });
  //   // "files": multipleFile!.files.map((e) {
  //   //         return dio.MultipartFile.fromBytes(
  //   //           e.bytes!.toList(),
  //   //           filename: e.name,
  //   //         );
  //   //       }).toList(),
  //   LoadingDialog.call();
  //   dio.FormData formData = dio.FormData.fromMap({
  //     "companyCode": selectedCompany?.key ?? "",
  //     "companyName": selectedCompany?.value ?? "",
  //     "billdate": dateFormat(tecDate.text),
  //     "testMailFrom": selectedFrom?.value ?? "",
  //     "testMailTo": tecTestTo.text,
  //     "testMailBody": tecbody.text,
  //     "isEmailSendTest": sendTest.value,
  //     "files": sendBillsDetailsForAll,
  //     // "files": selectedFiles
  //   });

  //   Get.find<ConnectorControl>().POSTMETHOD_FORMDATA(
  //     api: ApiFactory.EMAIL_BILL_DETAILS_GET_BILL_FILES,
  //     json: formData,
  //     fun: (value) {
  //       Get.back();
  //       // if (value is Map && value.containsKey("asrunDetails")) {
  //       //   if (value["asrunDetails"]["lstTempResponse"]
  //       //           ['lstSaveTempDetailResponse'] !=
  //       //       null) {
  //       //     asrunData = <AsRunData>[];
  //       //     value["asrunDetails"]["lstTempResponse"]
  //       //             ['lstSaveTempDetailResponse']
  //       //         .forEach((v) {
  //       //       asrunData!.add(AsRunData.fromJson(v));
  //       //     });
  //       //   }
  //       //   update(["fpcData"]);
  //       //   if (value["asrunDetails"]["lstTempResponse"]['showPopup'] != null &&
  //       //       value["asrunDetails"]["lstTempResponse"]['showPopup']
  //       //           ["isCheck"]) {
  //       //     LoadingDialog.callInfoMessage(value["asrunDetails"]
  //       //         ["lstTempResponse"]['showPopup']["message"]);
  //       //   }
  //       // }

  //       // update(["transButtons"]);
  //     },
  //   );
  // }

  // getBillFiles() {
  //   var model = {
  //     "companyCode": selectedCompany?.key ?? "",
  //     "companyName": selectedCompany?.value ?? "",
  //     "billdate": "<dateTime>",
  //     "details": [
  //       {
  //         "rowNo": "<integer>",
  //         "locationcode": "<string>",
  //         "channelcode": "<string>",
  //         "clientcode": "<string>",
  //         "clientName": "<string>",
  //         "agencycode": "<string>",
  //         "agencyName": "<string>",
  //         "mailTo": "<string>"
  //       },
  //       {
  //         "rowNo": "<integer>",
  //         "locationcode": "<string>",
  //         "channelcode": "<string>",
  //         "clientcode": "<string>",
  //         "clientName": "<string>",
  //         "agencycode": "<string>",
  //         "agencyName": "<string>",
  //         "mailTo": "<string>"
  //       }
  //     ],
  //     "testMailFrom": "<string>",
  //     "testMailTo": "<string>",
  //     "testMailBody": "<string>"
  //   };
  //   LoadingDialog.call();
  //   Get.find<ConnectorControl>().POSTMETHOD(
  //     api: ApiFactory.EMAIL_BILL_DETAILS_BILLS,
  //     json: model,
  //     fun: (resp) {
  //       closeDialogIfOpen();
  //       // if (resp != null &&
  //       //     resp is Map<String, dynamic> &&
  //       //     resp.toString().contains("successfully")) {
  //       //   LoadingDialog.callDataSaved(
  //       //     msg: resp["message"],
  //       //     callback: () {
  //       //       callClear();
  //       //     },
  //       //   );
  //       // }
  //     },
  //     failed: (resp) {
  //       closeDialogIfOpen();

  //       LoadingDialog.showErrorDialog(resp);
  //     },
  //   );
  // }

  closeDialogIfOpen() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  formHandler(btn) {
    switch (btn) {
      case "Clear":
        // callClear() {

        Get.delete<EmailBillDetailsController>();
        Get.find<HomeController>().clearPage1();
        // }
        break;
      case "Save":
        break;
      case "Delete":
        break;
      case "Refresh":
        break;
      case "Exit":
        print("Im in Exit");
        try {
          // Get.find<HomeController>().postUserGridSetting1(listStateManager: [
          //   sm,
          // ]);
        } catch (e) {
          print("Exit Error ===>" + e.toString());
        }
        break;
      case "Docs":
        break;
      case "Search":
        break;
    }
  }
}
