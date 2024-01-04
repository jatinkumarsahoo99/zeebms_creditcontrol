import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/asrun_import_secondary_events_controller.dart';

class AsrunImportSecondaryEventsView
    extends GetView<AsrunImportSecondaryEventsController> {
  const AsrunImportSecondaryEventsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AsrunImportSecondaryEventsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AsrunImportSecondaryEventsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
