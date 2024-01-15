import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/email_bill_details_view.dart';

class EmailBillDetailsController extends GetxController {
  //TODO: Implement EmailBillDetailsController

  double widthRatio = 0.18;
  Rx<Mode> calendarView = Rx<Mode>(Mode.bills);
  Rx<String> selectRadio = Rx<String>("Summary");
  RxBool sendTest = RxBool(false);
  RxBool all1 = RxBool(false);
  RxBool all2 = RxBool(false);
  TextEditingController counter1 = TextEditingController(text: "0");
  TextEditingController counter2 = TextEditingController(text: "0");

  @override
  void onInit() {
    super.onInit();
  }

  formHandler(btn) {}
}
