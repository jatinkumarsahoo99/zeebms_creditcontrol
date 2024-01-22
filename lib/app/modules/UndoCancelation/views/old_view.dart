// import 'package:bms_creditcontrol/widgets/CheckBoxWidget.dart';
// import 'package:bms_creditcontrol/widgets/radio_row.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import '../../../../widgets/DateTime/DateWithThreeTextField.dart';
// import '../../../../widgets/FormButton.dart';
// import '../../../../widgets/dropdown.dart';
// import '../../../../widgets/input_fields.dart';
// import '../../../../widgets/radio_row1.dart';
// import '../../../controller/HomeController.dart';
// import '../../../routes/app_pages.dart';
// import '../controllers/undo_cancelation_controller.dart';

// class UndoCancelationView extends GetView<UndoCancelationController> {
//   UndoCancelationView({Key? key}) : super(key: key);

//   final controller =
//       Get.put<UndoCancelationController>(UndoCancelationController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GetBuilder(
//       init: controller,
//       builder: (controller) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 runSpacing: 10,
//                 spacing: 10,
//                 children: [
//                   DropDownField.formDropDown1WidthMap(
//                     [],
//                     (value) {},
//                     "Location",
//                     .17,
//                     autoFocus: true,
//                     titleInLeft: true,
//                   ),
//                   // SizedBox(
//                   //   width: 5,
//                   // ),
//                   DropDownField.formDropDown1WidthMap(
//                     [],
//                     (data) {},
//                     "Channel",
//                     titleInLeft: true,
//                     .17,
//                   ),
//                   // SizedBox(
//                   //   width: 5,
//                   // ),
//                   DateWithThreeTextField(
//                     title: "Tele Date",
//                     mainTextController: TextEditingController(),
//                     widthRation: .135,
//                     titleInLeft: true,
//                   ),

//                   SizedBox(
//                     width: 300,
//                     child: InputFields.formFieldExpand2(
//                       hintTxt: "Booking Number",
//                       controller: TextEditingController(),
//                       titleInLeft: true,
//                       titleSizeboxWidth: 90,
//                       bottomPadding: false,
//                     ),
//                   ),
//                   Obx(
//                     () => RadioRow1(
//                       items: [
//                         "Booked",
//                         "On Hold",
//                         "Expsoure Spots",
//                       ],
//                       groupValue: controller.selectRadioValue.value ?? "",
//                       onchange: (String v) {
//                         controller.selectRadioValue.value = v;
//                         controller.selectRadioValue.refresh();
//                         controller.getStatus();
//                       },
//                     ),
//                   ),
//                   // Obx(() {
//                   //   return RadioRow(
//                   //     // items: items,
//                   //     items: [
//                   //       "Booked",
//                   //       "On Hold",
//                   //       "Expsoure Spots",
//                   //     ],
//                   //     groupValue: controller.selectRadioValue.value,
//                   //     onchange: (String v) {
//                   //       controller.selectRadioValue.value = v;
//                   //       controller.selectRadioValue.refresh();
//                   //       controller.getStatus();
//                   //     },
//                   //   );
//                   // }),
//                   // SizedBox(
//                   //   width: 10,
//                   // ),
//                   FormButtonWrapper(
//                     btnText: "Show",
//                     callback: () {
//                       // controller.pickFile();
//                     },
//                     showIcon: false,
//                   ),
//                 ],
//               ),

//               CheckBoxWidget1(title: "Select All"),

//               const SizedBox(height: 10),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                   ),
//                 ),
//               ),

//               SizedBox(
//                 height: 10,
//               ),

//               SizedBox(
//                 width: 150,
//                 child: FormButton(
//                   btnText: "Undo Spot",
//                   callback: () {},
//                   showIcon: false,
//                 ),
//               ),

//               // ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Get.find<HomeController>().getCommonButton(
//                   Routes.UNDO_CANCELATION,
//                   (btnName) {},
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ));
//   }
// }
