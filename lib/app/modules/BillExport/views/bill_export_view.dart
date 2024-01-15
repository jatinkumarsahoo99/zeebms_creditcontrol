import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bill_export_controller.dart';

class BillExportView extends GetView<BillExportController> {
  const BillExportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BillExportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BillExportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
