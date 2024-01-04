import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/r_o_audit_controller.dart';

class ROAuditView extends GetView<ROAuditController> {
  const ROAuditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ROAuditView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ROAuditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
