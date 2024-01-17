import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/email_bill_details_view.dart';

class EmailBillDetailsController extends GetxController {

  double widthRatio = 0.24;
  double widthRatio1 = 0.53;
  double widthOfTab = 100;

  Rx<Mode> calendarView = Rx<Mode>(Mode.bills);
  Rx<String> selectRadio = Rx<String>("Summary");

  RxBool sendTest = RxBool(false);
  RxBool all1 = RxBool(false);
  RxBool all2 = RxBool(false);

  TextEditingController counter1_ = TextEditingController(text: "0");
  TextEditingController counter2_ = TextEditingController(text: "0");
  
  TextEditingController testTo_ = TextEditingController();
  TextEditingController path_ = TextEditingController();
  TextEditingController body_ = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  formHandler(btn) {}
}
