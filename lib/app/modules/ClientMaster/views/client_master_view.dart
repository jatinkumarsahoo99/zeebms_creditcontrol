import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/client_master_controller.dart';

class ClientMasterView extends GetView<ClientMasterController> {
  const ClientMasterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClientMasterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ClientMasterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
