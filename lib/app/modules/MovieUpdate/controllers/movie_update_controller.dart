// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../../widgets/LoadingDialog.dart';
// import '../../../../widgets/PlutoGrid/src/manager/pluto_grid_state_manager.dart';
// import '../../../controller/ConnectorControl.dart';
// import '../../../data/DropDownValue.dart';
// import '../../../providers/ApiFactory.dart';

// class MovieUpdateController extends GetxController {
//   //TODO: Implement MovieUpdateController

//   RxList<DropDownValue> locations = RxList<DropDownValue>([]);
//   RxList<DropDownValue> channels = RxList<DropDownValue>([]);
//   RxBool isEnable = RxBool(true);
//   DropDownValue? selectLocation;
//   DropDownValue? selectChannel;
//   TextEditingController scheduleDate=TextEditingController();
//   TextEditingController bookingNumber=TextEditingController();
//   // RxString? selectValue=RxString(null);
//   Rxn<String> selectValue = Rxn<String>(null);

//   List<Map<String, dynamic>> ?responseData ;
//   PlutoGridStateManager? stateManager;
//   bool booked = false;
//   bool onHold = false;
//   bool expsoureSpots = false;

//   getStatus({String ? sel}){
//     switch(sel){
//       case "Booked":
//         booked = true;
//         onHold = false;
//         expsoureSpots = false;
//         break;
//       case "On Hold":
//         booked = false;
//         onHold = true;
//         expsoureSpots = false;
//         break;
//       case "Expsoure Spots":
//         booked = false;
//         onHold = false;
//         expsoureSpots = true;
//         break;
//       default:
//         booked = false;
//         onHold = false;
//         expsoureSpots = false;

//     }
//   }

//   getAllLoadData(){
//     LoadingDialog.call();
//     Get.find<ConnectorControl>().GETMETHODCALL(
//         api: ApiFactory.MOVIE_UPDATE_GET_LOAD,
//         // "https://jsonkeeper.com/b/D537"
//         fun: (map){
//           closeDialogIfOpen();
//           if(map is Map && map.containsKey("loadData") && map['loadData'] != null && map['loadData'].length > 0){
//             locations.clear();
//             RxList<DropDownValue> dataList = RxList<DropDownValue>([]);
//             map['loadData'].forEach((element) {
//               dataList.add(DropDownValue.fromJsonDynamic(element as Map<String, dynamic>, "locationCode", "locationName"));
//             });
//             locations.addAll(dataList);
//             locations.refresh();
//           }else{
//             locations.clear();
//             locations.refresh();
//           }
//         });
//   }

//   getChannelList(String ? locationCode){
//     if(locationCode != null && locationCode != ""){
//       try{
//         LoadingDialog.call();
//         Get.find<ConnectorControl>().GETMETHODCALL(
//             api: ApiFactory.MOVIE_UPDATE_GET_CHANNEL+locationCode,
//             // "https://jsonkeeper.com/b/D537"
//             fun: (map){
//               closeDialogIfOpen();
//               if(map is Map && map.containsKey("location") && map['location'] != null && map['location'].length > 0){
//                 channels.clear();
//                 RxList<DropDownValue> dataList = RxList<DropDownValue>([]);
//                 map['location'].forEach((element) {
//                   dataList.add(DropDownValue.fromJsonDynamic(element as Map<String, dynamic>, "channelCode", "channelName"));
//                 });
//                 channels.addAll(dataList);
//                 channels.refresh();
//               }else{
//                 channels.clear();
//                 channels.refresh();
//               }
//             });
//       }catch(e){
//         closeDialogIfOpen();
//       }
//     }else{

//     }
//   }

//   String dateFormat(String ? date){
//     if(date != null && date != ""){
//       DateTime dateNew = DateFormat("dd-MM-yyyy").parse(date);
//       return DateFormat("yyyy-MM-ddTHH:mm:ss").format(dateNew);
//     }else{
//       return "";
//     }
//   }

//   getShow(){
//     try{
//       Map<String,dynamic> postData =
//       {
//         "hold": onHold,
//         "booked": booked,
//         "exposureaudit": expsoureSpots,
//         "locationcode": selectLocation?.key??"",
//         "channelcode": selectChannel?.key??"",
//         "teldate": dateFormat(scheduleDate.text)?? "",
//         "bookingnumber":bookingNumber.text?? ""
//       };

//       LoadingDialog.call();
//       Get.find<ConnectorControl>().POSTMETHOD(
//           api: ApiFactory.MOVIE_UPDATE_POST_SHOW,
//           json: postData,
//           // "https://jsonkeeper.com/b/D537"
//           fun: (map){
//             closeDialogIfOpen();
//             print("map>>>>>"+map.toString());

//           });
//     }catch(e){
//       closeDialogIfOpen();
//     }
//   }

//   closeDialogIfOpen() {
//     if (Get.isDialogOpen ?? false) {
//       Get.back();
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     getAllLoadData();
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }




//   formHandler(btn) {}

//   void getChannelFocusOut() {}
// }
