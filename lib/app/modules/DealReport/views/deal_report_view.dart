import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/deal_report_controller.dart';

class DealReportView extends GetView<DealReportController> {
  const DealReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DealReportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DealReportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
