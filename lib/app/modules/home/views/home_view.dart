import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../formations/views/formations_list_view.dart';
import '../../formations/controllers/formations_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    // Injection du controller si non déjà présent
    Get.put(FormationsController());
    return Scaffold(
      appBar: AppBar(title: const Text('Accueil'), centerTitle: true),
      body: const FormationsListView(),
    );
  }
}
