import 'package:get/get.dart';

class UndoCancelationController extends GetxController {
  //TODO: Implement UndoCancelationController

  final count = 0.obs;
  Rxn<String> selectRadioValue = Rxn<String>(null);
  // var selectRadioValue = "".obs;

  bool booked = false;
  bool onHold = false;
  bool expsoureSpots = false;

  getStatus({String? sel}) {
    switch (sel) {
      case "Booked":
        booked = true;
        onHold = false;
        expsoureSpots = false;
        break;
      case "On Hold":
        booked = false;
        onHold = true;
        expsoureSpots = false;
        break;
      case "Expsoure Spots":
        booked = false;
        onHold = false;
        expsoureSpots = true;
        break;
      default:
        booked = false;
        onHold = false;
        expsoureSpots = false;
    }
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
