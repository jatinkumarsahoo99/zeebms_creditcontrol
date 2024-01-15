import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/email_bill_details_controller.dart';

class EmailBillDetailsView extends GetView<EmailBillDetailsController> {
  const EmailBillDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmailBillDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EmailBillDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
