import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/formations_controller.dart';
import '../../../data/models/models.dart';
import 'formation_detail_view.dart';

class FormationsListView extends GetView<FormationsController> {
  const FormationsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }
      if (controller.formations.isEmpty) {
        return const Center(child: Text('Aucune formation disponible.'));
      }
      return ListView.builder(
        itemCount: controller.formations.length,
        itemBuilder: (context, index) {
          final Formation formation = controller.formations[index];
          final inscrit = controller.isUserInscrit(formation.id);
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(formation.titre),
              subtitle: Text(formation.description),
              trailing: ElevatedButton(
                onPressed: inscrit
                    ? null
                    : () => controller.inscrireAFormation(formation.id),
                child: Text(inscrit ? 'Continuer' : 'S\'inscrire'),
              ),
              onTap: () {
                Get.to(() => FormationDetailView(formation: formation));
              },
            ),
          );
        },
      );
    });
  }
}
