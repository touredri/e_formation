import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/models.dart';
import '../controllers/formations_controller.dart';
import 'quiz_view.dart';

class FormationDetailView extends StatelessWidget {
  final Formation formation;
  const FormationDetailView({Key? key, required this.formation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FormationsController>();
    final inscrit = controller.isUserInscrit(formation.id);
    // TODO: Récupérer la vraie progression
    double progression = 0.5;
    return Scaffold(
      appBar: AppBar(title: Text(formation.titre)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formation.description, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Durée : ${formation.duree}h'),
            const SizedBox(height: 24),
            if (!inscrit)
              ElevatedButton(
                onPressed: () => controller.inscrireAFormation(formation.id),
                child: const Text("S'inscrire à cette formation"),
              ),
            if (inscrit)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Progression :'),
                  LinearProgressIndicator(value: progression),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: progression >= 1.0
                        ? () =>
                              Get.to(() => QuizView(formationId: formation.id))
                        : null,
                    child: const Text('Passer le quiz'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
